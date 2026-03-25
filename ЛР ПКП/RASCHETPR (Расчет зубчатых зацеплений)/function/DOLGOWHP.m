function [ PRICNAKH ] = DOLGOWHP(LKJ )
%
%   ПОДРОГРАММА РАСЧЕТА НА КОНТАКТНУЮ ПРОЧНОСТЬ
%
global BW BETTA Z VZAC G0
global HPOVZUB1 HPOVZUB2 NPER NTERMO1 NTERMO2 Z1  
global V ITOCH U AW EALFA1 EALFA2 ALFATW EALFA
global MDVSMAX ADVS NDVSSR VSR KNMCK KNVOD KMMCK SMAX AST
global DOLJA KA ZE SIGMAHPMAX1 SIGMAHPMAX2 fid NPER3X
global SH1 SH2 ZR NHO1 NHO2 SIGMAHLIMB1 SIGMAHLIMB2 DELTAH1 DELTAH2         
global ALFAT BETTAB EY D1 D2 EBETTA KHALFA KTR LK
%
%fid=fopen('PR1.dat','a+');
fprintf(fid,'\nОПРЕДЕЛЕНИЕ ДОПУСКАЕМЫХ НАПРЯЖЕНИЙ ПРИ РАСЧЕТЕ НА КОНТАКТНУЮ ВЫНОСЛИВОСТЬ');
fprintf(fid,'\n   ');
PRICNAKH=1;
%      РЕСУРС КПП
TMAX=SMAX/VSR;
%      Построение циклограммы для прямого действия нагрузки
 LPRJAM=0;
for II=1:NPER+NPER3X
if (LKJ==1)&&(KMMCK(II)>0)
NZ1PRLPRJAM=abs(NDVSSR*(KNMCK(II)-KNVOD(II)));
if NZ1PRLPRJAM>0.001
LPRJAM=LPRJAM+1;
%      МОМЕНТЫ
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
NZ1PR(LPRJAM)=NZ2PR(LPRJAM)*U;
NPR2(LPRJAM)=60*TMAX*NZ2PR(LPRJAM)*DOLJA(II)*AST;
NPR1(LPRJAM)=60*TMAX*NZ1PR(LPRJAM)*DOLJA(II);
M2PR(LPRJAM)=M1PR(LPRJAM)/U;
end
VZAC(LPRJAM)=abs(pi*D2*NZ2PR(LPRJAM)/60000);
if Z1~=Z(1)
VZAC(LPRJAM)=abs(pi*D1*NZ1PR(LPRJAM)/60000); 
end
 end 
end 
 end 
for II=1:NPER+NPER3X
if (LKJ==2)&&(KMMCK(II)<0)
NZ1PRLPRJAM=abs(NDVSSR*(KNMCK(II)-KNVOD(II)));
if NZ1PRLPRJAM>0.001
LPRJAM=LPRJAM+1;
%      МОМЕНТЫ
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
NZ1PR(LPRJAM)=NZ2PR(LPRJAM)*U;
NPR2(LPRJAM)=60*TMAX*NZ2PR(LPRJAM)*DOLJA(II)*AST;
NPR1(LPRJAM)=60*TMAX*NZ1PR(LPRJAM)*DOLJA(II);
M2PR(LPRJAM)=M1PR(LPRJAM)/U;
end
VZAC(LPRJAM)=abs(pi*D2*NZ2PR(LPRJAM)/60000);
if Z1~=Z(1)
VZAC(LPRJAM)=abs(pi*D1*NZ1PR(LPRJAM)/60000); 
end
 end 
end 
end 
%    1 CONTINUE
if LPRJAM==0
    return
end
PRIZ1=1;
%
%      ОПРЕДЕЛЕНИЕ ПАРАМЕТРОВ НАГРУЖЕНИЯ ЗУБЧАТОГО ЗАЦЕПЛЕНИЯ ПРИ ПОСТОЯННОЙ НАГРУЗКЕ
%
if LPRJAM==1
fprintf(fid,'\n     РАСЧЕТ ВЕДЕТСЯ ПРИ ПОСТОЯННОЙ НАГРУЗКЕ');
%fprintf('\n     РАСЧЕТ ВЕДЕТСЯ ПРИ ПОСТОЯННОЙ НАГРУЗКЕ');
%      Oкружная сила на делительном диаметре
FTH=2000*M1PR(LK)/D1;
if Z1~=Z(1), FTH=2000*M1PR(LK)/D2; 
end
NK1=NPR1(1);
NK2=NPR2(1);
NHE1=NK1;
NHE2=NK2;
ME1=M1PR(1);
ME2=M2PR(1);
V=VZAC(1);
PRIZ1=2;
%       GO TO 130
end
switch PRIZ1
    case 1
%      СОРТИРОВКА ЦИКЛОГРАММЫ ПО УБЫВАНИЮ МОМЕНТА
LPR=0;
for IJ=1:LPRJAM
ATR=0;
for II=1:LPRJAM
if ATR<KMMCKPR(II)
   ATR=KMMCKPR(II); 
   MIU=II; 
end
end
%   12 CONTINUE
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
%   13	CONTINUE
for II=1:LPRJAM
NZ1PR(II)=Z1NPR(II);
NZ2PR(II)=Z2NPR(II);
NPR1(II)=PR1N(II);
NPR2(II)=PR2N(II);
M1PR(II)=PRM1(II);
M2PR(II)=PRM2(II); 
VZAC(II)=ZACV(II);
end
% 14 continue
NK1=0;
NK2=0;
for II=1:LPRJAM
NK1=NK1+NPR1(II);
NK2=NK2+NPR2(II);
end
% 17  continue
fprintf(fid,'\nСУММАРНОЕ ЧИСЛО ЦИКЛОВ НАГРУЖЕНИЙ: ШЕСТЕРНИ - %g КОЛЕСА - %g',NK1,NK2);
MIU=0;
for II=1:LPRJAM-1
if NZ1PR(II)~=NZ1PR(II+1) 
MIU=MIU+1; 
end
end
%   15 CONTINUE 
%      Oкружная сила на делительном диаметре
VZR=VZAC(LK);
TMR1=M1PR(LK);
OBR1=NZ1PR(LK);
TMR2=M2PR(LK);
OBR2=NZ2PR(LK);
%
FTH=2000*TMR1/D1;
if Z1~=Z(1)
FTH=2000.*TMR1/D2; 
end
%
%      ОПРЕДЕЛЕНИЕ ЗКВИВАЛЕНТНЫХ ЦИКЛОВ НАГРУЖЕНИЯ ПРИ ПЕРЕМЕННОЙ НАГРУЗКЕ И ПОСТОЯННЫХ ОБОРОТАХ
%
PRIZ2=1;
if MIU==0
PRIZ2=2;
fprintf(fid,'\n     РАСЧЕТ ВЕДЕТСЯ ПРИ ПЕРЕМЕННОЙ НАГРУЗКЕ И ПОСТОЯННЫХ ОБОРОТАХ'); 
%fprintf('\n     РАСЧЕТ ВЕДЕТСЯ ПРИ ПЕРЕМЕННОЙ НАГРУЗКЕ И ПОСТОЯННЫХ ОБОРОТАХ');
MUJH1=0;
MUJH2=0;
for II=1:LPRJAM
TY1=M1PR(II)/TMR1^3;
TY1=TY1*NPR1(II)/NHO1;
MUJH1=MUJH1+TY1;
if NK1>NHO1
if II<LPRJAM
    AQ1=M1PR(II+1)/TMR1; 
    AQ2=0.75*MUJH1^0.333; 
end
end
end
%   18 CONTINUE
%   19 
%   continue
for II=1:LPRJAM
TY1=(M2PR(II)/TMR2)^3;
TY1=TY1*NPR2(II)/NHO2;
MUJH2=MUJH2+TY1;
if NK2>NHO2
if II<LPRJAM
AQ1=M2PR(II+1)/TMR2;
AQ2=0.75*MUJH2^0.333;
end
end
%      IF(AQ1.LT.AQ2) GO TO 21
end
%   20 CONTINUE
%      GO TO 21
end
switch PRIZ2
    case 1
%    16 CONTINUE
%
%      ОПРЕДЕЛЕНИЕ ЗКВИВАЛЕНТНЫХ ЦИКЛОВ НАГРУЖЕНИЯ ПРИ ПЕРЕМЕННЫХ НАГРУЗКЕ И ОБОРОТАХ
fprintf(fid,'\n     РАСЧЕТ ВЕДЕТСЯ ПРИ ПЕРЕМЕННОЙ НАГРУЗКЕ И ПЕРЕМЕННЫХ ОБОРОТАХ');
%fprintf('\n     РАСЧЕТ ВЕДЕТСЯ ПРИ ПЕРЕМЕННОЙ НАГРУЗКЕ И ПЕРЕМЕННЫХ ОБОРОТАХ');
MUJH1=0;
MUJH2=0;
%
%      Коэффициент, учитывающий окружную скорость
if NTERMO1==1, ZVH1=0.85*VZR^0.1; end
if NTERMO1~=1, ZVH1=0.925*VZR^0.05; end
if NTERMO2==1, ZVH2=0.85*VZR^0.1; end
if NTERMO2~=1, ZVH2=0.925*VZR^0.05; end
if VZR<5, ZVH1=1; end
if VZR<5, ZVH2=1; end
%
%      ШЕСТЕРНЯ
%
WHT=DELTAH1*G0*VZR*sqrt(AW/U); 
NUJH=WHT*BW/(FTH*KA);
for II=1:LPRJAM
if VZAC(II)~=0
if NTERMO1==1, ZVI1=0.85*VZAC(II)^0.1; end
if NTERMO1~=1, ZVI1=0.925*VZAC(II)^0.05; end
if VZAC(II)<5, ZVI1=1; end
TY1=(M1PR(II)+NUJH*TMR1*(NZ1PR(II))/OBR1);
TY1=TY1/(TMR1*(1+NUJH));
TY1=TY1^3;
TY1=TY1*(ZVH1/ZVI1)^6;
TY1=TY1*(NPR1(II)/NHO1);
MUJH1=MUJH1+TY1;
if NK1>NHO1
if II<LPRJAM
AQ1=M1PR(II+1)/TMR1;
AQ2=MUJH1^0.3333;
AQ2=0.75*AQ2;
end
end
end
end
%   22 CONTINUE
%
%      ЗУБЧАТОЕ КОЛЕСО
%
for II=1:LPRJAM
if VZAC(II)~=0
if NTERMO2==1, ZVI2=0.85*VZAC(II)^0.1; end
if NTERMO2~=1, ZVI2=0.925*VZAC(II)^0.05; end
if VZAC(II)<5, ZVI2=1; end
WHT=DELTAH2*G0*VZAC(1)*sqrt(AW/U);
TY1=(M2PR(II)+NUJH*TMR2*(NZ2PR(II))/OBR2);
TY1=TY1/(TMR2*(1+NUJH));
TY1=TY1^3;
TY1=TY1*(ZVH2/ZVI2)^6;
TY1=TY1*(NPR2(II)/NHO2);
MUJH2=MUJH2+TY1;
if NK2>NHO2
if II<LPRJAM
AQ1=M2PR(II+1)/TMR2;
AQ2=MUJH2^0.3333;
AQ2=0.75*AQ2;
end
end     
%	IF(AQ1.LT.AQ2) GO TO 21
end
end
%   23 CONTINUE
%   21 CONTINUE
    case 2
end
NHE1=MUJH1*NHO1;
NHE2=MUJH2*NHO2;
%
ME1=TMR1; ME2=TMR2; V=VZR;
%
%  130   continue
fprintf(fid,'\nOкружная сила на делительном диаметре F(TH), H - %g',FTH);
fprintf(fid,'\nKоэффициент учитывающий характер циклограммы нагружения, MJU:');
fprintf(fid,'\n     Шестерни - %7.4f     Колеса - %7.4f',MUJH1,MUJH2); 
fprintf(fid,'\nЭквивалентное число циклов перемены напряжений N(HE):'); 
fprintf(fid,'\n     Шестерни - %g     Колеса - %g',NHE1,NHE2);
    case 2
end
%      Kоэффициент, учитывающий окружную скорость зубчатого венца
if NTERMO1==1, ZV1=0.85*V^0.1; end
if NTERMO1~=1, ZV1=0.925*V^0.05; end
if NTERMO2==1, ZV2=0.85*V^0.1; end
if NTERMO2~=1, ZV2=0.925*V^0.05; end
if VZAC(1)<5, ZV1=1; end
if VZAC(1)<5, ZV2=1; end
fprintf(fid,'\nКоэффициенты, учитывающие окружную скорость Z(V):'); 
fprintf(fid,'\n     Шестерни - %g     Колеса - %g',ZV1,ZV2);
%      Kоэффициент, учитывающий радиальный размер зубчатого колеса
KXH1=sqrt(1.07-D1*10^-4);
if D1<700, KXH1=1; end
KXH2=sqrt(1.07-D2*10^-4);
if D2<700, KXH2=1; end
fprintf(fid,'\nKоэффициент, учитывающий радиальный размер зубчатого колеса K(XH):');
fprintf(fid,'\n     Шестерни - %g     Колеса - %g',KXH1,KXH2);
%	 Kоэффициент, учитывающий влияние смазки 
KL=1;
fprintf(fid,'\nKоэффициент, учитывающий влияние смазки K(L) - %g',KL);
fprintf(fid,'\nKоэффициент, учитывающий шероховатость сопряженных поверхностей зубьев Z(R) -  %g',ZR);
%      Коэффициент долговечности
PZN=1/6;
if NHE1>NHO1, PZN=1/20; end
%    	IF(NK1.GT.NHO1) PZN=1./20.
ZN=(NHO1/NHE1)^PZN;
if ZN<0.75, ZN=0.75; end
if NTERMO1<2
if ZN>2.6, ZN=2.6; end, end     
if NTERMO1>2
if ZN>1.8, ZN=1.8; end, end
ZN1=ZN;
%      Предел контактной выносливости поверхностей зубьев шестерни, МПа
SIGMAHLIM1=ZN*SIGMAHLIMB1;
%      Допускаемые контактные  напряжения для шестерни, МПа
SIGMAHP1=SIGMAHLIM1*ZR*ZV1*KL*KXH1/SH1;
%
PZN=1/6;
if NHE2>NHO2, PZN=1/20; end
%    	IF(NK2.GT.NHO1) PZN=1./20.
ZN=(NHO2/NHE2)^PZN; 
if ZN<0.75, ZN=0.75; end
if NTERMO2<2
if ZN>2.6, ZN=2.6; end
end
if NTERMO2>2
if ZN>1.6, ZN=1.8; end
end
fprintf(fid,'\nКоэффициент долговечности Z(N):');
fprintf(fid,'\n     Шестерни - %g     Колеса - %g',ZN1,ZN);
%      Предел контактной выносливости поверхностей зубьев шестерни, МПа
SIGMAHLIM2=ZN*SIGMAHLIMB2;
fprintf(fid,'\nПредел контактной выносливости поверхностей зубьев SIGMA(HLIM), MПa:');
fprintf(fid,'\n     Шестерни - %g     Колеса - %g',SIGMAHLIM1,SIGMAHLIM2);
%      Допускаемые контактные  напряжения для зубчатого колеса, (МПа)
SIGMAHP2=SIGMAHLIM2*ZR*ZV2*KL*KXH2/SH2;
fprintf(fid,'\nДопускаемые контактные напряжения SIGMA(HP), МПа:');
fprintf(fid,'\n     Шестерни - %g     Колеса - %g',SIGMAHP1,SIGMAHP2);
if BETTA==0
SIGMAHPPR=SIGMAHP1; 
if SIGMAHP1>SIGMAHP2, SIGMAHPPR=SIGMAHP2; end
end
if BETTA~=0
KI=2*pi*EALFA1/(Z1*tan(ALFATW));
KII=KI*EALFA1/EALFA2;
DELTA1=1.+0.5*KI-0.5*KI/U-(KI^2)/(3.*U);
DELTA2=1.-(0.5*KII)+(0.5*KII/U)-((KII^2)/(3.*U));
HB1=HPOVZUB1;
if NTERMO1~=1, HB1=350.+11.5*(HPOVZUB1-39.3); end
HB2=HPOVZUB2;
if NTERMO2~=1, HB2=350.+11.5*(HPOVZUB1-39.3); end
MUJK1=1.6*(200./HB1)^0.25;
MUJK2=1.6*(200./HB2)^0.25;
SIGMAHPI=MUJK1*SIGMAHP1;
if SIGMAHPI>SIGMAHP2, SIGMAHPI=SIGMAHP2; end
SIGMAHPI=SIGMAHPI^2;
SIGMAHPII=MUJK2*SIGMAHP2;
if SIGMAHPII>SIGMAHP1, SIGMAHPII=SIGMAHP1; end
SIGMAHPII=SIGMAHPII^2;
SIGMAHPPR=sqrt((EALFA1*DELTA1*SIGMAHPI+EALFA2*DELTA2*SIGMAHPII)/EALFA);
end
fprintf(fid,'\n     ');
fprintf(fid,'\nДопускаемые контактные  напряжения передачи, МПа - %g',SIGMAHPPR); 
fprintf(fid,'\n     ');
%
%      РАСЧЕТ ДЕЙТВУЮЩИХ КОНТАКТНЫХ НАПРЯЖЕНИЙ ЗУБЧАТОЙ ПЕРЕДАЧИ
%
%      Коэффициент учитывающий форму сопряженных поверхностей зубьев
fprintf(fid,'\n-----------------------------------------------------');
fprintf(fid,'\nРАСЧЕТ НА КОНТАКТНУЮ ВЫНОСЛИВОСТЬ');  
fprintf(fid,'\n     ');
TY1=1/cos(ALFAT);
AQ1=sqrt(2*cos(BETTAB)/tan(ALFATW));
ZH=TY1*AQ1;
fprintf(fid,'\nКоэффициент, учитывающий форму сопряженных поверхностей зубьев, Z(H) - %g',ZH);
%      Коэффициент, учитывающий суммарную длину контактных линий
if EBETTA>1, ZEPSILON=sqrt(1/EALFA); end
if EBETTA<1
WSD=(4.-EALFA)*(1-EBETTA)/3;
WED=EBETTA/EALFA;
ZEPSILON=sqrt(WSD+WED); 
end
if EBETTA==0, ZEPSILON=sqrt((4-EALFA)/3); end
fprintf(fid,'\nКоэффициент, учитывающий суммарную длину контактных линий, Z(EPSILON) - %g',ZEPSILON); 
%      Коэффициент, учитывающий распределение нагрузки между зубьями
if BETTA==0, KHALFA=1; end
if BETTA~=0
if ITOCH==9, KHALFA=1.1+0.06*V/5; end
if ITOCH==8, KHALFA=1.055+0.035*V/5; end
if ITOCH==7, KHALFA=1.02+0.05*V/10; end
if ITOCH==6, KHALFA=1.0+0.04*V/15; end
if ITOCH==5, KHALFA=1.02; end 
end
fprintf(fid,'\nКоэффициент, учитывающий внешнюю динамическую нагрузку K(A) - %g',KA);
fprintf(fid,'\nКоэффициент, учитывающий распределение нагрузки между зубьями, K(HALFA) -  %g',KHALFA);
TY1=EY/(EALFA*ZEPSILON^2);
if KHALFA>TY1
fprintf('\nKHALFA > EY/(EALFA*ZEPSILON**2)');
end
VOKR=VZAC(1);
%
%      Коэффициент, учитывающий динамическую нагрузку, возникающую в зацеплении
%
[KHV] = OPREDKV(FTH,Z1,VOKR);
%
%      WHT=DELTAH1*G0*VZAC(1)*SQRT(AW/U)
%	NUJH=WHT*BW/(FTH*KA)
%      KHV=1+NUJH
fprintf(fid,'\nКоэффициент, учитывающий динамическую нагрузку, возникающую в зацеплении, K(HV) - %g',KHV);
%      Коэффициент, учитывающий распределение нагрузки по ширине венца, K(HBETTA)
%
[KHBETTA] = KHBET();
%
fprintf(fid,'\nКоэффициент, учитывающий распределение нагрузки по ширине венца, K(HBETTA) -%g',KHBETTA);
%      Коэффициент нагрузки 
KH=KA*KHV*KHBETTA*KHALFA;
fprintf(fid,'\nКоэффициент нагрузки K(H) - %g',KH);
fprintf(fid,'\n   ');
%      Контактное напряжение без учета дополнительных нагрузок, МПа
SIGMAHO=ZH*ZEPSILON*ZE;
TY1=FTH*(U+1.)/(BW*D1*U);
TY1=sqrt(TY1);
SIGMAHO=SIGMAHO*TY1;
fprintf(fid,'\nКонтактные напряжения без учета дополнительных нагрузок SIGMA(HO), МПа - %g',SIGMAHO);
%      Действующие в полюсе зацепления контактные напряжения, МПа
SIGMAH=SIGMAHO*sqrt(KH);
fprintf(fid,'\nДействующие в полюсе зацепления контактные напряжения SIGMA(H), МПа - %g',SIGMAH);
fprintf(fid,'\n-----------------------------------------------------');
if SIGMAH>SIGMAHPPR
fprintf(fid,'\n    ВНИМАНИЕ!!!');
fprintf(fid,'\nДействующие контактные напряжения больше допускаемых');
fprintf(fid,'\nSIGMAH=%g,  SIGMAHPPR=%g',SIGMAH,SIGMAHPPR);
fprintf('\n    ВНИМАНИЕ!!!');
fprintf('\nДействующие контактные напряжения больше допускаемых');
fprintf('\nSIGMAH=%g,  SIGMAHPPR=%g',SIGMAH,SIGMAHPPR);
PRICNAKH=2;
return
end
%
%      Расчет на контактную прочность при действии максимальной нагрузки
%
fprintf(fid,'\n     РАСЧЕТ НА КОНТАКТНУЮ ПРОЧНОСТЬ ПРИ ДЕЙСТВИИ МАКСИМАЛЬНОЙ НАГРУЗКИ');
fprintf(fid,'\n    ');
%      Коэффициент, учитывающий динамическую нагрузку, возникающую в зацеплении
if LKJ==1
AQ1=0;
for II=1:NPER+NPER3X
if KMMCK(II)>=0 
if AQ1<abs(KMMCK(II)) AQ1=abs(KMMCK(II)); end
end
end
end
%   26 CONTINUE
if LKJ==2
AQ1=0;
for II=1:NPER+NPER3X
if KMMCK(II)<=0
if AQ1<abs(KMMCK(II)); AQ1=abs(KMMCK(II)); end
end
end
end
%   25 CONTINUE
AQ1=KTR*MDVSMAX*AQ1/AST;
FTHMAX=2000*AQ1/D1;
if Z1~=Z(1), FTHMAX=2000*AQ1/D2; end
%      WHT=DELTAH1*G0*VZAC(1)*SQRT(AW/U)
%	NUJH=WHT*BW/(FTHMAX*KA)
%      KHV=1+NUJH
VOKR=VZAC(1);
%
%      Коэффициент, учитывающий динамическую нагрузку, возникающую в зацеплении
%
[KHV] = OPREDKV(FTHMAX,Z1,VOKR);
%
fprintf(fid,'\nКоэффициент, учитывающий динамическую нагрузку, возникающую в зацеплении при max моменте, K(HV) - %g',KHV);
KHMAX=KA*KHV*KHBETTA*KHALFA;
fprintf(fid,'\nКоэффициент нагрузки K(HMAX) - %g',KHMAX);
fprintf(fid,'\nМаксимальный момент М(max), Нм - %g',AQ1);
fprintf(fid,'\nСредний момент М(1), Нм - %g',M1PR(1));
AQ1=(KHMAX*AQ1)/(KH*M1PR(1));
SIGMAHMAX=SIGMAH*sqrt(AQ1);
%      
if (SIGMAHMAX>SIGMAHPMAX1)|(SIGMAHMAX>SIGMAHPMAX2)
fprintf(fid,'\nМаксимальные контактные напряжения больше допускаемых:');
fprintf(fid,'\nSIGMAHMAX = %g  SIGMAHPMAX = %g',SIGMAHMAX,SIGMAHPMAX1);
fprintf('\nМаксимальные контактные напряжения больше допускаемых:');
fprintf('\nSIGMAHMAX = %g  SIGMAHPMAX = %g',SIGMAHMAX,SIGMAHPMAX1);
PRICNAKH=2;
return
end
fprintf(fid,'\n	  ');
fprintf(fid,'\nКонтактные напряжения при действии максимальной нагрузки SIGMA(HMAX), МПа - %g',SIGMAHMAX);
fprintf(fid,'\nДопускаемые контактные напряжения при действии максимальной нагрузки SIGMA(HPMAX):');
fprintf(fid,'\n     Шестерни - %g     Колеса - %g',SIGMAHPMAX1,SIGMAHPMAX2);
end

