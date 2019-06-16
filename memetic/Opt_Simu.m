function [xo,fo] = Opt_Simu(f,x0,u,l,kmax,q,TolFun)  
% 模拟退火算法求函数 f(x)的最小值点， 且 l <= x <= u  
% f为待求函数，x0为初值点，l，u分别为搜索区间的上下限，kmax为最大迭代次数  
% q为退火因子，TolFun为函数容许误差  
%%%%算法第一步根据输入变量数，将某些量设为缺省值  
if nargin < 7  
    TolFun = 1e-8;  
end  
if nargin < 6  
    q = 1;  
end  
if nargin < 5  
    kmax = 100;  
end  
%%%%算法第二步，求解一些基本变量  
N = length(x0); %自变量维数  
x = x0;  
fx = feval(f,x); %函数在初始点x0处的函数值  
xo = x;  
fo = fx;  
%%%%%算法第三步，进行迭代计算，找出近似全局最小点  
for k =0:kmax  
    Ti = (k/kmax)^q;  
    mu = 10^(Ti*100); % 计算mu  
    dx = Mu_Inv(2*rand(size(x))-1,mu).*(u - l);%步长dx  
    x1 = x + dx; %下一个估计点  
    x1 = (x1 < l).*l +(l <= x1).*(x1 <= u).*x1 +(u < x1).*u; %将x1限定在区间[l,u]上  
    fx1 = feval(f,x1);  
    df = fx1- fx;  
    if df < 0||rand < exp(-Ti*df/(abs(fx) + eps)/TolFun) %如果fx1<fx或者概率大于随机数z  
        x = x1;  
        fx = fx1;  
    end  
    if fx < fo  
        xo = x;  
        fo = fx1;  
    end  
end  
function x = Mu_Inv(y,mu)  
x = (((1+mu).^abs(y)- 1)/mu).*sign(y);  