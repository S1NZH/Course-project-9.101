% Подпрограмма вывода на печать результатов расчета
%
function [POP5] = PECAT
%
global NPT KPD IPKP KPDSR D Q IP 
%
for I1=1:NPT-1  
Q(I1)=0;
if IPKP(I1+1) > 0      
Q(I1)=IPKP(I1)/IPKP(I1+1);
end
end     
KPDSR=0; IKPD=0;
for I1=1:NPT      
if IPKP(I1) > 0    
KPDSR=KPDSR+KPD(I1);
IKPD=IKPD+1;
end               
I11=I1;
IP(I1)=I11;     
end
IMAX=0;
IMIN=1000;
for IU=1:NPT
    if IPKP(IU) <= 0
        continue
    end
    if IPKP(IU) > IMAX
        IMAX=IPKP(IU);
    end
    if IPKP(IU) < IMIN
        IMIN=IPKP(IU);
    end
end
D=IMAX/IMIN;
KPDSR=KPDSR/IKPD;
if NPT == 1, [POP]=PRINT1; end    
if NPT == 2, [POP]=PRINT2; end
if NPT == 3, [POP]=PRINT3; end
if NPT == 4, [POP]=PRINT4; end
if NPT == 5, [POP]=PRINT5; end
if NPT == 6, [POP]=PRINT6; end
if NPT == 7, [POP]=PRINT7; end
if NPT == 8, [POP]=PRINT8; end
if NPT == 9, [POP]=PRINT9; end
if NPT == 10, [POP]=PRINT10; end
if NPT == 11, [POP]=PRINT11; end
POP5=3;
fprintf ('\n РЕШЕНИЕ ОКОНЧЕНО\n');
end

