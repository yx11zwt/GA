clear all;
close all;
tic;
%%  参数设置
popsize = 50;   %种群大小
pop = initpop(popsize); %初始种群
pc = 0.85;   %交叉
pm = 0.01;    %变异
t=100;    % 初始温度
tf = 25;    % 稳定温度
a = 0.95;    % 温度下降比率

%% 遗传算法
for i=1:50
    [objvalue]=calobjvalue(pop,popsize);%计算目标函数
    E_current=calfitvalue(objvalue);%计算群体中每个个体的适应度
    [newpop]=selection(pop,E_current); %复制
    [newpop]=crossover(newpop,pc); %交叉
    [newpop]=mutation(newpop,pm); %变异
    [objvalue1]=calobjvalue(newpop,popsize);
    E_new=calfitvalue(objvalue1);

   %%      %开始退火模型
    while t>=tf%（7）结束条件 
    %%  进行随机扰动
        k=round(rand(1,1)*popsize);
        if k==0
            k=k+1;
        end
        r=round(rand(1,1)*32);  %52表示个体数目，改变码字长度时要进行修改
       if r==0
            r=r+1;
        end
        R=rand(1,1);      
        copypop=newpop;
        if newpop(k,r)==0;
            copypop(k,r)=1;
        else
            copypop(k,r)=0;
        end
        %%  比较扰动后的自适应度H
       [objvalue2]=calobjvalue(copypop,popsize);
        E_rao=calfitvalue(objvalue2);
        H=E_rao(k,:)-E_new(k,:)
        if H<0&&R>exp((H)/t)
            newpop=newpop;
        else
            newpop=copypop;
            E_new(k,:)=E_rao(k,:);
            
        end  
        t=t*a;%（6）降温  
    end
    %% 更新种群并挑选出最优的个体编入一个新的种群
        pop=newpop;
        [bestindividual,bestfit]=best(pop,E_new); %求出群体中适应值最大的个体及其适应值
        y(i)=bestfit; %最佳个体适应度
        bestpop(i,:)=bestindividual;
%          code1=bestindividual;
%          fcode1=abs(fft(code1,512))
%          w=var(fcode1);
%          W=min(fcode1);
        if bestfit>35    %设置的结束条件
            break;
        end
end
%         
%         plot(i,E_best,'*')  
%         hold on 
%% 设定若迭代50次结束，则寻找出50次里面的最优个体适应度
   if i==50
   [objvalue3]=calobjvalue(bestpop,popsize);%计算目标函数
    E_best=calfitvalue(objvalue3);%计算群体中每个个体的适应度   
    [bestindividual,bestfit]=best(bestpop,E_best);
    code1=bestindividual;
   else
       code1=bestindividual;
   end
   
%   code1=[1 1 0 0 0 1 0 0 0 0 1 0 0 1 1 1 1 0 1 0 1 1 0 0 0 0 0	0 0 1 0	1 1	1 0	1 0	0 0	0 0	1 0	1 1	0 0	0 0	0 0	1]
  fcode1=abs(fft(code1,512));%/max(abs(fft(code1)));
  plot(fcode1);
  xlabel('f(Hz)');
  ylabel('对数幅值');
%   axis([0 17 0 2]);
  print(gcf,'-dtiff','test4.tiff');
  w=var(fcode1);
  W=min(fcode1);

toc;



%[1,1,1,0,1,0,1,0,1,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,0,1,1,0,0,0,0,1,1,0,0,0,1,1,1,1,0,1]
%
