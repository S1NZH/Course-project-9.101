function [ TTT ] = PROGRAMM ( MMM )
%
global M BW BETTA N1 IDVIJ Z X WSAT HPOVZUB1 HPOVZUB2 NPER NTERMO1 NTERMO2
global ITOCH ISAT NTER HPOVZUB NPERPOV NZAGOT LK fid ALFA
global MDVSMAX NDVSMAX ADVS NDVSSR VSR KNMCK KNVOD KMMCK SMAX AST
global NPERPOV1 NPERPOV2 NZAGOT1 NZAGOT2 ASTAL1 ASTAL2 IDVIJPOD NPER3X
global KSHEMA Z1 Z2 Z3 Z4 MMCK BETTAMCK IRASPRED KTR WWW DOLJAORIG
global STAL1 STAL2 STAL3 STAL4
%
% LKF- индекс момента циклограммы, который принимается в качестве расчетного
%
% МОДУЛЬ ЗАЦПЛЕНИЯ
NBV=0;
TTT=10;
LK=1;
% МОДУЛЬ ЗАЦПЛЕНИЯ
M=WWW(1);
% ЧИСЛО ЗУБЬЕВ МЦК, САТ(МЦК), САТ(БЦК), БЦК
Z=[WWW(2) WWW(3) WWW(4) WWW(5)];
% ТИП САТЕЛЛИТА: 
%          ISAT=1, если сателлиты одновенцовые
%          ISAT=2, если сателлиты двухвенцовые
ISAT=WWW(6);
% УГОЛ НАКЛОНА ЗУБЬЕВ (ГРАД.)
BETTA=WWW(7);
% КОЭФФИЦИЕНТЫ СМЕЩЕНИЯ (МЦК, САТ1,САТ2,БЦК)
X=[WWW(8) WWW(9) WWW(10) WWW(11)];
% ШИРИНА ЗУБЧАТОГО ВЕНЦА (MM)
BW=WWW(12);
% ЧИСЛО САТЕЛЛИТОВ
AST=WWW(13);
% СПОСОБ ТЕРМИЧЕСКОЙ ОБРАБОТКИ ПОВЕРХНОСТЕЙ ЗУБЬЕВ (МЦК, САТ1,САТ2,БЦК):
%           NTER=1 - Отжиг, нормализация или улучшение, HB
%           NTER=2 - Объемная закалка,                  HRC
%           NTER=3 - Поверхностная закалка (ТВЧ),       HRC
%           NTER=4 - Цементация,                        HRC
%           NTER=5 - Азотирование,                      HV
%           NTER=6 - Нитроцементация,                   HRC
NTER=[WWW(14) WWW(15) WWW(16) WWW(17)];
% ТВЕРДОСТЬ ПОВЕРХНОСТЕЙ ЗУБЬЕВ (МЦК, САТ1,САТ2,БЦК)
HPOVZUB=[WWW(18) WWW(19) WWW(20) WWW(21)];
% ВИД ОБРАБОТКИ ПЕРЕХОДНОЙ ПОВЕРХНОСТИ ЗУБЬЕВ (МЦК, САТ1,САТ2,БЦК)
%             NPERPOV = 0 - Не шлифованная
%             NPERPOV = 1 - Шлифованная
NPERPOV=[WWW(22) WWW(23) WWW(24) WWW(25)];
% Kоэффициент, учитывающий способ получения заготовки зубчатого колеса
% (МЦК, САТ1,САТ2,БЦК):
%             NZAGOT= 1 - Штамповка
%             NZAGOT= 2 - Прокат
%             NZAGOT= 3 - Литье
NZAGOT=[WWW(26) WWW(27) WWW(28) WWW(29)];
% Номер схемы расположения зубчатых колес относительно опор 
KSHEMA=WWW(30);
% КОЛИЧЕСТВО ПЕРЕДАЧ ПЕРЕДНЕГО ХОДА
NPER=WWW(31);
% КОЛИЧЕСТВО ПЕРЕДАЧ ЗАДНЕГО ХОДА
NPER3X=WWW(32);
% МАКСИМАЛЬНЫЙ МОМЕНТ ДВИГАТЕЛЯ, Нм
MDVSMAX=WWW(33);
% Максимальная частота вращения ведущего вала, об/мин
NDVSMAX=WWW(34);
% Коэффициент использования момента двигателя 
ADVS=WWW(35);  
% Средняя частота вращения двигателя, об/мин
NDVSSR=WWW(36);  
% Пробег до капитального ремонта, км
SMAX=WWW(37);  
% Средняя скорость, км/ч
VSR=WWW(38);  
% Коэффициент трансформации момента гидротрансформатора на стоповом режиме 
KTR=WWW(39);
% ТИП ДВИЖИТЕЛЯ:
%            IDVIJ= 1 - КОЛЕСНЫЙ
%            IDVIJ= 2 - ГУСЕНИЧНЫЙ
IDVIJ=WWW(40);

% Коэффициенты частоты вращения МЦК на передачах
for III=1:NPER+NPER3X
    KNMCK(III)=WWW(40+III);
    IKMCK=40+III;
end
% Коэффициенты частоты вращения водила на передачах
IKMCK2=IKMCK;
for III=1:NPER+NPER3X
    KNVOD(III)=WWW(IKMCK+III);
    IKMCK2=IKMCK2+1;
end
% Коэффициенты момента МЦК на передачах
IKMCK3=IKMCK2;
for III=1:NPER+NPER3X
    KMMCK(III)=WWW(IKMCK2+III);
    IKMCK3=IKMCK3+1;
end
IKMCK3=IKMCK3+1;
% КАКАЯ ГИСТОГРАММА ИСПОЛЬЗУЕТСЯ ДЛЯ РАСПРЕДЕЛЕНИЕ ВРЕМЕНИ ДВИЖЕНИЯ ПО ПЕРЕДАЧАМ:
%            IRASPRED= 0 - ОРИГИНАЛЬНАЯ
%            IRASPRED= 1 - ЗАДАННАЯ В ПРОГРАММЕ 
IRASPRED=WWW(IKMCK3);
if IRASPRED ==0
if IDVIJ == 1
    if NPER > 11
        fprintf('\n Статистика по распределению времени работы на передачах для колесных машин'); 
        fprintf('\n имеется только для КП, реализующих не более 11 передач переднего хода');
        return
    end
end
if IDVIJ == 2
    if NPER > 8
        fprintf('\n Статистика по распределению времени работы на передачах для гусеничных машин'); 
        fprintf('\n имеется только для КП, реализующих не более 8 передач переднего хода');
        return
    end
end
end
if IRASPRED == 0
    IKMCK4=IKMCK3;
% ВВОД ГИСТОГРАММЫ РАСПРЕДЕЛЕНИЕ ВРЕМЕНИ ДВИЖЕНИЯ ПО ПЕРЕДАЧАМ
%
for III=1:NPER+NPER3X
    DOLJAORIG(III)=WWW(IKMCK3+III);
    IKMCK4=IKMCK4+1;
end    
fprintf('\n ГИСТОГРАММЫ РАСПРЕДЕЛЕНИЕ ВРЕМЕНИ ДВИЖЕНИЯ ПО ПЕРЕДАЧАМ:'); 
fprintf('\n  %g  %g  %g  %g  %g  %g  %g  %g  %g  %g %g %g',DOLJAORIG);
fprintf(fid,'\n ГИСТОГРАММЫ РАСПРЕДЕЛЕНИЕ ВРЕМЕНИ ДВИЖЕНИЯ ПО ПЕРЕДАЧАМ:\n %g  %g  %g  %g  %g  %g  %g  %g  %g  %g  %g  %g',DOLJAORIG);
end
%
TTT=MMM+1;
if IRASPRED == 1
%
 if IDVIJ==2
  if ((NPER < 3) && (NPER > 8))
disp('\n  Распределения времени работы для такого количества передачах нет');
return; 
  end 
 end
end
%
fprintf('\nIDVIJ= %i',IDVIJ);
%
if(IDVIJ ~= 1)&&(IDVIJ ~= 2)
fprintf('\n  Не правильно задан тип движителя'); return; end
%
MMCK=M;
BET=BETTA;
BETTA=pi*BETTA/180;
BETTAMCK=BETTA;
IDVIJPOD=IDVIJ;
Z1=Z(1); Z2=Z(2); Z3=Z(3); Z4=abs(Z(4));
fprintf(fid,'\n     ');
fprintf(fid,'\n        ИСХОДНЫЕ ДАННЫЕ');
fprintf(fid,'\n     ');
fprintf(fid,'\nМОДУЛЬ ЗАЦПЛЕНИЯ - %5.2f',M);
fprintf(fid,'\nЧИСЛО ЗУБЬЕВ МЦК - %i САТ(МЦК) - %i САТ(БЦК) - %i БЦК - %i',Z1,Z2,Z3,Z4);
if ISAT == 1 
fprintf(fid,'\nСАТЕЛЛИТЫ ОДНОВЕНЦОВЫЕ'); 
end
if ISAT == 2
fprintf(fid,'\nСАТЕЛЛИТЫ ДВУХВЕНЦОВЫЕ');
end
fprintf(fid,'\nУГОЛ НАКЛОНА ЗУБЬЕВ (град.) - %5.2f',BET);
fprintf(fid,'\nКОЭФФИЦИЕНТЫ СМЕЩЕНИЯ: МЦК - %6.3f САТ1 - %6.3f САТ2 - %6.3f БЦК - %6.3f',X);
fprintf(fid,'\nШИРИНА ЗУБЧАТОГО ВЕНЦА (мм) - %6.2f',BW);
fprintf(fid,'\nЧИСЛО САТЕЛЛИТОВ - %i',AST); 
fprintf(fid,'\nМАРКА СТАЛИ: МЦК - %s   САТ1 - %s   САТ2 - %s   БЦК - %s',STAL1,STAL2,STAL3,STAL4);
fprintf(fid,'\nСПОСОБ ТЕРМИЧЕСКОЙ ОБРАБОТКИ ПОВЕРХНОСТЕЙ ЗУБЬЕВ: МЦК - %i САТ1 - %i САТ2 - %i БЦК - %i',NTER);
fprintf(fid,'\nТВЕРДОСТЬ ПОВЕРХНОСТЕЙ ЗУБЬЕВ: МЦК - %i САТ1 - %i САТ2 - %i БЦК - %i',HPOVZUB);
fprintf(fid,'\nВИД ОБРАБОТКИ ПЕРЕХОДНОЙ ПОВЕРХНОСТИ ЗУБЬЕВ: МЦК - %i САТ1 - %i САТ2 - %i БЦК - %i',NPERPOV);
fprintf(fid,'\nKоэффициент, учитывающий способ получения заготовки: МЦК - %i САТ1 - %i САТ2 - %i БЦК - %i',NZAGOT);
fprintf(fid,'\nНомер схемы расположения зубчатых колес относительно опор: %i',KSHEMA);
fprintf(fid,'\nКоличество передач переднего хода: %i',NPER);
fprintf(fid,'\nКоличество передач заднего хода: %i',NPER3X);
fprintf(fid,'\nМАКСИМАЛЬНЫЙ МОМЕНТ ДВИГАТЕЛЯ, Нм: %g',MDVSMAX);
fprintf(fid,'\nМаксимальная частота вращения ведущего вала, об/мин: %g',NDVSMAX);
fprintf(fid,'\nКоэффициент использования момента двигателя: %5.2f',ADVS);
fprintf(fid,'\nСредняя частота вращения двигателя, об/мин: %g',NDVSSR);
fprintf(fid,'\nПробег до капитального ремонта, км: %g',SMAX);
fprintf(fid,'\nСредняя скорость, км/ч: %g',VSR);
fprintf(fid,'\nКоэффициент трансформации момента гидротрансформатора на стоповом режиме: %5.2f',KTR);
NPP=NPER+NPER3X;
if NPP == 1, [QWE] = PRINT1(KNMCK,KNVOD,KMMCK); end
if NPP == 2, [QWE] = PRINT2(KNMCK,KNVOD,KMMCK); end
if NPP == 3, [QWE] = PRINT3(KNMCK,KNVOD,KMMCK); end
if NPP == 4, [QWE] = PRINT4(KNMCK,KNVOD,KMMCK); end
if NPP == 5, [QWE] = PRINT5(KNMCK,KNVOD,KMMCK); end
if NPP == 6, [QWE] = PRINT6(KNMCK,KNVOD,KMMCK); end
if NPP == 7, [QWE] = PRINT7(KNMCK,KNVOD,KMMCK); end
if NPP == 8, [QWE] = PRINT8(KNMCK,KNVOD,KMMCK); end  
if NPP == 9, [QWE] = PRINT9(KNMCK,KNVOD,KMMCK); end
if NPP == 10, [QWE] = PRINT10(KNMCK,KNVOD,KMMCK); end
if NPP == 11, [QWE] = PRINT11(KNMCK,KNVOD,KMMCK); end   
fprintf(fid,'\n Тип движителя: %i',IDVIJ);
%
N1=NDVSMAX;
WSAT=0;
for I=1:NPER+NPER3X
if KMMCK(I) ~= 0.
 WSA=abs(N1*Z(1)*(KNMCK(I)-KNVOD(I))/Z(2));
  if WSAT < WSA, WSAT=WSA; end 
end 
end
IPR=0;
LKJHU=3;
if Z(3) == 0, LKJHU=2; end
for II=1:LKJHU
 if (II ~= 4) && (ISAT==1)
 if IPR == 0
 if Z(II+1) == 0
 Z(II+1)=Z(II+2);
 X(II+1)=X(II+2);
 NTER(II+1)=NTER(II+2);
 HPOVZUB(II+1)=HPOVZUB(II+2);
 NPERPOV(II+1)=NPERPOV(II+2);
 NZAGOT(II+1)=NZAGOT(II+2);
 IPR=1; 
 end
KZAC=10*Z(II+1)/Z(II);
Z1=abs(Z(II));
Z2=abs(Z(II+1));
X1=X(II);
X2=X(II+1);
if II == 1 
 NTERMO1=NTER(1);
 NTERMO2=NTER(2);
 HPOVZUB1=HPOVZUB(1);
 HPOVZUB2=HPOVZUB(2);
 NPERPOV1=NPERPOV(1);
 NPERPOV2=NPERPOV(2);
 NZAGOT1=NZAGOT(1);
 NZAGOT2=NZAGOT(2);
ASTAL1=STAL1;
ASTAL2=STAL2;
end
if (II > 1)&&(IPR == 1)	
NTERMO1=NTER(2);
NTERMO2=NTER(3);
HPOVZUB1=HPOVZUB(2);
HPOVZUB2=HPOVZUB(3);
NPERPOV1=NPERPOV(2);
NPERPOV2=NPERPOV(3);
NZAGOT1=NZAGOT(2);
NZAGOT2=NZAGOT(3);
ASTAL1=STAL2;
ASTAL2=STAL3;
end
if (II>1) && (IPR==0)
 NTERMO1=NTER(2); 
 NTERMO2=NTER(3);
 HPOVZUB1=HPOVZUB(2);
 HPOVZUB2=HPOVZUB(3);
 NPERPOV1=NPERPOV(2);
 NPERPOV2=NPERPOV(3);
 NZAGOT1=NZAGOT(2);
 NZAGOT2=NZAGOT(3);
ASTAL1=STAL2;
ASTAL2=STAL3;
end
if (II==3) && (IPR==0) 
 NTERMO1=NTER(3);
 NTERMO2=NTER(4);
 HPOVZUB1=HPOVZUB(3);
 HPOVZUB2=HPOVZUB(4);
 NPERPOV1=NPERPOV(3);
 NPERPOV2=NPERPOV(4);
 NZAGOT1=NZAGOT(3);
 NZAGOT2=NZAGOT(4);
ASTAL1=STAL3;
ASTAL2=STAL4;
end
if (II==3) && (IPR~=0) 
 NTERMO1=NTER(2);
 NTERMO2=NTER(4);
 HPOVZUB1=HPOVZUB(2);
 HPOVZUB2=HPOVZUB(4);
 NPERPOV1=NPERPOV(2);
 NPERPOV2=NPERPOV(4);
 NZAGOT1=NZAGOT(2);
 NZAGOT2=NZAGOT(4);
ASTAL1=STAL2;
ASTAL2=STAL4;
end
%      ПРОВЕРКА ФУНКЦИЙ КОЛЕС (ШЕСТЕРНЯ-ЗУБЧАТОЕ КОЛЕС)
%
if Z1 > Z2
 Z1=abs(Z(II+1));
 Z2=abs(Z(II));
 X1=X(II+1);
 X2=X(II);
if II == 1
	 NTERMO1=NTER(2);
	 NTERMO2=NTER(1);
	 HPOVZUB1=HPOVZUB(2);
     HPOVZUB2=HPOVZUB(1);
	 NPERPOV1=NPERPOV(2);
	 NPERPOV2=NPERPOV(1);
	 NZAGOT1=NZAGOT(2);
	 NZAGOT2=NZAGOT(1);
ASTAL1=STAL2;
ASTAL2=STAL1;
end
if (II>1)&&(IPR==0)
	 NTERMO1=NTER(3);
	 NTERMO2=NTER(2);
     HPOVZUB1=HPOVZUB(3);
     HPOVZUB2=HPOVZUB(2);
	 NPERPOV1=NPERPOV(3);
	 NPERPOV2=NPERPOV(2);
	 NZAGOT1=NZAGOT(3);
	 NZAGOT2=NZAGOT(2);
ASTAL1=STAL3;
ASTAL2=STAL2;
%
end
end
if NBV == 0
fprintf('\n Модуль зацепления - %5.2f',M);
fprintf('\n Число сателлитов - %i',AST); 
fprintf('\n   ');
fprintf('\n Сталь 1= %s Сталь 2= %s',ASTAL1,ASTAL2);
fprintf('\n Z1= %i Z2= %i',Z1,Z2);
fprintf('\n X1= %g X2= %g',X1,X2);
fprintf('\n 1 - шестерня; 2 - зубчатое колесо.');
fprintf('\n   ');
fprintf('\n Ширина зубчатого венца (мм) - %6.2f',BW);
fprintf('\n Угол наклона зубьев (град) - %6.2f',BET);
NBV=1;
end
%fprintf('\nNTERMO1= %i NTERMO2= %i',NTERMO1,NTERMO2);
%fprintf('  HPOVZUB1= %i HPOVZUB2= %i',HPOVZUB1,HPOVZUB2);
%fprintf('\nNZAGOT1= %i,NZAGOT2= %i',NZAGOT1,NZAGOT2);
%fprintf('  NPERPOV1= %i NPERPOV1 %i',NPERPOV1,NPERPOV2);
%
IVAR=II;
%
[NPRIZ ] = DANNYE(IVAR);
if NPRIZ ~= 0, return; end
%
fprintf(fid,'\n   ');
fprintf(fid,'\n****************************************************');
fprintf(fid,'\n   ');
if II == 1
fprintf(fid,'\n      Расчет геометрии пары МЦК-Сателлит');
fprintf(fid,'\n   '); 
%end
%
[PRIZNAKH]=GEOMETR(Z1,Z2,X1,X2,KZAC,IVAR,IPR);
%
if PRIZNAKH == 2, return; end
end
%
%      УЧЕТ НЕРАВНОМЕРНОСТИ РАСПРЕДЕЛЕНИЯ НАГРУЗКИ МЕЖДУ САТЕЛЛИТАМИ
%
[BNER] = TOCHNOSTY(ITOCH,AST);
%
for IW=1:NPER+NPER3X
 KNMCK(IW)=BNER*KNMCK(IW); end
if II == 2 
fprintf(fid,'\n     ');
fprintf(fid,'\n      Расчет геометрии пары Сателлит-БЦК');
fprintf(fid,'\n     ');
ALFA=3.14*ALFA/180;
%
[PRIZNAKH] = GEOMETR(Z1,Z2,X1,X2,KZAC,IVAR,IPR);
%
if PRIZNAKH == 2, return; end
%
end  
%
if ITOCH < 6, ITOCH=6; end
IVAR=3;
%
 [AB] = DANNYE(IVAR);
%
fprintf(fid,'\n     ');
fprintf(fid,'\n****************************************************');
fprintf(fid,'\n     ');
fprintf(fid,'\n КОЭФФИЦИЕНТ НЕРАВНОМЕРНОСТИ РАСПРЕДЕЛЕНИЯ НАГРУЗКИ %5.3f', BNER);
fprintf(fid,'\n     ');	
fprintf(fid,'\n****************************************************');
%
if II == 1 
fprintf(fid,'\nРасчет на контактную прочность для ПРЯМОГО действия нагрузки ');
fprintf(fid,'\n                        МЦК-Сателлит');
fprintf(fid,'\n     '); 
end
%
if KZAC >= 0 
%
 if II == 2
 fprintf(fid,'\nРасчет на контактную прочность для ПРЯМОГО действия нагрузки '); 
 fprintf(fid,'\n                        Сателлит-БЦК'); 
 end
%
[PRICNAKH]=DOLGOWHP (1);
if PRICNAKH == 2, return; end
%
 fprintf(fid,'\n     ');
 fprintf(fid,'\n****************************************************');
 fprintf(fid,'\n     ');
 if II==1 
 fprintf(fid,'\nРасчет на контактную прочность для реверсивной нагрузки ');
 fprintf(fid,'\n                        МЦК-Сателлит');
 fprintf(fid,'\n     '); 
 end
 if II == 2
  fprintf(fid,'\nРасчет на контактную прочность для реверсивной нагрузки '); 
  fprintf(fid,'\n             Сателлит-БЦК'); 
 end
%
[PRICNAKH] = DOLGOWHP (2);
if PRICNAKH == 2, return; end
%
fprintf(fid,'\n     ');
fprintf(fid,'\n****************************************************');
fprintf(fid,'\n     ');
if II==1
 fprintf(fid,'\n        РАСЧЕТ НА ИЗГИБНУЮ ПРОЧНОСТЬ ПАРЫ МЦК-САТЕЛЛИТ');
 fprintf(fid,'\n     '); 
end  
if II==2
fprintf(fid,'\n        Расчет на изгибную прочность для пары Сателлит-БЦК');
fprintf(fid,'\n     ');
end
fprintf(fid,'\n        Расчет зубьев МЦК');
fprintf(fid,'     ');
%
LKJ=2;
[PRICNAKH]=DOLGOWFP (Z1,X1,X2,KZAC,LKJ);
if PRICNAKH==2, return; end
%
fprintf(fid,'\n     ');
fprintf(fid,'\n----------------------------------------------------');
fprintf(fid,'\n     ');
fprintf(fid,'\n        Расчет зубьев сателлита');
fprintf(fid,'\n     ');
%
LKJ=1;
[PRICNAKH] = DOLGOWFP (Z1,X1,X2,KZAC,LKJ);
if PRICNAKH == 2, return; end
%
%    1 CONTINUE
end
end 
end 
end
fprintf('\n                Расчет окончен\n');
fclose (fid);
end



