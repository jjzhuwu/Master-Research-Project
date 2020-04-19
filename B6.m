fileID = fopen('result.txt', 'w');

fprintf(fileID,'Result\n\n');
fprintf(fileID, 'c best_p best_a best_b');

margin=power(10,-3);

tables=zeros(1/margin, 4);

parfor cc=1:1:(1/margin)
    
    c = cc*margin;
    [p a b]=B5_prop_6_p(c,2-c);
    tables(cc, :) = [c p a b];
end

for i=1:(1/margin)
    fprintf(fileID,'%6.4f %6.4f %6.4f %6.4f\n', [tables(i,1) tables(i,2) tables(i,3) tables(i,4)]);
end

fclose(fileID);