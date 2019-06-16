function x1= encode(code)
[M,N] = size(code);
sum = zeros(N);
for i=1:M
    for j=1:N
        sum(i)=sum(i)+code(i,j)*2^(N-j);
    end
    x1(i) = -3.0 + sum(i)*(12.1-(-3.0))/(2^N - 1);
end