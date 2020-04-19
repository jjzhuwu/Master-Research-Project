fileID = fopen('result.txt', 'w');
include_0 = false; % switch to true if we need 0 in E
N = 3;

fprintf(fileID,'Result\n\n');

Cn = [0 2];
for n = 2:N
    Cn = [Cn 2*power(3, n-1)+Cn];
end

nCn = -Cn;

Cn_nCn = zeros(1, 2*power(3, N)-1);

for i = 1:power(2, N)
    Cn_nCn(1, power(3,N)+nCn(i)+Cn) = Cn_nCn(1, power(3,N)+nCn(i)+Cn)+1;
end

for j=1:power(3, N)-1
    
    bestE = zeros(0, j);
    maxSum = 0;
    
    E = 1:j;
    
    while E(1) < power(3, N)+1-j
    
        F = [E -E];
        if include_0   
            F = [F 0]; 
        end
        
        nF = -F;
        F_nF = zeros(1, 2*power(3, N)-1);

        for i = 1:size(F, 2)
            potential_indices = power(3,N)+nF(i)+F;
            potential_indices = potential_indices(1, 0 < potential_indices & potential_indices < 2*power(3, N));
            F_nF(1, potential_indices) = F_nF(1, potential_indices)+1;
        end 
    
        this_sum = Cn_nCn*F_nF';
        if this_sum > maxSum
            maxSum = this_sum;
            bestE = E;
        elseif this_sum == maxSum
            bestE = [bestE; E];
        end
        
        % increment E by next permutation
        if E(j) < power(3, N)-1
            E(j) = E(j)+1;
        else
            ind = j;
            while ind > 1 && E(ind) >= power(3,N)-j+ind-1
                ind = ind-1;
            end
            E(ind) = E(ind)+1;
            ind=ind + 1;
            while ind <= j
                E(ind)=E(ind-1)+1;
                ind=ind+1;
            end
        end
    end
    fprintf(fileID, 'j = %i, max sum = %i\n', [j maxSum]);
    for k = 1:size(bestE, 1)
        fprintf(fileID, '0, ');
        for l = 1:size(bestE, 2)
            fprintf(fileID, '%i, ', bestE(k, l));
        end
        fprintf(fileID, '\n');
    end
end