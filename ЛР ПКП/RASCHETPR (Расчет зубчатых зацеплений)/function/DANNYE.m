function [NPRIZ] = DANNYE(IVAR)
%
%Подпрограмма определения основных характеристик нагружения и свойств материала
%
global M BETTA IDVIJ ITOCH ASTAL1 ASTAL2 IRASPRED DOLJAORIG
global HPOVZUB1 HPOVZUB2 NPER NTERMO1 NTERMO2 SIGMAFLIM01 SIGMAFLIM02
global NPERPOV1 NPERPOV2 NZAGOT1 NZAGOT2 SIGMAT1 SIGMAT2 fid
global DOLJA GAMMAFC KA KXF YR KFG1 KFD1 SFII1 YDST2 YGST2 NPER3X
global KFG2 KFD2 SFII2 DELTAF G0 KFLMAX1 KFLMAX2 QF1 QF2 NFO SF1 SF2
global SH1 SH2 RA ZR NHO1 NHO2 SIGMAHLIMB1 SIGMAHLIMB2 DELTAH1 DELTAH2
global ZE SIGMAHPMAX1 SIGMAHPMAX2 SIGMSFST01 SIGMSFST02 YDST1 YGST1 
global ALFA HA HF C ROF HL HOMEGA
%
%    Распределение времени работы колесных машин на отдельных передачах
%fid=fopen('PR1.dat','a+');
DOLJAK4= [0.01 0.04 0.25 0.65 0.05];
DOLJAK5= [0.01 0.03 0.12 0.24 0.55 0.05];
DOLJAK6= [0.01 0.025 0.06 0.12 0.235 0.50 0.05];
DOLJAK7= [0.01 0.02 0.04 0.08 0.12 0.23 0.45 0.05];
DOLJAK8= [0.01 0.02 0.035 0.05 0.075 0.13 0.23 0.40 0.05];
DOLJAK9= [0.005,0.01,0.02,0.035,0.055,0.09,0.15,0.235,0.3,0.05];
DOLJAK10= [0.005 0.01 0.015 0.025 0.04 0.065 0.10 0.15 0.24 0.30 0.05];
DOLJAK11= [0.005 0.01 0.015 0.025 0.04 0.060 0.10 0.15 0.24 0.30 0.05 0.005];
%     Распределение времени движения военной гусеничной машины на отдельных передачах 
DOLJAG3= [0.10 0.35 0.50 0.05];
DOLJAG4= [0.07 0.2 0.35 0.33 0.05];
DOLJAG5= [0.5 0.10 0.18 0.32 0.30 0.05];
DOLJAG6= [0.04 0.06 0.15 0.22 0.33 0.15 0.05];
DOLJAG7= [0.03 0.05 0.12 0.15 0.30 0.25 0.01 0.05];
DOLJAG8= [0.02 0.04 0.06 0.1 0.13 0.25 0.25 0.1 0.05];
NFO=4000000;
KA=1.75; KXF=1; YR=1; ZE=190; ALFA=20; HA=1; HF=1.25; C=0.25; ROF=0.38;
HL=2; HOMEGA=2; 
if IVAR == 1
 ALFA=pi*ALFA/180; end
PRIZNAK=1;
if IRASPRED == 0 
PRIZNAK=2;
 for II=1:NPER+NPER3X
 DOLJA(II)=DOLJAORIG(II);  end
end
switch PRIZNAK
    case 1
if IRASPRED ~= 0
if IDVIJ==1
if NPER == 4
for II=1:5
DOLJA(II)=DOLJAK4(II); end
end
if NPER == 5
for II=1:6
DOLJA(II)=DOLJAK5(II); end
end
if NPER == 6
for II=1:7
DOLJA(II)=DOLJAK6(II); end
end
if NPER == 7
for II=1:8
DOLJA(II)=DOLJAK7(II); end
end
if NPER==8
for II=1:9
DOLJA(II)=DOLJAK8(II); end
end
if NPER==9 
for II=1:10
DOLJA(II)=DOLJAK9(II); end
end
if NPER==10
for II=1:11
DOLJA(II)=DOLJAK10(II); end
end
if NPER==11 
for II=1:12
DOLJA(II)=DOLJAK11(II); end
end
end
end
if IDVIJ==2
if NPER==3
for II=1:4
DOLJA(II)=DOLJAG3(II); end
end
if NPER==4
for II=1:5
DOLJA(II)=DOLJAG4(II); end
end
if NPER==5
for II=1:6
DOLJA(II)=DOLJAG5(II); end
end
if NPER==6
for II=1:7
DOLJA(II)=DOLJAG6(II); end
end
if NPER==7
for II=1:8
DOLJA(II)=DOLJAG7(II); end
end
if NPER==8
for II=1:9
DOLJA(II)=DOLJAG8(II); end
end
end
if IVAR==1   
fprintf (fid,'\nГИСТОГРАММА РАСПРЕДЕЛЕНИЯ ВРЕМЕНИ ДВИЖЕНИЯ ПО ПЕРЕДАЧАМ:');
fprintf (fid,'\n%g %g %g %g %g %g %g %g %g %g %g',DOLJA);
end
    case 2
end
if NTERMO1<=2, GAMMAFC=0.35; end
if NTERMO1>2, GAMMAFC=0.25; end
if NTERMO1==5, GAMMAFC=0.01; end
if NZAGOT1==1, SFII1=1; end
if NZAGOT1==2, SFII1=1.15; end
if NZAGOT1==3, SFII1=1.3; end
if NZAGOT2==1, SFII2=1; end
if NZAGOT2==2, SFII2=1.15; end
if NZAGOT2==3, SFII2=1.3; end
%     Показатель степени кривой усталости при расчете на изгибную прочность 
QF1=6;
if NTERMO1>=3, QF1=9; end
if NPERPOV1==1, QF1=6; end
QF2=6;
if NTERMO2>=3, QF2=9; end
if NPERPOV2==1, QF2=6; end
if QF1==6, KFLMAX1=2.08; end
if QF1==9, KFLMAX1=1.63; end
if QF2==6, KFLMAX2=2.08; end
if QF2==9, KFLMAX2=1.63; end
DELTAF=0.11;
if BETTA~=0, DELTAF=0.06; end
if NTERMO1<=2
if BETTA==0, DELTAH1=0.06; end
if BETTA~=0, DELTAH1=0.02; end
end
if NTERMO1>2
if BETTA==0, DELTAH1=0.14; end
if BETTA~=0, DELTAH1=0.04; end
end
if NTERMO2<=2
if BETTA==0, DELTAH2=0.06; end
if BETTA~=0, DELTAH2=0.02; end
end
if NTERMO2>2
if BETTA==0, DELTAH2=0.14; end
if BETTA~=0, DELTAH2=0.04; end
end
if M<3.55
if ITOCH<=6, G0=3.8; end
if ITOCH==7, G0=4.7; end
if ITOCH==8, G0=5.6; end
if ITOCH==9, G0=7.3; end
end
if (M>=3.55)&&(M<10)
if ITOCH<=6, G0=4.2; end
if ITOCH==7, G0=5.3; end
if ITOCH==8, G0=6.1; end
if ITOCH==9, G0=8.2; end
end
if M>=10
if ITOCH<=6, G0=4.8; end
if ITOCH==7, G0=6.4; end
if ITOCH==8, G0=7.3; end
if ITOCH==9, G0=10.0; end
end 
%      Kоэффициент безопасности
if NTERMO1<=2, SH1=1.1; end
if NTERMO1>2,  SH1=1.2; end
if NTERMO2<=2, SH2=1.1; end
if NTERMO2>2,  SH2=1.2; end
%      Kоэффициент учитывающий шерохоиватость поверхностей зубьев
if ITOCH==7, RA=1.25; end
if ITOCH<7,  RA=0.63; end
if ITOCH>=8, RA=2.50; end
%    Kоэффициент, учитывающий шероховатость сопряженных поверхностей зубьев
if RA<=1.25, ZR=1; end
if (RA>1.25) & (RA<=2.51) 
    ZR=0.95; 
end
if RA>2.5,   ZR=0.9; end
%      БАЗОВОЕ ЧИСЛО ЦИКЛОВ
NHO1=120000000;
if NTERMO1<=2, NHO1=30*HPOVZUB1^2.4; end
if NHO1>120000000, NHO1=120000000; end
NHO2=120000000;
if NTERMO2<=2, NHO1=30.*HPOVZUB2^2.4; end
if NHO2>120000000, NHO2=120000000; end
%      Предел контактной выносливости поверхностей зубьев шестерен      
if NTERMO1==1, SIGMAHLIMB1=2.*HPOVZUB1+70; end
if NTERMO2==1, SIGMAHLIMB2=2.*HPOVZUB2+70; end
if NTERMO1==2, SIGMAHLIMB1=18.*HPOVZUB1+150; end
if NTERMO2==2, SIGMAHLIMB2=18.*HPOVZUB2+150; end
%
if NTERMO1==3, SIGMAHLIMB1=17.*HPOVZUB1+200; end
if NTERMO2==3, SIGMAHLIMB2=17.*HPOVZUB2+200; end
%
if NTERMO1==4, SIGMAHLIMB1=23.*HPOVZUB1; end
if NTERMO2==4, SIGMAHLIMB2=23.*HPOVZUB2; end
%
if NTERMO1==5, SIGMAHLIMB1=20.*HPOVZUB1; end
if NTERMO2==5, SIGMAHLIMB2=20.*HPOVZUB2; end
%
if NTERMO1==6, SIGMAHLIMB1=23.*HPOVZUB1; end
if NTERMO2==6, SIGMAHLIMB2=23.*HPOVZUB2; end
%      Допускаемое контактное напряжение при максимальной нагрузке
if NTERMO1<=2, SIGMAHPMAX1=2.8*SIGMAT1; end
if NTERMO2<=2, SIGMAHPMAX2=2.8*SIGMAT2; end
if NTERMO1>2, SIGMAHPMAX1=44.*HPOVZUB1; end
if NTERMO2>2, SIGMAHPMAX2=44.*HPOVZUB2; end
if NTERMO1==5, SIGMAHPMAX1=3.*HPOVZUB1; end
if NTERMO2==5, SIGMAHPMAX2=3.*HPOVZUB2; end 
%      Коэффициент, учитывающий влияние деформационного упрочнения переходной поверхности зуба
YDST1=1;
if (NTERMO1 == 2)||(NTERMO1 == 3), YDST1=1.1; end
if NTERMO1 == 4, YDST1=1.05; end
if NTERMO1 == 6, YDST1=0.95; end
YDST2=1;
if (NTERMO2==2)||(NPERPOV2==3), YDST2=1.1; end
if NTERMO2==4, YDST2=1.05; end
if NTERMO2==6, YDST2=0.95; end
%   Kоэффициент, учитывающий влияние шлифования переходной поверхности зуба 
YGST1=1;
if NPERPOV1~=0, YGST1=1; end
YGST2=1;
if NPERPOV2~=0, YGST2=1; end
%      ОПРЕДЕЛЕНИЕ МАРКИ СТАЛИ
%
[MOLIB1,NIKEL1,UGLEROD1,SIGMAT11,NPRIZ] = OPREDMS (1,ASTAL1);
if NPRIZ ~= 0, return; end
%
[MOLIB2,NIKEL2,UGLEROD2,SIGMAT22,NPRIZ] = OPREDMS (2,ASTAL2);
if NPRIZ ~= 0, return; end
%
%      Базовое значение предельного напряжения зубьев при изгибе максимальной нагрузкой
SIGMAT1=SIGMAT11;
SIGMAT2=SIGMAT22;
if NTERMO1==1, SIGMSFST01=6.5*HPOVZUB1; end
if NTERMO2==1, SIGMSFST02=6.5*HPOVZUB2; end
if NTERMO1==2, SIGMSFST01=2250;
if NIKEL1==1, SIGMSFST01=2500; end
end
if NTERMO2==2, SIGMSFST02=2250;
if NIKEL2==1,  SIGMSFST01=2500; end
end
if NTERMO1==3, SIGMSFST01=1800;
if NIKEL1==1,  SIGMSFST01=2200; end
end
if NTERMO2==3, SIGMSFST02=1800;
if NIKEL2==1, SIGMSFST02=2200; end
end 
if NTERMO1==4, SIGMSFST01=2000;
if NIKEL1==1,  SIGMSFST01=2800; end
end
if NTERMO2==4, SIGMSFST02=2000; 
if NIKEL2==1, SIGMSFST02=2800; end
end
if NTERMO1==5, SIGMSFST01=1800; end
if NTERMO2==5, SIGMSFST02=1800; end
if NTERMO1==6, SIGMSFST01=2200;
if MOLIB1==1,  SIGMSFST01=2500; end
end
if NTERMO2==6, SIGMSFST02=2200;
if MOLIB2==1,  SIGMSFST02=2500; end
end
%
[SIGMAFLIM01,KFG1,KFD1,SF1]=IZGIB1(1,NTERMO1,UGLEROD1,MOLIB1,HPOVZUB1);
%
[SIGMAFLIM02,KFG2,KFD2,SF2]=IZGIB1(2,NTERMO2,UGLEROD2,MOLIB2,HPOVZUB2);
%
popp=SF2;
end

