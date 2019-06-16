function [newpop]=selection(pop,fitvalue) %程序中采用赌轮盘选择法选择实现
totalfit=sum(fitvalue); %求适应值之和
fitvalue=fitvalue/totalfit; %单个个体被选择的概率
fitvalue=cumsum(fitvalue); %如 fitvalue=[1 2 3 4]，则 cumsum(fitvalue)=[1 3 6 10] 
[px,py]=size(pop);
ms=sort(rand(px,1)); %从小到大排列
fitin=1;  newin=1;
while newin<=px %蒙特卡洛方法抽样
    if(ms(newin))<=fitvalue(fitin)
        newpop(newin,:)=pop(fitin,:);
        newin=newin+1;
    else
        fitin=fitin+1;
    end
end
