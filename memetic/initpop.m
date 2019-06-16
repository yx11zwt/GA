function pop=initpop(popsize) 
% initpop.m函数的功能是实现群体的初始化
% popsize表示群体的大小，chromlength表示染色体的长度(二值数的长度)，
% 长度大小取决于变量的二进制编码的长度(在本例中取20位)。

% pop=round(rand(popsize,chromlength));     %原程序
ran=[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];
% 26个0 24个1
%ran=[0 0 0 0 0 0 0 1 1 1 1 1 1 1];%7_0 6_1
%ran=[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1];%32
%ran=[0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1];%28
%ran=[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]
pop=zeros(popsize,(length(ran)+2));
for i=1:popsize
    A=ran(randperm(numel(ran)));
    code=[1,A,1];
    pop(i,:)=code;
end
% rand随机产生每个单元为 {0,1} 行数为popsize，列数为chromlength的矩阵，
% round对矩阵的每个单元进行取整。这样产生的初始种群。
