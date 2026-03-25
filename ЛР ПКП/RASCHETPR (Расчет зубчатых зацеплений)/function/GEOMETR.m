function [ PRIZNAKH ] = GEOMETR( Z1,Z2,X1,X2,KZAC,IVAR,IPR )
%
global M BW BETTA Z WSAT PROM AWZ XX1 ZZ1 ZZ2 KZAC1 ALFA HA C HL
global V DW1 DW2 ITOCH U AW EALFA1 EALFA2 ALFATW EALFA
global ALFAT BETTAB EY D1 D2 EBETTA ZV1 ZV2 fid A
%
PRIZNAKH=1;
%      Определение коэффициента смещения для БЦК
if (IVAR~=1) && (IPR~=0)
XX1=X1; ZZ1=Z1; ZZ2=Z2; KZAC1=KZAC;
%
[X2] = fzero (@POISKX3,0.05);
if abs(X2) < 0.01, X2=0; end
%
end 
%      Делительное межосевое расстояние, мм
fprintf (fid,'\nКоэффициенты смещения Х(1)= %g, X(2)= %g',X1,X2);     
%
if KZAC>0, A=(Z2+Z1)*M/(2.*cos(BETTA));  
end
if KZAC<0, A=(Z2-Z1)*M/(2.*cos(BETTA));  
end
fprintf (fid,'\nДелительное межосевое расстояние a, мм: %g',A);
%       Коэффициент суммы смещений (для внешнего зацепления)
XSUM=X1+X2;
if KZAC>0 
    fprintf (fid,'\nКоэффициент суммы смещений - X(СУМ)= %g',XSUM); 
end
%       Коэффициент разности смещений (для внутреннего зацепления)
XD=X2-X1;
if KZAC<0
    fprintf (fid,'\nКоэффициент разности смещений X(d)= %g',XD);
end
%       Угол профиля 
PROM=tan(ALFA)/cos(BETTA);
ALFAT=atan(PROM); ALT=180*ALFAT/pi;
fprintf (fid,'\nУгол профиля ALFA(t)= %g',ALT);
%       Угол зацепления
INVA=tan(ALFAT)-ALFAT;
if KZAC>0, PROM=2.*XSUM*tan(ALFA)/(Z2+Z1); end
if KZAC<0, PROM=2.*XD*tan(ALFA)/(Z2-Z1); end
PROM=PROM+INVA;
%
[ALFATW] = fzero(@GG2,0.15);
AS=180*ALFATW/pi;
%
ALT=180*ALFATW/pi;
fprintf (fid,'\nУгол зацепления ALFA(tw)= %g',ALT);
%      Межосевое расстояние, мм
AW=A*cos(ALFAT)/cos(ALFATW);
if IVAR==1, AWZ=AW; end
fprintf (fid,'\nМежосевое расстояние a(w), мм= %g',AW);
%      Делительные диаметры, мм
D1=Z1*M/cos(BETTA); D2=(Z2*M)/cos(BETTA);
fprintf (fid,'\nДелительные диаметры d, мм:');      
fprintf (fid,'\nШестерни = %g Колеса = %g', D1,D2);
%      Передаточное отношение  
U=Z2/Z1;
fprintf (fid,'\nПередаточное отношение U= %g',U);
%      Начальные диаметры, мм
if KZAC>0, DW1=2*AW/(U+1); DW2=2*AW*U/(U+1); end
if KZAC<0, DW1=2*AW/(U-1); DW2=2*AW*U/(U-1); end
fprintf (fid,'\nНачальные диаметры d(w), мм:');
fprintf (fid,'\nШестерни = %g Колеса = %g',DW1,DW2);
%      Коэффициент воспринимаемого смещения
Y=(AW-A)/M;
if abs(Y) < 0.001, Y=0; end 
fprintf (fid,'\nКоэффициент воспринимаемого смещения Y = %g',Y);
%      Коэффициент уравнительного смещения
if KZAC>0, DELTAY=XSUM-Y; end
if KZAC<0, DELTAY=XD-Y; end
if abs(DELTAY) < 0.001, DELTAY=0; end 
fprintf (fid,'\nКоэффициент уравнительного смещения DELTA(Y) = %g',DELTAY);
%      Диаметры вершин зубьев, мм
if KZAC>0, DA1=D1+2*M*(HA+X1-DELTAY); DA2=D2+2*M*(HA+X2-DELTAY); end
if KZAC<0, DA1=D1+2*M*(HA+X1); DA2=D2-2*M*(HA-X2-0.2); end
fprintf (fid,'\nДиаметры вершин зубьев d(a), мм:');
fprintf (fid,'\nШестерни: %g  Колеса: %g',DA1,DA2);
%      Диаметры впадин зубьев, мм
if KZAC>0, DF1=D1-2*M*(HA+C-X1); DF2=D2-2*M*(HA+C-X2); end
if KZAC<0, DF1=D1-2*M*(HA+C-X1); DF2=D2+2*M*(HA+C+X2); end
fprintf (fid,'\nДиаметры впадин зубьев d(f), мм:');
fprintf (fid,'\nШестерни: %g  Колеса: %g',DF1,DF2);
%      Основной диаметр, мм
DB1=D1*cos(ALFAT); DB2=D2*cos(ALFAT);
fprintf (fid,'\nOcновной диаметр d(b), мм:');
fprintf (fid,'\nШестерни: %g  Колеса: %g',DB1,DB2);
%      Угол профиля зуба в точке окружности вершин
ALFAA1=acos(DB1/DA1); ALT1=180*ALFAA1/pi;
ALFAA2=acos(DB2/DA2); ALT2=180*ALFAA2/pi;
fprintf (fid,'\nУгол профиля зуба в точке окружности вершин ALFA(a):');
fprintf (fid,'\nШестерни: %g  Колеса: %g',ALT1,ALT2);
%      Шаг зацепления, мм
PALFA=3.14*M*cos(ALFA);
fprintf (fid,'\nШаг зацепления P(alfa), мм: %g',PALFA);
%      Осевой шаг, мм
if BETTA~=0, PX=3.14*M/sin(BETTA);
  fprintf (fid,'\nОсевой шаг P(x), мм: %g',PX);
end
%      Коэффициенты торцевого перекрытия 	     
EALFA1=Z1*(tan(ALFAA1)-tan(ALFATW))/(2*pi); 
EALFA2=Z2*(tan(ALFAA2)-tan(ALFATW))/(2*pi);
fprintf (fid,'\nКоэффициенты торцевого перекрытия E(ALFA):');
fprintf (fid,'\nШестерни: %g  Колеса: %g',EALFA1,EALFA2);
%      Минимальные коэффициенты смещения зубчатых колес
if BETTA==0, AR1=(sin(ALFA))^2; AR2=0.5*Z1*AR1; XMIN1=HL-HA-AR2; 
end
if BETTA~=0 
    AR1=1/tan(ALFA);
    AR2=(cos(BETTA)*AR1)^2;
    AR3=1+AR2;
    AR1=cos(BETTA)*AR3; 
    AR2=0.5*Z1/AR1; 
    XMIN1=HL-HA-AR2; 
end
%      WRITE (15,231)
%  231 FORMAT(1X,'Минимальный коэффициент смещения:')    
if BETTA==0, AR1=(sin(ALFA))^2; AR2=0.5*Z2*AR1;
   XMIN1=HL-HA-AR2; 
end
if BETTA~=0, AR1=1/(tan(ALFA)); AR2=(cos(BETTA)*AR1)^2;
   AR3=1+AR2; AR1=cos(BETTA)*AR3; AR2=0.5*Z2/AR1;
   XMIN2=HL-HA-AR2; 
end
%      WRITE (15,18) XMIN1,XMIN2
%      Максимальные коэффициенты смещения зубчатых колес
AR1=tan(ALFAA1)-ALFAA1; AR2=tan(ALFAT)-ALFAT;
if KZAC>0, AR3=AR1-AR2; end
if KZAC<0, AR3=AR1+AR2; end
AR1=2.*Z1*AR3-pi; AR2=4*tan(ALFA);
XMAX1=AR1/AR2;
%      Коэффициент торцевого перекрытия
if KZAC>0, EALFA=(Z1*tan(ALFAA1)+Z2*tan(ALFAA2)-(Z1+Z2)*tan(ALFATW))/(2*pi);
end
if KZAC<0, EALFA=(Z1*tan(ALFAA1)-Z2*tan(ALFAA2)+(Z2-Z1)*tan(ALFATW))/(2*pi);
end
fprintf (fid,'\nКоэффициенты торцевого перекрытия E(ALFA): %g',EALFA);
%      Коэффициент осевого перекрытия 
EBETTA=0;
if BETTA~=0, EBETTA=BW/PX;
  fprintf (fid,'\nКоэффициенты осевого перекрытия E(BETTA): %g',EALFA);
end
%      Коэффициент перекрытия 	
EY=EALFA+EBETTA;
fprintf (fid,'\nКоэффициенты перекрытия E(Y): %g',EY);
%      Основной угол наклона 		
PROM=sin(BETTA)*cos(ALFA); BETTAB=asin(PROM); ALT=180.*BETTAB/pi;	
fprintf (fid,'\nОсновной угол наклона BETTA(B): %g',ALT);
%	 Эквивалентное число зубьев 
ZV1=Z1/(cos(BETTA))^3; ZV2=Z2/(cos(BETTA))^3;
fprintf (fid,'\nЭквивалентное число зубьев Z(V):');
fprintf (fid,'\nШестерни: %g  Колеса: %g',ZV1,ZV2);
%      Окружная скорость в зацеплении, м/с
V=pi*D1*WSAT/60000;
if Z(1)==Z1, V=pi*D2*WSAT/60000; end
fprintf (fid,'\nОкружная скорость в зацеплении V, м/с: %g',V);
%fprintf ('\nОкружная скорость в зацеплении V, м/с: %g',V);
%      Удельное скольжение
if KZAC>0, QE1=(U+1)*(tan(ALFAA2)-tan(ALFATW));
           QE2=tan(ALFATW)-U*(tan(ALFAA1)-tan(ALFATW)); end
if KZAC<0, QE1=(U-1)*(tan(ALFAA2)-tan(ALFATW));
           QE2=tan(ALFATW)+U*(tan(ALFAA1)-tan(ALFATW)); end
UV1=QE1/QE2;
if KZAC>0, QE1=(U+1)*(tan(ALFAA1)-tan(ALFATW));
           QE2=U*tan(ALFATW)-(tan(ALFAA1)-tan(ALFATW)); end
if KZAC<0, QE1=(U-1)*(tan(ALFAA1)-tan(ALFATW));
           QE2=U*tan(ALFATW)+(tan(ALFAA1)-tan(ALFATW)); end
UV2=QE1/QE2;
fprintf (fid,'\nУдельное скольжение:');
fprintf (fid,'\nШестерни: %g  Колеса: %g',UV1,UV2);
%      Назначение степени точности изготовления зубчатых колес
if BETTA==0
if V<2, ITOCH=9; end
if (V>=2)&&(V<6), ITOCH=8; end
if (V>=6)&&(V<10), ITOCH=7; end
if (V>=10)&&(V<20), ITOCH=6; end
if (V>=20)&&(V<35), ITOCH=5; end
if (V>=35)&&(V<40), ITOCH=4; end
if V>=40, ITOCH=3; end
end
if BETTA~=0
if V<4, ITOCH=9; end
if (V>=4)&&(V<10), ITOCH=8; end
if (V>=10)&&(V<15), ITOCH=7; end
if (V>=15)&&(V<40), ITOCH=6; end
if (V>=40)&&(V<70), ITOCH=5; end
if (V>=70)&&(V<75), ITOCH=4; end
if V>=75, ITOCH=3; end
end
fprintf (fid,'\nСтепень точности изготовления зубчатых колес: %g', ITOCH);
%fprintf ('\nСтепень точности изготовления зубчатых колес: %g', ITOCH);
%      Проверка подрезания профиля зуба 
if BETTA==0, ZMIN=2*(HL-HA-X1)/(sin(ALFA))^2; end
if BETTA~=0 
ZMIN=2.*(HL-HA-X1)*cos(BETTA)*(((cos(BETTA))^2/(tan(ALFA))^2)+1); end      
if Z1<ZMIN
    fprintf('\nZ1<ZMIN  Z1= %g ZMIN= %g',Z1,ZMIN);
    PRIZNAKH=2;
    return
end
%       STOP
%      Проверка заострения профиля зуба 
if BETTA==0, XMIN1=HL-HA-0.5*Z1*(sin(ALFA))^2; end
CTAN=(1/tan(ALFA))^2;
if BETTA~=0 
XMIN1=HL-HA-0.5*Z1/(cos(BETTA)*(((cos(BETTA))^2)*CTAN+1)); end 
if X1<XMIN1 
    fprintf('\nX1<XMIN1  Z1= %g ZMIN= %g',X1,XMIN1);
    PRIZNAKH=2;
    return
end
%       STOP
if BETTA==0, XMIN2=HL-HA-0.5*Z2*(sin(ALFA))^2; end
CTAN=(1/tan(ALFA))^2;
if BETTA~=0 
XMIN2=HL-HA-0.5*Z2/(cos(BETTA)*(((cos(BETTA))^2)*CTAN+1)); end
if X2<XMIN2 
    fprintf('\nX2<XMIN2  Z2= %g ZMIN2= %g',X2,XMIN2);
    PRIZNAKH=2;
    return
end
%       STOP
%
%      Проверка интерферентрости зубьев 
%
%      ASD=AW*SIN(ALFATW)-0.5*SQRT(DA2**2-DB2**2)
%	ASF=Z1*SIN(ALFAT)/(2.*COS(BETTA))
%	ASG=(HA-X1)/SIN(ALFAT)
%      ASF=(ASF-ASG)*M
%	PRINT *,'ASD=',ASD,' ASF=',ASF
%      IF(ASD.GT.ASF) THEN
%	 WRITE(15,*) '  '
%	 WRITE(15,*) 'ВНИМАНИЕ!'
%	 WRITE(15,*) ' Интерференция головок зубьев колеса и переходных',
%     *' кривых у ножек зубьев шестерни'
%	 STOP
%	END IF
%      ASD=AW*SIN(ALFATW)
%	ASD=ASD-0.5*SQRT(DA1**2-DB1**2)
%	ASF=Z2*SIN(ALFAT)/(2*COS(BETTA))
%	ASG=(HA-X2)/SIN(ALFAT)
%      ASF=(ASF-ASG)*M
%     IF(ASD.GT.ASF) THEN
%	 WRITE(15,*) '  '
%	 WRITE(15,*) 'ВНИМАНИЕ!'
%	 WRITE(15,*) ' Интерференция головок зубьев шестерни и переходных',
%     *' кривых у ножек зубьев колеса'
%       STOP
%	END IF
%      Расчет номинальных размеров для определения взаимного положения разноименных профилей зубьев.
%
%      Постоянная хорда 
S1=(0.5*pi*(cos(ALFA))^2+X1*sin(2.*ALFA))*M;
if KZAC>0, S2=(0.5*pi*(cos(ALFA))^2+X2*sin(2.*ALFA))*M; end
if KZAC<0, S2=(0.5*pi*(cos(ALFA))^2-X2*sin(2.*ALFA))*M; end
%      Высота до постоянной хорды 
HC1=0.5*(DA1-D1-S1*tan(ALFA));
if KZAC>0, HC2=0.5*(DA2-D2-S2*tan(ALFA));
if KZAC<0, HC2=0.5*(-DA2+D2-S2*tan(ALFA));
fprintf (fid,'\nПостоянная хорда S, мм:');
fprintf (fid,'\nШестерни: %g  Колеса: %g',S1,S2);
fprintf (fid,'\nВысота до постоянной хорды H(C), мм:');
fprintf (fid,'\nШестерни: %g  Колеса: %g',HC1,HC2);
%      Длина общей нормали
PROM=tan(ALFAT)-ALFAT;
QA=Z1*cos(ALFAT)/(Z1+2*X1*cos(BETTA));
if QA<1
ALFAX=acos(QA); 
DG=180*ALFAX/pi;
QWE1=tan(ALFAX)/(cos(BETTAB))^2;
QWE2=2*X1*tan(ALFA)/Z1;
AIZN=0.5+Z1*(QWE1-QWE2-PROM)/pi;
IZN=AIZN+0.5; 
ZN1=IZN;
if QA>1 
ZN1=3; end
W1=(pi*(ZN1-0.5)+2.*X1*tan(ALFA)+Z1*PROM)*M*cos(ALFA);
QA=Z2*cos(ALFAT)/(Z2+2*X2*cos(BETTA));
if QA<1 ALFAX=cosd(QA); 
  DG=180.*ALFAX/pi;
  QWE1=tan(ALFAX)/(cos(BETTAB))^2; QWE2=2*X2*tan(ALFA)/Z2;
  AIZN=0.5+Z2*(QWE1-QWE2-PROM)/pi;
  IZN=AIZN+0.5; ZN2=IZN; 
end
if QA>1, ZN2=3;
W2=(pi*(ZN2-0.5)+2.*X1*tan(ALFA)+Z1*PROM)*M*cos(ALFA);
fprintf (fid,'\nДлина общей нормали W, мм:');
fprintf (fid,'\nШестерни: %g  Колеса: %g',W1,W2);
end
end
end 
end
end



