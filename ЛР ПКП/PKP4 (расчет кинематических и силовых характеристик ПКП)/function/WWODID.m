function [ TYT ] = WWODID
global MPR MYF MPT NPR NZV NYF NPT CPR A1 B1 DANNYE fid 
global KR0 KMUF0 KRJA Z KPDR RDISKA WDVIG RSAT
%
TYT=99;
for I1=1:3                       
    for J1=1:20                     
        MPR(I1,J1)=0;
	    CPR(J1)=0;
	    KPDR(J1)=0;
        MPT(I1,J1)=0;               
    end
end
for I1=1:2                       
    for J1=1:30                     
	    RDISKA(J1)=0;
	    RSAT(J1)=0;
        MYF(I1,J1)=0;                 
    end
end
%      NPR - Число планетарных рядов
NPR=xlsread(DANNYE,'A1:B1');            
%      NYF - Число элементов управления
NYF=xlsread(DANNYE,'A2:B2');            
%      NZV - Число звеньев
NZV=xlsread(DANNYE,'A3:B3');            
%      NPT - Число передач
NPT=xlsread(DANNYE,'A4:B4');             
fprintf (fid,'\n Количество планетарных рядов - %g',NPR);
fprintf (fid,'\n Количество элементов управления - %g',NYF);
fprintf (fid,'\n Количество звеньев ПКП - %g',NZV);
fprintf (fid,'\n Количество передач ПКП - %g',NPT);
%      MPR - Ввод кода планетарных рядов и
%      ПРОВЕКА НА НАЛИЧИЕ ВЕДУЩЕГО ЗВЕНА В СОСТАВЕ ПЛАНЕТАРНЫХ МЕХАНИЗМОВ
KR0=0;
KMUF0=0;
MPR=xlsread(DANNYE,'A5:C9');        % READ (9,1) (MPR(J,I),J=1,3)
for I1=1:NPR                              %     DO 4 J=1,3
    for J1=1:3
        if MPR(I1,J1)==1                          %   IF(MPR(I1,J1).EQ.1) KR0=1
            KR0=1; 
        end 
     end
end                             %   4  CONTINUE
%	 MYF - Вввод кода элементов управления
MYF1=xlsread(DANNYE,'A10:B17');        %    READ (9,1) (MYF(J,I),J=1,2)
for I1=1:NYF
   MYF(1,I1)=MYF1(I1,1);
   MYF(2,I1)=MYF1(I1,2);
end
for I1=1:NYF                              %	DO 15 I=1,NYF
   L1=MYF(1,I1);
   L2=MYF(2,I1);
   if L1 == 0                                  %	IF(L1.EQ.0) 
       MYF(1,I1)=L2;
   end
   if L1 == 0                                  %	IF(L1.EQ.0) 
      MYF(2,I1)=L1;
   end
   if MYF(2,I1) ~= 0                           %	IF(MYF(2,I).EQ.0) GO TO 15
       if L1 > L2                                  %	IF(L1.GT.L2) 
          MYF(1,I1)=L2;
          MYF(2,I1)=L1;
       end
    end
end                                       %  15  CONTINUE
%      MPT - Ввод кода включения элементов управления на передачах
MPT1=xlsread(DANNYE,'A18:C28');     % READ (9,1) (MPT(J,I),J=1,3)
%     ПРИ ОТСУТСТВИИ ВЕДУЩЕГО ЗВЕНА В СОСТАВЕ ПР ПРОВЕРКА НА ТО, 
%     ЧТОБЫ НА ВСЕХ ПЕРЕДАЧАХ ИСПОЛЬЗОВАЛАСЬ МУФТА С ВЕДУЩИМ ЗВЕНОМ
for I1=1:NPT
    MPT(1,I1)=MPT1(I1,1);
    MPT(2,I1)=MPT1(I1,2);
    MPT(3,I1)=MPT1(I1,3);
end
if KR0 == 0 
KMUF0=0;
for I1=1:NPT
    for J1=1:3                                %       DO 6 J=1,3
        L1=MPT(J1,I1);
        if L1 == 0, continue; end
        if MYF(1,L1)==1,   KMUF0=1;  end                       %	 IF(MYF(1,L1).EQ.1)        
    end                                         %   6   CONTINUE
    if KMUF0 == 0                              % 	IF(KMUF0.EQ.0) THEN
         fprintf (fid,'\n ПЕРЕДАЧА МОМЕНТА на %g передаче не возможна',I1);
         fprintf ('\n ПЕРЕДАЧА МОМЕНТА на %g передаче не возможна',I1);
    end                                       %	END IF 
end                                       %	END IF
end                                       %  20  CONTINUE
fprintf (fid,'\n Схема ПКП:');
for J1=1:NPR
    fprintf (fid,'\n ПР %g %g %g',MPR(J1,1),MPR(J1,2),MPR(J1,3));
end
fprintf (fid,'\n Схема элементов управления:');
for I1=1:NYF
    fprintf (fid,'\n %g) %g %g',I1,MYF(1,I1),MYF(2,I1));
end
fprintf (fid,'\n Схема включения элементов управления на передачах:');
for I1=1:NPT
    fprintf (fid,'\n %g) %g %g %g',I1,MPT(1,I1),MPT(2,I1),MPT(3,I1));
end
% Ввод чисeл зубьев шестерен: 
% Z(I,1) - число зубьев МЦК (Z(I,1)>0, если ПР первого класса и Z(I,1)<0, если ПР второго класса).
% Z(I,2) - число зубьев сателлита, сцепленного с МЦК.
% Z(I,3) - число зубьев сателлита, сцпеленного с БЦК (Z(I,3)>0, если ПР со сцепленными сателлитами
%          и Z(I,3)<0, если ПР с двухвенцовыми сателлитами).
% Z(I,4) - число зубьев БЦК.
Z=xlsread(DANNYE,'A29:D33');
fprintf (fid,'\n Число зубьев шестерен планетарных рядов:');
for I1=1:NPR
    fprintf (fid,'\n ПР%i: %g %g %g %g %g',I1,Z(I1,1),Z(I1,2),Z(I1,3),Z(I1,4));
end
for I1=1:NPR
    CPR(I1)=Z(I1,4)/Z(I1,1); 
    if Z(I1,3)<0 	                                                           % IF(Z(I,3).LT.0.) 
       CPR(I1)=Z(I1,4)*Z(I1,2)/(Z(I1,1)*abs(Z(I1,3)));
    end
end
fprintf (fid,'\n Конструктивные параметры планетарных рядов:');
for I1=1:NPR
fprintf (fid,'\n ПР%g: %g',I1,CPR(I1));
end
fprintf (fid,'\n      ');               %    WRITE (15,559)
%      KPDR - КПД планетарных рядов
KPDR=xlsread(DANNYE,'A34:E34');   %  READ (9,555) (KPDR(J),J=1,NPR)
fprintf (fid,'\n КПД планетарных рядов:');
for I1=1:NPR
fprintf (fid,'\n ПР%g: %g',I1,KPDR(I1));
end
fprintf (fid,'\n************************************************************');
fprintf (fid,'\n     ');
fprintf (fid,'\n          РЕЗУЛЬТАТЫ РАСЧЕТОВ');
WDVIG=3.14*WDVIG/30;
for I1=1:25                              %	DO 200 I=1,25
    B1(I1)=0;
for J1=1:25                              %	DO 200 J=1,25
    A1(I1,J1)=0;
end
end                                      % 200 CJNTINUE
KRJA=0;
for	III=1:NPR                            %     DO 210 I=1,NPR
    I1=MPR(III,1);
    I2=MPR(III,2);
    I3=MPR(III,3);
    A1(III,I1)=-1;
    A1(III,I2)=1-CPR(III);
    if A1(III,I2)==-1                          % 	IF(A1(I,I2).EQ.-1.) 
         A1(III,I2)=-1.001;
    end
    if	A1(III,I2) == 0                        % IF(A1(I,I2).EQ.0) THEN
        fprintf (fid,'\n Конструктивный параметр %i  ряда равен 1',III);	% PRINT *,'KONSTRUKTIVNY PAPAMETR ',I,' RJADA RAVEN 1'
        KRJA=1;                                  %	 STOP
    end                                      %	END IF
    A1(III,I3)=CPR(III);
end                                        %  210 CJNTINUE
end