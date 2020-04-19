goal_precise = 0.00001;
curr_precise = 0.01;

a_low = 0;
a_high = 3;
b_low = curr_precise;
b_high = 3;

while curr_precise >= goal_precise
    p_max = 1;
    a_max = 0;
    b_max = 0;

    for a = a_low:curr_precise:a_high
        for b = b_low:curr_precise:b_high
            c = 3-a-b;
            
            if c >= 0

                M = [[(a^2+b^2+c^2)/36+a*c/12, (a*b+b*c)/12]; [(a*b+b*c)/18,(a^2+b^2+c^2+a*c)/18]];

                r = eigs(M, 1);

                %{
                 p = 1:0.0001:1.3;
                y = power(3*r, 1/2)-power((power(a, p)+power(b, p)+power(c, p))/3, 1./p);
                plot(p, y)
                hold on;
                plot(p, zeros(1, size(p, 2)))
                %}
                p1 = 1;
                p2 = 1.3;

                while p2-p1 > curr_precise/1000000
                    mid = (p1+p2)/2;
                    y = power(3*r, 1/2)-power((power(a, mid)+power(b, mid)+power(c, mid))/3, 1/mid);
                    if y > 0
                        p1 = mid;
                    else
                        p2 = mid;
                    end
                end

               % y = power(3*r, 1/2)-power((power(a, p2)+power(b, p2)+power(c, p2))/3, 1/p2);
               % if y > 0
               %     p_curr = p2;
               % else
               %     p_curr = p1;
               % end

               p_curr = p1;
                if (p_curr > p_max)
                    p_max = p_curr;
                    a_max = a;
                    b_max = b;
                end
                disp([a b p_curr p_max])
            end
        end
    end
    
    a_low = max(a_max-curr_precise, 0);
    a_high = min(a_max+curr_precise, 3);
    
    b_low = max(b_max-curr_precise, curr_precise/10);
    b_high = min(b_max+curr_precise, 3);
    curr_precise = curr_precise/10;
end