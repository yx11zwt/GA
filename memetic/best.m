function [bestindividual, bestfit]=best(pop, fitvalue)
%求出群体中最大的适应值及其个体
[px,py]=size(pop);
bestindividual=pop(1,:);
bestfit=fitvalue(1);
for i=2:px
    if fitvalue(i)>bestfit
        bestindividual=pop(i,:);
        bestfit=fitvalue(i);
    end
end        
