%ÂÖÅÌ¶ÄÑ¡Ôñ
function [B]=seclection(fitness,A)
    [M,N]=size(A);
    fit_sum = sum(fitness);
    for i = 1:M
        probability(i) = fitness(i)/fit_sum;
    end
    for i = 2:M
        probability(i) =probability(i) + probability(i-1);
    end
    for j = 1:M
        p = rand();
        i = 1;
        while p > probability(i)
              i = i+1;
        end
        B(j,:) = A(i,:);
    end