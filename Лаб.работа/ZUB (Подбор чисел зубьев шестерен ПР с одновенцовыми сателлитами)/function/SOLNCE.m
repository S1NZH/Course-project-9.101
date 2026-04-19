function [pr] = SOLNCE (IRED,AST,ZS1)
%
global fid
pr=1;
ZS1S=ZS1;
for jkl=1:4
for iuy=1:120
ZK3=ZS1*IRED;
ZK3=round(ZK3);
ZST1=ZK3-ZS1;
GF=rem(ZST1,2);
ZST1=ZST1/2;
if GF==0
CC1=ZK3+ZS1;
PRED=ZK3/ZS1;
RCC1=rem(CC1,AST);
PAW=abs(PRED-IRED);
if RCC1==0
if PAW<=0.02
APR=(ZK3-ZS1+4)/(ZK3+ZS1);
BPR=sin(pi/AST);
if APR<=BPR
IAST=AST;
IZS1=ZS1;
IZST1=ZST1;
IZK3=ZK3;
fprintf(fid,'\n k= %6.3f A(CT)= %3i Z(ÌÖÊ)= %3i Z(CT)= %3i Z(ÁÖÊ)= %3i',PRED,IAST,IZS1,IZST1,IZK3);
end
end
end
end
ZS1=ZS1+1;
end
AST=AST+1;
ZS1=ZS1S;
end
end

