function [p] = SATELLIT(IRED,AST,ZST1)
global fid
p=2;
ZST1S=ZST1;
for jkl=1:4
for iuy=1:120
ZS1=2*ZST1/(IRED-1);
ZS1=round(ZS1);
ZK3=2*ZST1+ZS1;
CC1=ZK3+ZS1;
RCC1=rem(CC1,AST);
CC1=CC1/AST;
PRED=ZK3/ZS1;
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
fprintf(fid,'\n k= %6.3f A(CT)= %2i Z(ÌÖÊ)= %3i Z(CT)= %3i Z(ÁÖÊ)= %3i',PRED,IAST,IZS1,IZST1,IZK3);
end
end
end
ZST1=ZST1+1;
end
AST=AST+1;
ZST1=ZST1S;
end
end


