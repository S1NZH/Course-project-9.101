function  [RRR]  = POISKX3(XX)
global M BETTA PROM ALFA AW XX1 Z1 Z2 KZAC1 ALFATW A
%
if KZAC1 > 0, A=(Z2+Z1)*M/(2.*cos(BETTA)); end
if KZAC1 < 0, A=(Z2-Z1)*M/(2.*cos(BETTA)); end
SUM=XX1+XX;
XD=XX-XX1;
PROM=tan(ALFA)/cos(BETTA);
ALFAT=atan(PROM);
INVA=tan(ALFAT)-ALFAT;
if KZAC1 > 0, PROM=2.*XSUM*tan(ALFA)/(Z2+Z1); end
if KZAC1 < 0, PROM=2.*XD*tan(ALFA)/(Z2-Z1); end
%fprintf ('\n PROM=%g INVA= %g',PROM,INVA);
PROM=PROM+INVA; 
options=optimset('tolX',1.e-10);
%
[ALFATW]=fminbnd(@GG3,0.11,1.8,options);
%
AW2=A*cos(ALFAT)/cos(ALFATW);
RRR=AW-AW2; 
end

