goal_precise = 0.000001;
curr_precise = 0.0001;

a_low = curr_precise;
a_high = 3;

while curr_precise >= goal_precise
    p_max = 1;
    a_max = 0;

    for a = a_low:curr_precise:a_high
        c = 3-a;              

        m0 = a^4/162+a^3*c/81+2*a^2*c^2/81+a*c^3/81+c^4/162;
        m4 = a^4/324+a^3*c/81+5*a^2*c^2/324+a*c^3/81+c^4/324;
        m8 = a^3*c/162+a^2*c^2/162+a*c^3/162;
        m12 = a^2*c^2/324;
        
        M = [[m8, m4, 0];[m12, m0, m12];[0, m4, m8]];
        r = eigs(M, 1);
        T_rate = power(3*r, 1/2);
        
        p1 = 1;
        p2 = 1.3;

        while p2-p1 > curr_precise/1000000
            mid = (p1+p2)/2;
            y = T_rate-power(a^(2*mid)+2^mid*a^mid*c^mid+c^(2*mid), 1/mid)/power(3, 1+1/mid);
            if y >= 0
                p1 = mid;
            else
                p2 = mid;
            end
        end

        y = r-power(a^(2*p2)+2^p2*a^p2*c^p2+c^(2*p2), 1/p2)/power(3, 1+1/p2);
        if y >= 0
            p_curr = p2;
        else
            p_curr = p1;
        end

        if (p_curr > p_max)
            p_max = p_curr;
            a_max = a;
        end
        disp([a p_curr p_max])
    end
    
    a_low = a_max-curr_precise;
    a_high = a_max+curr_precise;
    
    curr_precise = curr_precise/10;
end