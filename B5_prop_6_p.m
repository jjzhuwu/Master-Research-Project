function [p_best a_best b_best] = B5_prop_6_p(c,d)

a_lower=0;
a_higher=1;
a_best=0;

b_lower=0;
b_higher=1;
b_best=0;

p_best=1;

margin=power(10,-4);

for a=a_lower:margin:a_higher
    for b=max(b_lower, a):margin:min(b_higher, (1+a)/2)
        LHS=power(power(c,2)+power(d,2),a)/(6*power(a,a)*power(b-a,2*(b-a))*power(1+a-2*b,1+a-2*b));
        RHS_denominator=3*power(b,b)*power(1-b,1-b);

        p_high=2;
        p_low=1;
        while p_high-p_low>margin
            p_mid=(p_low+p_high)/2;
            RHS=power(power(power(c,p_mid)+power(d,p_mid),b)/RHS_denominator,2/p_mid);
            if RHS<LHS
                p_low=p_mid;
            else
                p_high=p_mid;
            end
        end

        if power(power(power(c,p_high)+power(d,p_high),b)/RHS_denominator,2/p_high)<LHS
            p=p_high;
        else
            p=p_low;
        end
        if p>p_best
            a_best=a;
            b_best=b;
            p_best=p;
        end
    end
    disp([c a p_best])
end