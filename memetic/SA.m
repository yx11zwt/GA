clear  
clc  
tic 
%生成初始解 
popsize=50;
pop=initpop(popsize);
% %（1）解空间（初始解）  
% sol_new1=pop;  
% sol_best1 = sol_new1;   
E_best = -inf;  


pc=0.85; %交叉概率
pm=0.01; %变异概率
% rand(50,52); %初始化随机数发生器  
t=90; %初始温度  
tf=89.9; %结束温度  
a = 0.95; %温度下降比例  
  
while t>=tf%（7）结束条件  
    for r=1:50 %退火次数  
          
        %产生随机扰动（3）新解的产生 
        [objvalue]=calobjvalue(pop,popsize)
        E_current=calfitvalue(objvalue);
        [newpop]=selection(pop,E_current); %复制
        [newpop]=crossover(newpop,pc); %交叉
        [newpop]=mutation(newpop,pm); %变异
        [objvalue1]=calobjvalue(newpop,popsize);
        R=rand(1,1);
        
%         sol_new2=sol_new2+rand*0.2;  
%         sol_new1=sol_new2+rand*0.2;  
%           
        %检查是否满足约束  
%         if sol_new1^2-sol_new2>=0 &&  sol_new1>=0 &&sol_new2>=0  
%         else  
%             sol_new2=rand*2;  
%             sol_new1=sol_new1;  
%             continue;  
%         end  
          
        %退火过程  
        E_new=calfitvalue(objvalue1);%（2）适应度  
        if E_new>E_current%（5）接受准则  
                E_current=E_new;
                pop=newpop;  
              
%                 
%                 if E_new>E_best  
%                     %把冷却过程中最好的解保存下来
%                     E_best=E_new;  
%                     sol_best1=newpop;
%                 end  
        else  
                if R<exp((E_new-E_current)/t)%（4）代价函数差  
  
                    pop=newpop; 
                    E_current=E_new;
                else  
                    pop=pop;
                end  
        end 
        [bestindividual,bestfit]=best(pop,E_current); %求出群体中适应值最大的个体及其适应值
        y(r)=bestfit; %最佳个体适应度
        bestpop(r,:)=bestindividual;
        plot(r,E_best,'*')  
        hold on  
    end  
    t=t*a;%（6）降温  
end  
 

  code1=bestindividual;
% code2=[1 0 0 0 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0 1 1 0 1 0 0 1 1 0 0 0 1 0 0 0 0 0 0 0 0 1];
  fcode1=abs(fft(code1,512));%/max(abs(fft(code1)));
  plot(fcode1);
  xlabel('f(Hz)');
  ylabel('H(jw)');
  axis([0 512 0 8]);
  print(gcf,'-dtiff','test3.tiff');
  
  h=var(fcode1);
  H=min(fcode1);
% fcode2=abs(fft(code2,512));%/max(abs(fft(code2)));
% plot(fcode1,'-');hold on;
% plot(fcode2,':');hold off;
% disp('最优解为：')  
% disp(pop)  ;
% 
% disp('目标表达式的最小值等于：')  
% disp(E_best)  
toc;

% c=imread('test1.tiff');
% figure,imshow(c);