function [ PRICNAKH ] = DOLGOWFP( Z1,X1,X2,KZAC,LKJ )
%
%   ПОДПРОГРАММА РАСЧЕТА НА ИЗГИБНУЮ ПРОЧНОСТЬ  
%
global M BW BETTA Z YFS1 YFS2 NPER V U AW EALFA VZAC ZV1 ZV2 KHALFA KTR
global MDVSMAX ADVS NDVSSR VSR KNMCK KNVOD KMMCK SMAX AST LK fid
global DOLJA GAMMAFC KA KXF YR SIGMAFLIM01 KFG1 KFD1 SFII1 SIGMAFLIM02
global KFG2 KFD2 SFII2 DELTAF G0 KFLMAX1 KFLMAX2 QF1 QF2 NFO SF1 SF2
global SIGMSFST01 SIGMSFST02 YDST1 YGST1 YDST2 YGST2 D1 D2 EBETTA NPER3X
PRICNAKH=1;
ME1=0; ME2=0; KFL1=1; KFL2=1; KFC1=1; KFC2=1;
%
TPR=0; TREV=0;
fprintf(fid,'\nОПРЕДЕЛЕНИЕ ДОПУСКАЕМЫХ НАПРЯЖЕНИЙ ПРИ РАСЧЕТЕ НА ИЗГИБНУЮ ВЫНОСЛИВОСТЬ');
fprintf(fid,'\n         ');
%      РЕСУРС КПП
TMAX=SMAX/VSR; KREVERS=0;
%                           РАСЧЕТ ДОПУСКАЕМЫХ НАПРЯЖЕНИЙ
%
%                            ПРЯМОЕ ДЕЙСТВИЕ НАГРУЗКИ
%      Построение циклограммы для прямого действия нагрузки
LPRJAM=0;
%      DO 1 I=1,NPER
for II=1:NPER+NPER3X
if KMMCK(II)>0
RAZOB=KNMCK(II)-KNVOD(II);
if RAZOB~=0
NZ1PRLPRJAM=abs(NDVSSR*(KNMCK(II)-KNVOD(II)));
if NZ1PRLPRJAM>0.001
LPRJAM=LPRJAM+1;
KMMCKPR(LPRJAM)=abs(KMMCK(II));
KNMCKPR(LPRJAM)=abs(KNMCK(II));
NPERPR(LPRJAM)=II;
%      ОБОРОТЫ
NZ1PR(LPRJAM)=abs(NDVSSR*(KNMCK(II)-KNVOD(II)));
NZ2PR(LPRJAM)=NZ1PR(LPRJAM)/U;
%      ЦИКЛЫ
NPR1(LPRJAM)=60*TMAX*NZ1PR(LPRJAM)*DOLJA(II)*AST;
NPR2(LPRJAM)=60*TMAX*NZ2PR(LPRJAM)*DOLJA(II);
%      МОМЕНТЫ
M1PR(LPRJAM)=ADVS*MDVSMAX* KMMCKPR(LPRJAM)/AST;
M2PR(LPRJAM)=M1PR(LPRJAM)*U;
if Z1~=Z(1)
NZ2PR(LPRJAM)=abs(NDVSSR*(KNMCK(II)-KNVOD(II)));
NZ1PR(LPRJAM)=NZ1PR(LPRJAM)*U;
NPR2(LPRJAM)=60*TMAX*NZ2PR(LPRJAM)*DOLJA(II)*AST;
NPR1(LPRJAM)=60*TMAX*NZ1PR(LPRJAM)*DOLJA(II);
M2PR(LPRJAM)=M1PR(LPRJAM)/U;
end
VZAC(LPRJAM)=abs(pi*D2*NZ2PR(LPRJAM)/60000);
if Z1~=Z(1)
    VZAC(LPRJAM)=abs(pi*D1*NZ1PR(LPRJAM)/60000);
end
% 1 CONTINUE
end
end 
end 
end
fprintf(fid,'\n      ПРЯМОЕ ДЕЙСТВИЕ НАГРУЗКИ');           
if LPRJAM==0, KREVERS=1; 
end
if LPRJAM~=0
%      СОРТИРОВКА ЦИКЛОГРАММЫ ПО УБЫВАНИЮ МОМЕНТА
LPR=0;	
%	DO 13 IJ=1,LPRJAM
for IJ=1:LPRJAM    
if NPR1(IJ)>=50000    
ATR=0;
%	DO 12 I=1,LPRJAM
for II=1:LPRJAM
if ATR<KMMCKPR(II) 
    ATR=KMMCKPR(II);
    MIU=II; 
end 
end
%12 CONTINUE
LPR=LPR+1;
Z1NPR(LPR)=NZ1PR(MIU);
Z2NPR(LPR)=NZ2PR(MIU);
PR1N(LPR)=NPR1(MIU);
PR2N(LPR)=NPR2(MIU);
PRM1(LPR)=M1PR(MIU);
PRM2(LPR)=M2PR(MIU);
ZACV(LPR)=VZAC(MIU);
MPERPR(LPR)=NPERPR(MIU);
KMMCKPR(MIU)=0;
end
end
% 13   CONTINUE
%      DO 14 I=1,LPRJAM
for II=1:LPR
  NZ1PR(II)=Z1NPR(II); NZ2PR(II)=Z2NPR(II);
  NPR1(II)=PR1N(II);   NPR2(II)=PR2N(II);
  M1PR(II)=PRM1(II);   M2PR(II)=PRM2(II);
  VZAC(II)=ZACV(II); 
end
%14 continue    
NK1=0; NK2=0;
%      DO 17 I=1,LPRJAM
for II=1:LPRJAM
  NK1=NK1+NPR1(II); 
  NK2=NK2+NPR2(II); 
end
%17 continue
TPR=abs(M1PR(1));
%      ОПРЕДЕЛЕНИЕ ПАРАМЕТРОВ НАГРУЖЕНИЯ ЗУБЧАТОГО ЗАЦЕПЛЕНИЯ ПРИ ПОСТОЯННОЙ НАГРУЗКЕ
PRIZ1=1;
if LPRJAM==1    
fprintf(fid,'\n     НАГРУЗКА ПОСТОЯННА');
FTH=2000*M1PR(1)/D1;
if Z1~=Z(1), FTH=2000*M1PR(1)/D2; end
fprintf(fid,'\nOкружная сила на делительном диаметре для прямого действия нагрузки, H - %g', FTH);
if LKJ==1 
    NFE1=NK1; 
    ME1=M1PR(1); 
    AQF=1/QF1; 
end
if LKJ==2
    NFE1=NK2; 
    ME1=M2PR(1); 
    AQF=1/QF2; 
end
V=VZAC(1);
KFL1=NFO/NFE1; 
KFL1=KFL1^AQF;
fprintf(fid,'\n  РАСЧЕТНЫЙ МОМЕНТ %g',ME1);  
fprintf(fid,'\n  СКОРОСТЬ В ЗАЦЕПЛЕНИИ %g',V);
fprintf(fid,'\n  ЧИСЛО ЦИКЛОВ %g',NFE1);
PRIZ1=2;
%       GO TO 130
end
switch PRIZ1
    case 1
%      ОПРЕДЕЛЕНИЕ ЗКВИВАЛЕНТНЫХ ЦИКЛОВ НАГРУЖЕНИЯ ПРИ ПЕРЕМЕННЫХ НАГРУЗКЕ И ОБОРОТАХ
MUJH1=0;
MUJH2=0;
WFT=DELTAF*G0*VZAC(1)*sqrt(AW/U); 
FTH=2000*M1PR(LK)/D2;
if Z1~=Z(1)
    FTH=2000.*M1PR(LK)/D2; 
end
fprintf(fid,'\nOкружная сила на делительном диаметре для прямого действия нагрузки F(TF), H - %g',FTH);	
NUJH=WFT*BW/(FTH*KA);
for II=1:LPRJAM
if LKJ==1
TY1=(M1PR(II)+NUJH*M1PR(1))*NZ1PR(II);
TY1=TY1/(M1PR(1)*(1+NUJH)*NZ1PR(1));
TY1=TY1^QF1;
TY1=TY1*(NPR1(II)/NFO);
AQF=1/QF1;
if II<LPRJAM, AQ1=M1PR(II+1)/M1PR(1); end
ME1=M1PR(1); 
end
if LKJ==2
TY1=(M2PR(II)+NUJH*M2PR(1))*NZ2PR(II);
TY1=TY1/(M2PR(1)*(1+NUJH)*NZ2PR(1));
TY1=TY1^QF2;
TY1=TY1*(NPR2(II)/NFO);
AQF=1/QF2;
if II<LPRJAM, AQ1=M2PR(II+1)/M2PR(1);
ME1=M2PR(1);
end
MUJH1=MUJH1+TY1;
AQ2=MUJH1^AQF;
AQ2=0.65*AQ2;
%      IF(AQ1.LT.AQ2) GO TO 24
end
%22 CONTINUE
%   24 CONTINUE
NFE1=MUJH1*NFO;
KFL1=NFO/NFE1;
KFL1=KFL1^AQF;
fprintf(fid,'\nKоэффициент, учитывающий характер циклограммы для прямого действия нагрузки MJU(F1) -  %g',MUJH1); 
fprintf(fid,'\nЭквивалентное число циклов перемены напряжений для прямого действия нагрузки N(FE) -  %g',NFE1); 
fprintf(fid,'\nРасчетный момент, M(H) -  %g',ME1);
%  130 CONTINUE
end
    case 2
end
if LKJ==1
if KFL1>KFLMAX1, KFL1=KFLMAX1; end
end
if LKJ==2
if KFL1>KFLMAX2, KFL1=KFLMAX2; end
end
if NFE1>NFO, KFL1=1; end
fprintf(fid,'\nКоэффициент долговечности K(FL) - %7.3f',KFL1);
fprintf(fid,'\n    ');	
end
%1000
%C
%C      Построение циклограммы для реврсивного действия нагрузки
%C
LPRJAM=0;
fprintf(fid,'\n           РЕВЕРСИВНОЕ ДЕЙСТВИЕ НАГРУЗКИ');
for II=1:NPER+NPER3X
if KMMCK(II)<0
RAZOB=KNMCK(II)-KNVOD(II);
if RAZOB~=0
LPRJAM=LPRJAM+1;
KMMCKPR(LPRJAM)=abs(KMMCK(II));
KNMCKPR(LPRJAM)=abs(KNMCK(II));
NPERPR(LPRJAM)=II;
%      ОБОРОТЫ
NZ1PR(LPRJAM)=abs(NDVSSR*(KNMCK(II)-KNVOD(II)));
NZ2PR(LPRJAM)=NZ1PR(LPRJAM)/U;
%      ЦИКЛЫ
NPR1(LPRJAM)=60*TMAX*NZ1PR(LPRJAM)*DOLJA(II)*AST;
NPR2(LPRJAM)=60*TMAX*NZ2PR(LPRJAM)*DOLJA(II);
%      МОМЕНТЫ
M1PR(LPRJAM)=ADVS*MDVSMAX* KMMCKPR(LPRJAM)/AST;
M2PR(LPRJAM)=M1PR(LPRJAM)*U;
if Z1~=Z(1)
NZ2PR(LPRJAM)=abs(NDVSSR*(KNMCK(II)-KNVOD(II)));
NZ1PR(LPRJAM)=NZ1PR(LPRJAM)*U;
NPR2(LPRJAM)=60.*TMAX*NZ2PR(LPRJAM)*DOLJA(II)*AST;
NPR1(LPRJAM)=60.*TMAX*NZ1PR(LPRJAM)*DOLJA(II);
M2PR(LPRJAM)=M1PR(LPRJAM)/U; 
end
VZAC(LPRJAM)=abs(pi*D2*NZ2PR(LPRJAM)/60000);
if Z1~=Z(1) VZAC(LPRJAM)=abs(pi*D1*NZ1PR(LPRJAM)/60000); 
end
%   31 CONTINUE
end
end
end
PRIZ2=1;
if LPRJAM==0   
KFC1=1;
%	 GO TO 133
PRIZ2=2;
end
switch PRIZ2
    case 1
%      СОРТИРОВКА ЦИКЛОГРАММЫ ПО УБЫВАНИЮ МОМЕНТА
LPR=0;
for IJ=1:LPRJAM
if NPR1(IJ)>=50000
ATR=0;
for I=1:LPRJAM
if ATR<KMMCKPR(I), ATR=KMMCKPR(I); MIU=I; end
%	   34 CONTINUE
end
LPR=LPR+1;
Z1NPR(LPR)=NZ1PR(MIU);
Z2NPR(LPR)=NZ2PR(MIU);
PR1N(LPR)=NPR1(MIU);
PR2N(LPR)=NPR2(MIU);
PRM1(LPR)=M1PR(MIU);
PRM2(LPR)=M2PR(MIU);
ZACV(LPR)=VZAC(MIU);
MPERPR(LPR)=NPERPR(MIU);
KMMCKPR(MIU)=0;
%   32 CONTINUE
end
end
for II=1:LPRJAM
NZ1PR(II)=Z1NPR(II);
NZ2PR(II)=Z2NPR(II);
NPR1(II)=PR1N(II);
NPR2(II)=PR2N(II);
M1PR(II)=PRM1(II);
M2PR(II)=PRM2(II); 
VZAC(II)=ZACV(II);
%   35 continue
end
NK1=0; NK2=0;
for I=1:LPRJAM
NK1=NK1+NPR1(II); NK2=NK2+NPR2(II);
%  36 continue
end
TREV=abs(M1PR(LK));
%
%      ОПРЕДЕЛЕНИЕ ПАРАМЕТРОВ НАГРУЖЕНИЯ ЗУБЧАТОГО ЗАЦЕПЛЕНИЯ ПРИ ПОСТОЯННОЙ НАГРУЗКЕ
fprintf(fid,'\n     НАГРУЗКА ПОСТОЯННА');
PRIZ3=1;
if LPRJAM==1
FTH=2000*M1PR(1)/D1;
if Z1~=Z(1), FTH=2000.*M1PR(1)/D2; end
fprintf(fid,'\nOкружная сила на делительном диаметре для реверсивного действия нагрузки F(TF), H -  %g',FTH);
if LKJ==1, NFE2=NK1; ME2=M1PR(1); AQF=1/QF1; end
if LKJ==2, NFE2=NK2; ME2=M2PR(1); AQF=1/QF2; end
V=VZAC(1); KFL2=NFO/NFE2; KFL2=KFL2^AQF;
fprintf(fid,'\n  РАСЧЕТНЫЙ МОМЕНТ, Hм - %g',ME2);   
fprintf(fid,'\n  СКОРОСТЬ В ЗАЦЕПЛЕНИИ, м/с -  %g',V);
fprintf(fid,'\n  ЧИСЛО ЦИКЛОВ -  %g',NFE2);
PRIZ3=2;
%       GO TO 131
end
switch PRIZ3
    case 1
%      ОПРЕДЕЛЕНИЕ ЗКВИВАЛЕНТНЫХ ЦИКЛОВ НАГРУЖЕНИЯ ПРИ ПЕРЕМЕННЫХ НАГРУЗКЕ И ОБОРОТАХ
MUJH1=0;
MUJH2=0;
WFT=DELTAF*G0*VZAC(1)*sqrt(AW/U); 
FTH=2000.*M1PR(LK)/D1;
if Z1~=Z(1) FTH=2000.*M1PR(LK)/D2; end
fprintf(fid,'\nОкружная сила на делительном диаметре для реверсивного действия нагрузки F(TF), H - %g',FTH); 
NUJH=WFT*BW/(FTH*KA);
for II=1:LPRJAM
if LKJ==1
TY1=(M1PR(II)+NUJH*M1PR(LK))*NZ1PR(II);
TY1=TY1/(M1PR(LK)*(1+NUJH)*NZ1PR(LK));
TY1=TY1^QF1;
TY1=TY1*(NPR1(I)/NFO);
AQF=1/QF1;
if II<LPRJAM
AQ1=M1PR(II+1)/M1PR(LK);
ME2=M1PR(LK); 
end
end
if LKJ==2
TY1=(M2PR(II)+NUJH*M2PR(LK))*NZ2PR(II);
TY1=TY1/(M2PR(1)*(1+NUJH)*NZ2PR(LK));
TY1=TY1^QF2;
TY1=TY1*(NPR2(II)/NFO);
AQF=1/QF2;
if II<LPRJAM
AQ1=M2PR(II+1)/M2PR(LK); 
ME2=M2PR(LK); 
end
MUJH2=MUJH2+TY1;
AQ2=MUJH2^AQF;
AQ2=0.65*AQ2;
%      IF(AQ1.LT.AQ2) GO TO 38
end
end
%   37 CONTINUE
%   38 CONTINUE
NFE2=MUJH2*NFO;
KFL2=NFO/NFE2;
KFL2=KFL2^AQF;
fprintf(fid,'\nKоэффициент, учитывающий характер циклограммы, для реверсивного действия нагрузки MJU(F1) - %g',MUJH2); 
fprintf(fid,'\nЭквивалентное число циклов перемены напряжений для реверсивного действия нагрузки N(FE) - %g',NFE2);
fprintf(fid,'\nРасчетный момент для реверсивного действия нагрузки, M(H) - %g',ME2);
%  131 CONTINUE
    case 2
end
if KFL2>KFLMAX2, KFL2=KFLMAX2; end
if NFE2>NFO, KFL2=1; end
fprintf(fid,'\nКоэффициент долговечности для реверсивного действия  нагрузки K(FL) - %g',KFL2);
fprintf(fid,'\n    ');	
%      Kоэффициент, учитывающий влияние двухстороннего приложения нагрузки
AQ1=ME1/KFL1; AQ2=ME2/KFL2;
AS1=AQ1;
if AQ2<AQ1, AS1=AQ2; end
AS2=AQ1;
if AQ2>AQ1, AS2=AQ2; end
KFC1=1.-GAMMAFC*AS1/AS2;
if KREVERS==1, KFC1=1; 
    KFL1=KFL2;  
end
fprintf(fid,'\nKоэффициент, учитывающий влияние двухстороннего приложения нагрузки, K(FC) - %g',KFC1);
fprintf(fid,'\nKоэффициент, учитывающий влияние деформационного упрочнeния или электрохимической обработки переходной поверхности, K(FG) - %g',KFG1);
fprintf(fid,'\nKоэффициент, учитывающий влияние шлифования переходной - %g',KFL2);
fprintf(fid,'\nKоэффициент, учитывающий влияние шлифования переходной  поверхности зуба шестерни, K(FD) - %g',KFD1);
fprintf(fid,'\nПредел изломной выносливости, SIGMA(FLIM0), МПа - %g',SIGMAFLIM01);
%
%  133 CONTINUE  
    case 2
end
%SA4=KFL1
if LKJ==1, SIGMAFLIM1=SIGMAFLIM01*KFG1*KFD1*KFL1*KFC1;
end
if LKJ==2, SIGMAFLIM1=SIGMAFLIM02*KFG2*KFD2*KFL2*KFC2; 
end
fprintf(fid,'\nПредел выносливости зубьев колес при изгибе, SIGMA(FLIM), МПа - %g',SIGMAFLIM1);
%C      Kоэффициент безопасности
if LKJ==1, SF=SF1*SFII1; end
if LKJ==2, SF=SF2*SFII2; end
%	
fprintf(fid,'\nKоэффициент безопасности, S(F) - %g',SF);
%      Kоэффициент, учитывающий градиент напряжений и чувствительность материала к концентрации напряжений
YS=1.082-0.172*log10(M);
fprintf(fid,'\nKоэффициент, учитывающий градиент напряжений и чувствительность материала к концентрации напряжений, Y(S) - %g',YS);
fprintf(fid,'\nKоэффициент, учитывающий шероховатость переходной поверхности, Y(R) - %g',YR);
%      Допускаемое изгибное напряжение при расчете на выносливость
fprintf(fid,'\nKоэффициент, учитывающий размеры зубчатого колеса, K(XF) - %g',KXF);
SIGMAFP=SIGMAFLIM1*YS*YR*KXF/SF;
fprintf(fid,'\n    ');
fprintf(fid,'\nДопускаемое изгибное напряжение при расчете на выносливость, МПа - %g',SIGMAFP);
fprintf(fid,'\n--------------------------------------------------');
%
%      РАСЧЕТ ДЕЙТВУЮЩИХ ИЗГИБНЫХ НАПРЯЖЕНИЙ ЗУБЧАТОЙ ПЕРЕДАЧИ
%
fprintf(fid,'\nРАСЧЕТ НА ИЗГИБНУЮ ВЫНОСЛИВОСТЬ');
fprintf(fid,'\n    ');
TM=TPR;
if TM<TREV, TM=TREV; end
FTH=2000*TM/D1;
if Z1~=Z(1), FTH=2000*TM/D2; end
%      WFT=DELTAF*G0*VZAC(1)*SQRT(AW/U)
%	NUJH=WFT*BW/(FTH*KA)
%      KFV=1.+NUJH
VOKR=VZAC(1);
%
[KFV] = OPREDKV(FTH,Z1,VOKR);
%     
fprintf(fid,'\nКоэффициент, учитывающий динамическую нагрузку, возникающую в зацеплении, K(FV) - %7.3f',KFV);	 
%
[KFBETTA] = KFBET();
%
fprintf(fid,'\nКоэффициент, учитывающий распределение нагрузки по ширине венца, K(FBETTA) - %7.3f',KFBETTA);
KFALFA=KHALFA;
%	AER=0.
%	IF(ITOCH.GT.5) AER=ITOCH-5
%	ASD=EBETTA-1.
%      KFALFA=(4.+ASD*AER)/(4.*EALFA)
fprintf(fid,'\nКоэффициент, учитывающий распределение нагрузки между зубьями, K(FALFA) - %7.3f',KFALFA);
fprintf(fid,'\nКоэффициент внешней динамической нагрузки KA - %7.3f',KA);	
KF=KA*KFV*KFBETTA*KFALFA;
fprintf(fid,'\nКоэффициент нагрузки, K(F) - %7.3f',KF);
YBETTA=1;
BE=180*BETTA/pi;
if BETTA~=0, YBETTA=1-(EBETTA*BE/140); end
fprintf(fid,'\nКоэффициент, учитывающий наклон зубьев, Y(BETTA) - %7.3f',YBETTA);
YE=1;
if BETTA~=0
if EBETTA<0, YE=0.2+(0.8/EALFA); end
if EBETTA>=0, YE=1./EALFA; end
end
fprintf(fid,'\nКоэффициент, учитывающий перекрытие зубьев, Y(E) - %7.3f',YE);
YFS1=3.47+13.2/ZV1-29.7*X1/ZV1+0.092*X1^2;
YFS2=3.47+13.2/ZV2-29.7*X2/ZV2+0.092*X2^2;
if LKJ==1
fprintf(fid,'\nКоэффициент, учитывающий форму зуба, Y(FS) - %7.3f',YFS1); 
end 
if LKJ==2 
fprintf(fid,'\nКоэффициент, учитывающий форму зуба, Y(FS) - %7.3f',YFS2); 
end
if LKJ==1, SIGMAF=(KF*YFS1*YE*YBETTA*FTH)/(BW*M); end
if LKJ==2, SIGMAF=(KF*YFS2*YE*YBETTA*FTH)/(BW*M); end
if SIGMAF>SIGMAFP
fprintf(fid,'\n    ВНИМАНИЕ!!!');
fprintf(fid,'\nДействующие изгибные напряжения больше допускаемых');
fprintf(fid,'\n	SIGMAF = %g   SIGMAFP = %g',SIGMAF,SIGMAFP);
fprintf('\n    ВНИМАНИЕ!!!');
fprintf('\nДействующие изгибные напряжения больше допускаемых');
fprintf('\n	SIGMAF = %g   SIGMAFP = %g',SIGMAF,SIGMAFP);
PRICNAKH=2;
return
end
fprintf(fid,'\n    ');
fprintf(fid,'\nДействующие в полюсе зацепления изгибные напряжения,  SIGMA(F), МПа - %7.3f',SIGMAF);
fprintf(fid,'\n--------------------------------------------------');
%
%      Расчет на изгибную прочность при действии максимальной нагрузки
%
fprintf(fid,'\n     РАСЧЕТ НА ИЗГИБНУЮ ПРОЧНОСТЬ ПРИ ДЕЙСТВИИ МАКСИМАЛЬНОЙ НАГРУЗКИ');
fprintf(fid,'\n    ');
AQ1=0;
for III=1:NPER+NPER3X
if AQ1<abs(KMMCK(III)), AQ1=abs(KMMCK(III)); end
end
%   26 CONTINUE
TMAX=KTR*MDVSMAX*AQ1/AST;
DRR=D1;
if KZAC<10, DRR=D2; end
FTHMAX=2000*TMAX/DRR;
fprintf(fid,'\nМаксимальная расчетная нагрузка F(Tmax), Н - %g',FTHMAX);
fprintf(fid,'\nPасчетная нагрузка F(T), Н - %g',FTH);
SIGMAFMAX=SIGMAF*FTHMAX/(FTH*KA);
if LKJ==1, SFST=1.75/SFII1; SIGMSFST=SIGMSFST01*YGST1*YDST1; end
if LKJ==2, SFST=1.75/SFII2; SIGMSFST=SIGMSFST02*YGST2*YDST2; end
SIGMAFPMAX=SIGMSFST*KXF/SFST;
fprintf(fid,'\n    ');
fprintf(fid,'\nДействующие максимальные изгибные напряжения SIGMA(FMAX), МПа - %g',SIGMAFMAX);
fprintf(fid,'\nДопускаемые максимальные изгибные напряжения SIGMA(FPMAX), МПа - %g',SIGMAFPMAX);
if SIGMAFMAX>SIGMAFPMAX
fprintf(fid,'\n    ВНИМАНИЕ!!!');
fprintf(fid,'\nДействующие максимальные изгибные напряжения больше допускаемых');
fprintf(fid,'\nSIGMAFMAX = %g SIGMAFMAX = %g',SIGMAFMAX,SIGMAFPMAX);
fprintf('\n    ВНИМАНИЕ!!!');
fprintf('\nДействующие максимальные изгибные напряжения больше допускаемых');
fprintf('\nSIGMAFMAX = %g SIGMAFMAX = %g',SIGMAFMAX,SIGMAFPMAX);
PRICNAKH=2;
return
end
end


