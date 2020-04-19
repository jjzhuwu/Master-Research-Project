goal_precise = 0.000001;
curr_precise = 0.0001;

a_low = 0;
a_high = 3/2;

while curr_precise >= goal_precise
    p_max = 1;
    a_max = 0;

    for a = a_low:curr_precise:a_high
        c = 3-a;              

        r = power((a*a+c*c+a*c)/6, 1/2);
        
        p1 = 1;
        p2 = 1.3;

        while p2-p1 > curr_precise/1000000
            mid = (p1+p2)/2;
            y = r-power((power(a, mid)+power(c, mid))/3, 1/mid);
            if y >= 0
                p1 = mid;
            else
                p2 = mid;
            end
        end

        y = r-power((power(a, p2)+power(c, p2))/3, 1/p2);
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