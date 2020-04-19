m =2;
b = floor((m-1)/2);

A = zeros(b*2+1);

for i = b:-1:-b
    for j = b:-1:-b
        if and((i+m-3*j) >= 0, (i+m-3*j) <= 2*m)
            A(b+1-i, b+1-j) = nchoosek(2*m, i+m+3*j);
        end
    end
end

% disp(sum(A, 2)')
r = eigs(A, 1)/4^m;
% g = sqrt(3*r);

disp([r 3*r])