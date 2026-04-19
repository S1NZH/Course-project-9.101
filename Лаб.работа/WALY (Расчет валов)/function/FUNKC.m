function [Z] = FUNKC(A,d,TAUMAX)
global TAU do
%
Z=0;
for II=1:10
    do=d/1000;
    NPR=0;
    DN=(d+A)/1000;
%    
    [X] = fzero(@DIAMETR,DN);
%
if abs(TAU) < 1 
    A=A-5; 
    if A < 0
        fprintf ('\n Решениние не найдено')
        NPR=1;
        break
    end
    continue; 
end
break
end
%fprintf ('\n TAU = %g',TAU);
if NPR == 0
    TAU=TAUMAX-TAU/10^6;
    if abs(TAU) < 0.1, TAU=0; end
    X=abs(1000*X);
    do=1000*do;
    fprintf ('\n Минимальный внешний диаметр вала D = %g, мм',X)
    fprintf ('\n Внутренний диаметр вала d = %g, мм',do)
    fprintf ('\n************************************************');
    fprintf ('\n Ошибка решния составляет - %g, МПа.',TAU);
    fprintf ('\n================================================');
    fprintf ('\n РЕШЕНИЕ ОКОНЧЕНО');
end
end

