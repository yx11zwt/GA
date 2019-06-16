% This example is used to explain the GA.
%  max f(x1, x2) = 21.5 + x1·sin(4pi*x1) + x2·sin(20pi*x2)
%  s.t.    -3.0 <=  x1 <= 12.1
%           4.1 <=  x2 <= 5.8
clc; clear all;
M = 40;N = 33;
generation = 1000;
it = 1;
pm = 0.05;%变异概率
pc = 0.8;%交叉概率
maxdata = -200;
pop = round(rand(M,N));%初始化矩阵，产生初始种群                      
x1 = decode_x1(pop(:,1:18));  %对x1 x2进行解码
x2 = decode_x2(pop(:,19:end));
fitness = 21.5 + x1.*sin(4*pi*x1) +x2.*sin(20*pi*x2);%适应度函数
while it < generation
    [B] = seclection(fitness,pop);%轮盘赌选择
    [newpop] = crossover(pc,B);%交叉
    [B] = mutation(pm,newpop);%变异操作
    pop = B;
    x1 = decode_x1(pop(:,1:18));
    x2 = decode_x2(pop(:,19:end));
    fitness = 21.5 + x1.*sin(4*pi*x1) +x2.*sin(20*pi*x2);%计算适应度
    [fit_best,index] = max(fitness);%本代中的最优目标值
    if fit_best >= maxdata
        maxdata = fit_best;
        verter = pop(index,:);
        x_1 = decode_x1(verter(1:18));
        x_2 = decode_x2(verter(19:end));
    end
    num(it) = maxdata;
    it = it + 1;
end
disp(sprintf('max_f=：%.6f',num(it-1)));%输出最优解
disp(sprintf('x_1=：%.5f  x_2=：%.5f',x_1,x_2));%最优解对应的x1 x2的值
figure(1)   
plot(num,'k');%绘制图形