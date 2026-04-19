%	COMMON /BL1/ 
global M,BW,BETTA,N1,IDVIJ,Z(4),X(4),KHBETTA,YFS1,YFS2,WSAT
%   COMMON /BL3/ 
global HPOVZUB1 HPOVZUB2 NPER NTERMO1 NTERMO2
%	COMMON /BL4/ 
global V DW1 DW2 ITOCH U AW EALFA1 EALFA2 ALFATW EALFA
%   COMMON /BL5/ 
global MDVSMAX NDVSMAX ADVS NDVSSR VSR KNMCK KNVOD KMMCK SMAX AST
%	COMMON /BL7/ 
global UGLEROD1 UGLEROD2 MOLIB1 MOLIB2 NPERPOV1 NPERPOV2 NZAGOT1 NZAGOT2 ...
       SIGMAT1 SIGMAT2
%	COMMON /BL11/ 
global ASTAL1 ASTAL2 
%	COMMON /BL12/ 
global IDVIJPOD
%	COMMON /BLKBETTA/ 
global KSHEMA
%	COMMON /BLPOD1/ 
global Z1 Z2 Z3 Z4
%	COMMON /BLPOD2/ 
global MMCK,BETTAMCK
%	COMMON /BLDOLJA/ 
global IRASPRED DOLJAORIG
%	COMMON /BLKTR/ 
global KTR
%	COMMON /BLLK/ 
global LKF
%
fid=fopen('PR1.dat','w+');
% ASTAL=sym('ASTAL');
% LKF- индекс момента циклограммы, который принимается в качестве расчетного
%
LKF=1;
%
fprintf(fid,'        Вариант  , PR1')
fprintf(fid,'\n     ')
fprintf(fid,'\n        ИСХОДНЫЕ ДАННЫЕ')
fprintf(fid,'\n     ')
%      МОДУЛЬ ЗАЦПЛЕНИЯ
M=2; 
fprintf(fid,'\nМОДУЛЬ ЗАЦПЛЕНИЯ - %f5.2',M)
MMCK=M;
%      ЧИСЛО ЗУБЬЕВ МЦК, САТ(МЦК), САТ(БЦК), БЦК
Z=[20 25 0 -90]; 
%      WRITE (15,1007) (Z(I),I=1,4)
Z1=Z(1);
Z2=Z(2);
Z3=Z(3);
Z4=Z(4);
fprintf(fid,'\nЧИСЛО ЗУБЬЕВ МЦК - %i САТ(МЦК) - %i САТ(БЦК) - %i БЦК - %i',Z)
%      ТИП САТЕЛЛИТА ISAT=1, если сателлиты одновенцовые
%                     ISAT=2, если сателлиты двухвенцовые
ISAT=1;
if ISAT==1 
fprintf(fid,'\nСАТЕЛЛИТЫ ОДНОВЕНЦОВЫЕ'), end
if ISAT==2
fprintf(fid,'\nСАТЕЛЛИТЫ ДВУХВЕНЦОВЫЕ'), end
%      УГОЛ НАКЛОНА ЗУБЬЕВ (ГРАД.)
BETTA=10;
fprintf(fid,'\nУГОЛ НАКЛОНА ЗУБЬЕВ (ГРАД.) - %f5.2',BETTA)
BETTA=pi*BETTA/180.;
BETTAMCK=BETTA;
%      КОЭФФИЦИЕНТЫ СМЕЩЕНИЯ (МЦК, САТ1,САТ2,БЦК)
X=[0,0,0,0]; 
fprintf(fid,'\nКОЭФФИЦИЕНТЫ СМЕЩЕНИЯ: МЦК - %f6.3 САТ1 - %f6.3 САТ2 - %f6.3 БЦК - %f6.3',X)
%       ШИРИНА ЗУБЧАТОГО ВЕНЦА (MM)
BW=15;
fprintf(fid,'\nШИРИНА ЗУБЧАТОГО ВЕНЦА (MM) - %f6.2',BW)
%      ЧИСЛО САТЕЛЛИТОВ
AST=3;
fprintf(fid,'\nЧИСЛО САТЕЛЛИТОВ - %i',AST) 
%      МАРКА СТАЛИ (МЦК, САТ1,САТ2,БЦК)
ASTAL=['20ХНМ' '20ХНМ' '20ХНМ' '20ХНМ'];
fprintf(fid,'\nМАРКА СТАЛИ: МЦК - %i САТ1 - %i САТ2 - %i БЦК - %i',ASTAL)
% СПОСОБ ТЕРМИЧЕСКОЙ ОБРАБОТКИ ПОВЕРХНОСТЕЙ ЗУБЬЕВ (МЦК, САТ1,САТ2,БЦК)
%   NTER=1 - Отжиг, нормализация или улучшение, HB
%   NTER=2 - Объемная закалка,                  HRC
%   NTER=3 - Поверхностная закалка (ТВЧ),       HRC
%   NTER=4 - Цементация,                        HRC
%   NTER=5 - Азотирование,                      HV
%   NTER=6 - Нитроцементация,                   HRC
NTER=[4,4,4,4];
fprintf(fid,'\nСПОСОБ ТЕРМИЧЕСКОЙ ОБРАБОТКИ ПОВЕРХНОСТЕЙ ЗУБЬЕВ: МЦК - %i САТ1 - %i САТ2 - %i БЦК - %i',NTER)
%      ТВЕРДОСТЬ ПОВЕРХНОСТЕЙ ЗУБЬЕВ (МЦК, САТ1,САТ2,БЦК)
HPOVZUB=[60,60,60,60];
fprintf(fid,'\nТВЕРДОСТЬ ПОВЕРХНОСТЕЙ ЗУБЬЕВ: МЦК - %i САТ1 - %i САТ2 - %i БЦК - %i',HPOVZUB)
%   ВИД ОБРАБОТКИ ПЕРЕХОДНОЙ ПОВЕРХНОСТИ ЗУБЬЕВ (МЦК, САТ1,САТ2,БЦК)
%     NPERPOV = 0 - Не шлифованная
%     NPERPOV = 1 - Шлифованная
NPERPOV=[1,1,1,1];
fprintf(fid,'\nВИД ОБРАБОТКИ ПЕРЕХОДНОЙ ПОВЕРХНОСТИ ЗУБЬЕВ: МЦК - %i САТ1 - %i САТ2 - %i БЦК - %i',NPERPOV)
% Kоэффициент, учитывающий способ получения заготовки 
%              зубчатого колеса (МЦК, САТ1,САТ2,БЦК)
%    NZAGOT= 1 - Штамповка
%    NZAGOT= 2 - Прокат
%    NZAGOT= 3 - Литье
NZAGOT=[2,2,2,2];
fprintf(fid,'\nKоэффициент, учитывающий способ получения заготовки: МЦК - %i САТ1 - %i САТ2 - %i БЦК - %i',NZAGOT)
%       Номер схемы расположения зубчатых колес относительно опор 
KSHEMA=6;
fprintf(fid,'\nKоэффициент, учитывающий способ получения заготовки: %i',KSHEMA) 
%       КОЛИЧЕСТВО ПЕРЕДАЧ
NPER=8;
fprintf(fid,'\nКОЛИЧЕСТВО ПЕРЕДАЧ: %i',NPER)
%      МАКСИМАЛЬНЫЙ МОМЕНТ ДВИГАТЕЛЯ, Нм
MDVSMAX=1000;
fprintf(fid,'\nМАКСИМАЛЬНЫЙ МОМЕНТ ДВИГАТЕЛЯ, Нм: %g',MDVSMAX)
%      Максимальная частота вращения ведущего вала, об/мин
NDVSMAX=2100;
fprintf(fid,'\nМаксимальная частота вращения ведущего вала, об/мин: %g',NDVSMAX) 
%      Коэффициент использования момента двигателя 
ADVS=0.6; 
fprintf(fid,'\nКоэффициент использования момента двигателя: %g',ADVS)  
%      Средняя частота вращения двигателя, об/мин
NDVSSR=1300;
fprintf(fid,'\nСредняя частота вращения двигателя, об/мин: %g',NDVSSR)  
%       Пробег до капитального ремонта, км
SMAX=250000;
fprintf(fid,'\nПробег до капитального ремонта, км: %g',SMAX)  
%       Средняя скорость, км/ч
VSR=50; 
fprintf(fid,'\nПробег до капитального ремонта, км: %g',VSR)  
%      Коэффициент трансформации момента гидротрансформатора 
%      на стоповом режиме 
KTR=1; 
fprintf(fid,'\nКоэффициент трансформации момента гидротрансформатора на стоповом режиме: %f5.2',KTR)  
%      Коэффициенты частоты вращения МЦК на передачах
KNMCK=[-0.557,0.000,0.583,1.399,1.000,0.583,0.000,0.583]; 
fprintf(fid,'\nКоэффициенты частоты вращения МЦК на передачах: \n%g %g %g %g %g %g %g %g %g %g',KNMCK) 
%     Коэффициенты частоты вращения водила на передачах
KNVOD=[0.000,0.285,0.583,1.000,1.000,1.000,1.000,0.000];
fprintf(fid,'\nКоэффициенты частоты вращения водила на передачах: \n%g %g %g %g %g %g %g %g %g %g',KNVOD)
%      Коэффициенты момента МЦК на передачах
KMMCK=[1.794,1.000,0.684,0.474,0.399,0.342,0.285,-1.715];
fprintf(fid,'\nКоэффициенты момента МЦК на передачах: \n%g %g %g %g %g %g %g %g %g %g',KMMCK)
%      ТИП ДВИЖИТЕЛЯ
%       IDVIJ= 1 - КОЛЕСНЫЙ
%       IDVIJ= 2 - ГУСЕНИЧНЫЙ
IDVIJ=1;
fprintf(fid,'\nТИП ДВИЖИТЕЛЯ: %i',IDVIJ) 
IDVIJPOD=IDVIJ;
% КАКАЯ ГИСТОГРАММА ИСПОЛЬЗУЕТСЯ ДЛЯ РАСПРЕДЕЛЕНИЕ ВРЕМЕНИ ДВИЖЕНИЯ ПО ПЕРЕДАЧАМ
%     IRASPRED= 0 - ОРИГИНАЛЬНАЯ
%     IRASPRED= 1 - ЗАДАННАЯ В ПРОГРАММЕ 
IRASPRED=1;
fprintf(fid,'\n ГИСТОГРАММА ДЛЯ РАСПРЕДЕЛЕНИЕ ВРЕМЕНИ ДВИЖЕНИЯ ПО ПЕРЕДАЧАМ: %i',IRASPRED)
if IRASPRED==0
%      ВВОД ГИСТОГРАММЫ РАСПРЕДЕЛЕНИЕ ВРЕМЕНИ ДВИЖЕНИЯ ПО ПЕРЕДАЧАМ
 DOLJAORIG=[0.0076,0.0146,0.1386,0.166,0.1685,0.49,0.0143,0.0004];
fprintf(fid,'\n ГИСТОГРАММА РАСПРЕДЕЛЕНИЕ ВРЕМЕНИ ДВИЖЕНИЯ ПО ПЕРЕДАЧАМ: \n%i',...
        DOLJAORIG), end
PRIZNAK1=1;
if IRASPRED==1
 if IDVIJ==2
  if ((NPER~=5)&(NPER~=8))
disp('\nРаспределения времени работы для такого количества передачах нет')
PRIZNAK1=2; end, end, end
fprintf('\nIDVIJ= %i',IDVIJ)
if((IDVIJ~=1)&(IDVIJ~=2))
fprintf('\nНе правильно задан тип движителя')
PRIZNAK1=2; end
switch PRIZNAK1
    case 1
%if PRIZNAK1==0
N1=NDVSMAX;
WSAT=0;
%    DO 9 I=1,NPER
for I=1:NPER
if KMMCK(I)~=0.
 WSA=abs(N1*Z(1)*(KNMCK(I)-KNVOD(I))/Z(2));
  if WSAT<WSA 
   WSAT=WSA; end, end, end
%    9 CONTINUE
IPR=0;
%      DO 1 I=1,3
for I=1:3
if((I~=2)&(ISAT~=2)) 
 if IPR==0
  if Z(I+1)==0
 Z(I+1)=Z(I+2);
 X(I+1)=X(I+2);
 NTER(I+1)=NTER(I+2);
 HPOVZUB(I+1)=HPOVZUB(I+2);
 NPERPOV(I+1)=NPERPOV(I+2);
 NZAGOT(I+1)=NZAGOT(I+2);
 IPR=1; end
KZAC=10*Z(I+1)/Z(I);
Z1=abs(Z(I));
Z2=abs(Z(I+1));
X1=X(I);
X2=X(I+1);
if I==1 
 NTERMO1=NTER(1);
 NTERMO2=NTER(2);
 HPOVZUB1=HPOVZUB(1);
 HPOVZUB2=HPOVZUB(2);
 NPERPOV1=NPERPOV(1);
 NPERPOV2=NPERPOV(2);
 NZAGOT1=NZAGOT(1);
 NZAGOT2=NZAGOT(2);
%      DO 8 J=1,20
 for J=1:4
   ASTAL1(J)=ASTAL(1,J);
   ASTAL2(J)=ASTAL(2,J); end, end
%    8 CONTINUE
if ((I>1)&(IPR==0)) 
 NTERMO1=NTER(2);
 NTERMO2=NTER(3);
 HPOVZUB1=HPOVZUB(2);
 HPOVZUB2=HPOVZUB(3);
 NPERPOV1=NPERPOV(2);
 NPERPOV2=NPERPOV(3);
 NZAGOT1=NZAGOT(2);
 NZAGOT2=NZAGOT(3);
%      DO 3 J=1,20
 for J=1:20
  ASTAL1(J)=ASTAL(2,J);
  ASTAL2(J)=ASTAL(3,J); end, end
%    3 CONTINUE
if ((I==3)&(IPR==0)) 
 NTERMO1=NTER(3);
 NTERMO2=NTER(4);
 HPOVZUB1=HPOVZUB(3);
 POVZUB2=HPOVZUB(4);
 NPERPOV1=NPERPOV(3);
 NPERPOV2=NPERPOV(4);
 NZAGOT1=NZAGOT(3);
 NZAGOT2=NZAGOT(4);
%      DO 4 J=1,20
 for J=1:20
   ASTAL1(J)=ASTAL(3,J);
   ASTAL2(J)=ASTAL(4,J); end, end
%    4 CONTINUE
if ((I==3)&(IPR~=0)) 
 NTERMO1=NTER(2);
 NTERMO2=NTER(4);
 HPOVZUB1=HPOVZUB(2);
 HPOVZUB2=HPOVZUB(4);
 NPERPOV1=NPERPOV(2);
 NPERPOV2=NPERPOV(4);
 NZAGOT1=NZAGOT(2);
 NZAGOT2=NZAGOT(4);
%      DO 5 J=1,20
  for J=1:20
    ASTAL1(J)=ASTAL(2,J);
    ASTAL2(J)=ASTAL(4,J); end, end
%    5 CONTINUE
%      ПРОВЕРКА ФУНКЦИЙ КОЛЕС (ШЕСТЕРНЯ-ЗУБЧАТОЕ КОЛЕС)
%
if Z1>Z2
 Z1=ABS(Z(I+1));
 Z2=ABS(Z(I));
 X1=X(I+1);
 X2=X(I);
if I==1
	 NTERMO1=NTER(2);
	 NTERMO2=NTER(1);
	 HPOVZUB1=HPOVZUB(2);
     HPOVZUB2=HPOVZUB(1);
	 NPERPOV1=NPERPOV(2);
	 NPERPOV2=NPERPOV(1);
	 NZAGOT1=NZAGOT(2);
	 NZAGOT2=NZAGOT(1);
 %     DO 6 J=1,20
 for J=1:20
      ASTAL1(J)=ASTAL(2,J);
      ASTAL2(J)=ASTAL(1,J); end, end
 %   6 CONTINUE
if ((I>1)&(IPR==0))
	 NTERMO1=NTER(3);
	 NTERMO2=NTER(2);
     HPOVZUB1=HPOVZUB(3);
     HPOVZUB2=HPOVZUB(2);
	 NPERPOV1=NPERPOV(3);
	 NPERPOV2=NPERPOV(2);
	 NZAGOT1=NZAGOT(3);
	 NZAGOT2=NZAGOT(2);
%      DO 7 J=1,20
     for J=1:20
      ASTAL1(J)=ASTAL(3,J);
      ASTAL2(J)=ASTAL(2,J); end, end, end
%    7 CONTINUE
fprintf('\nZ1= %i Z2= %i',Z1,Z2)
fprintf('  X1= %g X2= %g',X1,X2)
fprintf('\nNTERMO1= %i NTERMO2= %i',NTERMO1,NTERMO2)
fprintf('  HPOVZUB1= %i HPOVZUB2= %i',HPOVZUB1,HPOVZUB2)
fprintf('\nNZAGOT1= %i,NZAGOT2= %i',NZAGOT1,NZAGOT2)
fprintf('  NPERPOV1= %i NPERPOV1 %i',NPERPOV1,NPERPOV2)
%
 IVAR=I;
%
[A1B]=DANNYE(IVAR,0)
fprintf(fid,'\n******************************************************')
%C
fprintf(fid,'\n   ')
fprintf(fid,'\n****************************************************')
fprintf(fid,'\n   ')
if I==1
 fprintf(fid,'\n      Расчет геометрии пары МЦК-Сателлит')
 fprintf(fid,'\n   ') end
%
[BA]=GEOMETR(Z1,Z2,X1,X2,KZAC,IVAR,IPR)
%
%      УЧЕТ НЕРАВНОМЕРНОСТИ РАСПРЕДЕЛЕНИЯ НАГРУЗКИ МЕЖДУ САТЕЛЛИТАМИ
%
BNER=1;
if AST==2 
  if ITOCH>=7
    BNER=1.16; end, end
%
if AST==3
  if ITOCH>=7 
   BNER=1.23; end, end 
%
if AST==4  
 if ITOCH>=7
  BNER=1.32;
  if ((ITOCH==6)|(ITOCH==5))
   BNER=1.25; end 
   if ITOCH<5 
     BNER=1.15; end, end, end
%C
if AST==5 
 if ITOCH>=7 
  BNER=1.35; end
 if ((ITOCH==6)|(ITOCH==5)) 
  BNER=1.35; end
 if ITOCH<5 
  BNER=1.19; end, end
%
if AST==6 
 if ITOCH>=7 
  BNER=1.38; end
 if ((ITOCH==6)|(ITOCH==5)) 
  BNER=1.44; end
 if ITOCH<5 
  BNER=1.23; end, end
%C
if AST==7
 if ITOCH>=7
  BNER=1.47; end
 if ((ITOCH==6)|(ITOCH==5)) 
  BNER=1.47; end
 if ITOCH<5 
  BNER=1.27; end, end
%
if AST==8
 if ITOCH>=7 
  BNER=1.6; end
 if ((ITOCH==6)|(ITOCH==5)) 
  BNER=1.6; end
 if ITOCH<5 
  BNER=1.3; end, end
%
if AST==9  
 if ITOCH>=7 
  BNER=1.61; end
 if ((ITOCH==6)|(ITOCH==5)) 
  BNER=1.61; end
 if ITOCH<5 
  BNER=1.61; end, end
%	BN ER=1.0
%
%      DO 12 IW=1,NPER
for IW=1:NPER
 KNMCK(IW)=BNER*KNMCK(IW); end
%   12 CONTINUE
if I==2  
 FPRINTF(FID,'\n      Расчет геометрии пары Сателлит-БЦК')
 FPRINTF(FID,'\n     ')
 [DA]=GEOMETR(Z1,Z2,X1,X2,KZAC,IVAR,IPR) end  
%
if ITOCH<6 
 ITOCH=6 end
IVAR=3;
%
[AB]=DANNYE(IVAR,1)
%
fprintf(fid,'\n     ')
fprintf(fid,'\n****************************************************')
fprintf(fid,'\n     ')
fprintf(fid,'\nКОЭФФИЦИЕНТ НЕРАВНОМЕРНОСТИ РАСПРЕДЕЛЕНИЯ НАГРУЗКИ,F5.3',BNER)
fprintf(fid,'\n     ')	
fprintf(fid,'\n****************************************************')
if I==1 
FPRINTF(FID,'\nРасчет на контактную прочность для ПРЯМОГО действия нагрузки ')
fprintf(fid,'\n                        МЦК-Сателлит')
fprintf(fid,'\n     '), end
%
if KZAC>=0 
%
 if I==2
 fprintf(fid,'\nРасчет на контактную прочность для ПРЯМОГО действия нагрузки ') 
 fprintf(fid,'\n                        Сателлит-БЦК'), end
%
 [BB]=DOLGOWHP (Z1,Z2,X1,X2,KZAC,1)
%
 fprintf(fid,'\n     ')
 fprintf(fid,'\n****************************************************')
 fprintf(fid,'\n     ')
 if I==1 
 fprintf(fid,'\nРасчет на контактную прочность для реверсивной нагрузки ')
 fprintf(fid,'\n                        МЦК-Сателлит')
 fprintf(fid,'\n     '), end 
 if I==2
  fprintf(fid,'\nРасчет на контактную прочность для реверсивной нагрузки '), end
 if I==2 
  fprintf(fid,'\n             Сателлит-БЦК'), end
%
[CA]=DOLGOWHP (Z1,Z2,X1,X2,KZAC,2)
%
fprintf(fid,'\n     ')
fprintf(fid,'\n****************************************************')
fprintf(fid,'\n     ')
if I==1
 fprintf(fid,'\n        РАСЧЕТ НА ИЗГИБНУЮ ПРОЧНОСТЬ ПАРЫ МЦК-САТЕЛЛИТ')
 fprintf(fid,'\n     '), end  
%      IF(I.EQ.2) THEN
%	WRITE (15,*)
%     * '        Расчет на изгибную прочность для пары Сателлит-БЦК'
%	WRITE(15,*) '   '
%      END IF
fprintf(fid,'\n        Расчет зубьев МЦК')
fprintf(fid,'     ')
%
[DS]=DOLGOWFP (Z1,Z2,X1,X2,KZAC,2)
%
fprintf(fid,'\n     ')
fprintf(fid,'\n----------------------------------------------------')
fprintf(fid,'\n     ')
fprintf(fid,'\n        Расчет зубьев сателлита')
fprintf(fid,'\n     ')
%
[DDG]=DOLGOWFP (Z1,Z2,X1,X2,KZAC,1) 
%
%    1 CONTINUE
end, end, end, end
    case 2
end
    % READ  (14,1000) (FDSA(I),I=1,80)
%	WRITE (15,1000) (FDSA(I),I=1,80)
%      READ  (14,1000) (FDSA(I),I=1,80)
%      WRITE (15,1000) (FDSA(I),I=1,80)
%	READ  (14,1000) (FDSA(I),I=1,80)
%	WRITE (15,1000) (FDSA(I),I=1,80)
%
%     РАСЧЕТ ПОДШИПНИКОВ САТЕЛЛИТОВ
%
%      READ  (14,1003) MPOD
%      WRITE (15,1003) MPOD
% 
%      IF(MPOD.EQ.1) CALL RASCHETPOD
%      
%stop
% 1000 FORMAT(1X,80(A1))
% 1001 FORMAT(12F10.5)
% 1002 FORMAT(1X,12F8.3)
% 1003 FORMAT(10I2)
% 1004 FORMAT(1X,10(I2,2X))
% 1005 FORMAT(F8.1)
% 1006 FORMAT(1X,F8.1)
% 1007 FORMAT(1X,10(F5.0,2X))
% 1008 FORMAT(80(A1))
% 1009 FORMAT(1X,'КОЭФФИЦИЕНТ НЕРАВНОМЕРНОСТИ РАСПРЕДЕЛЕНИЯ НАГРУЗКИ',
%     *       ' МЕЖДУ САТЕЛЛИТАМИ - ',F4.2)