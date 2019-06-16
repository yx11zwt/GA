function fitvalue=calfitvalue(objvalue)
%使目标函数值均为正值
% global Cmin;
fitvalue=objvalue-min(objvalue);
