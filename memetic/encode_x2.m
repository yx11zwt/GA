function x2=encode_x2(code)
[M,N] = size(code);
sum = zeros(N);
for i=1:M
    for j=1:N
        sum(i)=sum(i)+code(i,j)*2^(N-j);
    end
    x2(i) = 4.1 + sum(i)*(5.8 - 4.1)/(2^N - 1);
end