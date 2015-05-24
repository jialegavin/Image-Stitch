function [solution1 , solution2]=findGain(I1,I2);
yipN=10;
yipg=0.1;
syms g1 g2;

% [s1 s2]=solve(4*I1*(g1*I1-g2*I2)/(yipN^2)-2*(1-g1)/(yipg^2)+((1-g2)/yipg)^2==0,-4*I2*(g1*I1-g2*I2)/(yipN^2)+(1-g1)^2/(yipg^2)-2*(1-g2)/(yipN^2)==0,g1,g2);
[s1 s2]=solve(4*I1*(g1*I1-g2*I2)/(yipN^2)-2*(1-g1)/(yipg^2)==0,-4*I2*(g1*I1-g2*I2)/(yipN^2)+(1-g1)^2/(yipg^2)==0,g1,g2);
se1=double(s1);
se2=double(s2);
[s1min index1]=min(abs(se1-1));
[s2min index2]=min(abs(se2-1));
solution1=se1(index1);
solution2=se2(index2);
% if(se1(1)>0)
%     if(se1(2)>0)
%         solution1=min(se1);
%     else solution1=se1(1);
%     end
% else solution1=se1(2);
% 
% end
% if(se2(1)>0)
%     if(se2(2)>0)
%         solution2=min(se2);
%     else solution2=se2(1);
%     end
% else solution2=se2(2);
% 
% end
% 

