function [NPIZNAK] = RASCHET(NP,NPRIZN)
%
global	MPR MYF MPT NPR NZV NYF CPR Z KPDR NMCK NBCK NWOD WZV 
global A1 A2 A3 TMCK TBCK TWOD KPD WSAT NSS TUPRM IPKP
%
NPIZNAK=0;
if NPRIZN ~= 0
    for I=1:20
        Z(I,1)=20; KPD(I)=0; IZV1(I)=0;
        for J=1:10
            NBV(J)=0; KODM(J)=0; TMCK(I,J)=0; TBCK(I,J)=0; TWOD(I,J)=0;
	        NMCK(I,J)=0; NBCK(I,J)=0; NWOD(I,J)=0; WSAT(I,J,1)=0;
            WSAT(I,J,2)=0; TUPRT(I,J)=0; TUPRM(I,J)=0; 
        end
    end
    NPRIZN=1;  
end
for J=1:NZV
    WZV(NP,J)=0; 
end
for IR=1:5
    for J=1:20
        LMUF(IR,J)=0;
    end
end
IPKP(NP)=0;
%
if NPIZNAK ~= 0, return; end
%        Расчет частот вращения звеньев 
for IT=1:NPR
	 IZV(IT)=0;
     IZV1(IT)=0;
     for JT=1:NZV
         A2(IT,JT)=0; 
         A3(IT,JT)=0;      
         A2(IT,JT)=A1(IT,JT);
     end
end
for IR=1:NZV
     IZV(IR)=IR;
end
NSS=NZV-NPR-1; 
NMUFT=0; KMUFT=0; KTOR=0; LMU=0;
% Определение прямой передачи
for IR=1:NSS                                                      %  DO 3 I=1,NSS
	 KE=MPT(IR,NP); 
	 L1=MYF(1,KE); 
	 L2=MYF(2,KE); 
     if L2 ~=0, LMU=LMU+1; end
end
if LMU == NSS
    for IO=1:NZV
        WZV(NP,IO)=1;
    end        
end
%
if LMU < NSS
for IR=1:NSS                                                      %  DO 3 I=1,NSS
	 KE=MPT(IR,NP); 
	 L1=MYF(1,KE); 
	 L2=MYF(2,KE); 
     if L2 ~= 0, continue; end
	 KTOR=KTOR+1;
	 KTORZ(KTOR)=L1;
%
%       ПРЕОБРАЗОВАНИЕ МАТРИЦЫ, ЕСЛИ ЭЛЕМЕНТ УПРАВЛЕНИЯ ЯВЛЯЕТСЯ ТОРМОЗОМ
%
     for J=1:NPR                                                        %  DO 5 I=1,NPR
         A2(J,L1)=0;
     end                                                                      %  5 CONTINUE
end                                                                      %  3 CONTINUE
%for IT=1:NPR
%end
%      АНАЛИЗ: ЕСТЬ ЛИ В СОСТАВЕ ВКЛЮЧЕННОЙ МУФТЫ ЗВЕНО, ТОРМОЗ КОТОРОГО ТАКЖЕ ВКЛЮЧЕН
%
ITORM=0; 
for IU=1:4                          %  DO 87 IU=1,4
for I=1:NSS                         %  DO 4 I=1,NSS
	 KE=MPT(I,NP);
	 L1=MYF(1,KE);
	 L2=MYF(2,KE);
if L2 == 0                             %	 IF(L2.EQ.0) GO TO 4
     continue
end
if ITORM ~= 0                      %       IF(ITORM.EQ.0) GO TO 85
    NPRIZ=0;
for J=1:ITORM                    %	 DO 86 J=1,ITORM
 if I == KTORM(J)                  %   IF(I.EQ.KTORM(J)) GO TO 4
  NPRIZ=1; 
  continue
end
end                              %    86  continue
if NPRIZ == 1
    continue
end
end                               
for J=1:KTOR                     %     85   DO 80 J=1,KTOR
if L1==KTORZ(J)                  %	 IF(L1.NE.KTORZ(J)) GO TO 81
	 LL=L2;
	 KTOR= KTOR+1;
	 KTORZ(KTOR)=L2;
end
if L1~=KTORZ(J)                   % 	 GO TO 83
if L2~=KTORZ(J)                   %   81   IF(L2.NE.KTORZ(J)) GO TO 80
	 continue
end
     LL=L1;
	 KTOR= KTOR+1;
	 KTORZ(KTOR)=L1;
end
for JJ=1:NPR                             %   83   DO 84 JJ=1,NPR
     A2(JJ,LL)=0;
end
     ITORM=ITORM+1;
	 KTORM(ITORM)=I;
end                                         %  80   CONTINUE
end                                         %    4   CONTINUE
end                                         %   87   CONTINUE
%
%      ПРЕОБРАЗОВАНИЕ МАТРИЦЫ, ЕСЛИ ЭЛЕМЕНТ УПРАВЛЕНИЯ ЯВЛЯЕТСЯ МУФТОЙ И АНАЛИЗ: ЕСТЬ ЛИ ВО ВКЛЮЧЕННЫХ МУФТАХ ОБЩИЕ ЗВЕНЬЯ
%
NM=0;                                       % 220 NM=0
LMUFT=0;
LMUFT1=0;
for I=1:NSS                                  %  DO 6 I=1,NSS
	 KE=MPT(I,NP);
	 L1=MYF(1,KE);
	 L2=MYF(2,KE); 
if L2==0                                   %	 IF(L2.EQ.0) GO TO 6
    continue
end
NPRIZ=0;
for J=1:ITORM                               %	 DO 7 J=1,ITORM
if I==KTORM(J)                           %     IF(I.EQ.KTORM(J)) GO TO 6
    NPRIZ=1;
    continue 
end
end                                         %   7   CONTINUE  
if NPRIZ==1
    continue
end
if NM==0                                    %       IF(NM.NE.0) GO TO 8      
	 NM=1;
	 LL1=L1;
for J1=1:NPR                                %       DO 9 J1=1,NPR
    A2(J1,L1)=A2(J1,L1)+A2(J1,L2);
end
for J1=1:NPR                                %       DO 10 J1=1,NPR
      A2(J1,L2)=0;
end
	  LMUF(NM,1)=L1;
 	  LMUF(NM,2)=L2;
 	  LMUFT=2;	 
   continue                                       %	  GO TO 6
end
NPRIZ=0;
for J=1:NM                                   %    8   DO 129 J=1,NM
for J1=1:LMUFT                              %        DO 15 J1=1,LMUFT
if L1==LMUF(J,J1)	                        %  IF(L1.NE.LMUF(J,J1)) GO TO 14
      L1=LMUF(J,1);
      LMUFT=LMUFT+1;
	  LMUF(J,LMUFT)=L2;
      NPRIZ=1;
	  break                                  % GO TO 16
end                                          %   14   CONTINUE
if L2==LMUF(J,J1)                            %   IF(L2.NE.LMUF(J,J1)) GO TO 15 
      LMUFT=LMUFT+1;
	  LMUF(J,LMUFT)=L1;
	  L2=L1;
	  L1=LMUF(J,1);	  
      NPRIZ=1;
	  break                                 %	  GO TO 16
end
end                                       %  15   CONTINUE
if NPRIZ==1
   break
end
end                                       %  129   CONTINUE
if NPRIZ==0
       NM=NM+1;
       LMUFT1=LMUFT1+1;
	   LMUF(NM,LMUFT1)=L1;
       LMUFT1=LMUFT1+1;
	   LMUF(NM,LMUFT1)=L2;
end
for J1=1:NPR                                     %   16  DO 170 J1=1,NPR
       A2(J1,L1)=A2(J1,L1)+A2(J1,L2);
end
for J1=1:NPR                                     %       DO 18 J1=1,NPR
       A2(J1,L2)=0;
end
end                                                    %6  CONTINUE
NPRIZ=0;
for IR=1:NM                                       %      DO 88 I=1,NM
for J=1:20                                       %      DO 89 J=1,20
if LMUF(IR,J)~=1                            %  IF(LMUF(I,J).NE.1) GO TO 89
     continue
end
    L1=LMUF(IR,1);
if L1==1                                   %	IF(L1.EQ.1) GO TO 90
    NPRIZ=1;
    break
end
for J1=1:NPR                               %	DO 91 J1=1,NPR
    A2(J1,1)=A2(J1,L1);
end
for J1=1:NPR                               %       DO 92 J1=1,NPR
    A2(J1,L1)=0;
end
	NPRIZ=1;
    break
end                                             %   89 CONTINUE
if NPRIZ==1
    break
end
end                                             %   88 CONTINUE                                               
     I10=1;                                       %   90 CONTINUE
	 NZV2=NZV;
for IR=1:NZV                                    %   DO 21 I=1,NZV
    NPRIZ=0;
for J=1:NPR                                     %	DO 22 J=1,NPR
if A2(J,IR)~=0                          %	IF(A2(J,I).NE.0) GO TO 23
    NPRIZ=1;
    continue
end
end                                             %   22 CONTINUE
if NPRIZ==0
      NZV2=NZV2-1;
      IZV(IR)=0;
      continue
end                                            %      GO TO 21
      I1=IR;                                     %      23 I1=I
for J1=1:NPR                                    %      DO 24 J1=1,NPR
      A3(J1,I10)=A2(J1,I1);
end
	  I10=I10+1;	
end                                             %   21 CONTINUE
      I1=0;
for IR=1:NZV                                     %      DO 26 I=1,NZV
    if IZV(IR) == 0, continue; end                                %	IF(IZV(I).EQ.0) GO TO 26
	I1=I1+1;
    IZV1(I1)=IZV(IR);
end                                             %   26 CONTINUE
for IR=1:NPR                                     %	DO 25 I=1,NPR
	PM(IR)=-A3(IR,1);
    for J=1:NZV-1                                   %	DO 25 J=1,NZV-1
        A3(IR,J)=A3(IR,J+1);
    end
end
for IR=1:NPR                                   %      DO 27 I=1,NPR+1
      IZV1(IR)=IZV1(IR+1);
end                                              %   continue
      NZV2=NZV2-1;
for LKJ=1:NPR
    PMW(LKJ,1)=PM(LKJ);
    for JKL=1:NPR
        A3W(LKJ,JKL)=A3(LKJ,JKL);   
    end
end
%for LLLL=1:NPR
%    fprintf('\n A= %g  %g  %g',A3W(LLLL,1),A3W(LLLL,2),A3W(LLLL,3));
%end
% fprintf('\n P= %g  %g  %g',PMW(1,1),PMW(2,1),PMW(3,1));
% Расчет угловых скоростей звеньев
%
WZVG=A3W\PMW;                                %      CALL GELG (PM,B1,NPR,1,0.0001,IER)
%
for IR=1:NPR
WZW(IR)=WZVG(IR);
end
% fprintf('\n W= %g  %g  %g',WZV(1),WZV(2),WZV(3));
WZV(NP,1)=1;
for I1=1:NPR                                     %	DO 29 I=1,NPR
    	I11=IZV1(I1);
        if I11 ~= 0, WZV(NP,I11)=WZW(I1); end
end
for I1=1:NSS                                     %      DO 13 I=1,NSS
	 KE=MPT(I1,NP);
if KE~=0                                      %	 IF (KE.EQ.0) GO TO 13
	 L1=MYF(1,KE);
	 L2=MYF(2,KE);
end
if L2~=0                                      %	 IF(L2.EQ.0) GO TO 13
	 WZV(NP,L2)=WZV(NP,L1);
                                              %   13 CONTINUE
end
end
if LMUFT~=0                                   %      IF(LMUFT.NE.0) THEN
for JI=1:NM                                   %      DO 154 JI=1,NM
	NN=0;
for I1=1:LMUFT                                %	DO 112 I=1,LMUFT
if LMUF(JI,I1)==1 
    NN=1;                                     %   IF(LMUF(JI,I1).EQ.1), NN=1
    KK=I1;
end
end                                           %  112 CONTINUE
if (NN==1)&&(KK~=1)                           %   IF((NN.EQ.1).AND.(KK.NE.1)) THEN
for I1=1:LMUFT-1                              % 	DO 113 I=1,LMUFT-1
	J1=LMUFT-I1+1;
	LMUF(JI,J1)=LMUF(JI,J1-1);
end                                           %  113 CONTINUE
      LMUF(JI,1)=1;
end                                           %	END IF
for I1=1:LMUFT                                %	DO 111 I=2,LMUFT 
	L1=LMUF(JI,1);
if LMUF(JI,I1)~=0	                          %  IF(LMUF(JI,I1).NE.0) L2=LMUF(JI,I1)
    L2=LMUF(JI,I1);
end
 WZV(NP,L2)=WZV(NP,L1); %  111   
end                                           %          154 CONTINUE
end
end                                           %      END IF
end
%
%      Расчет передаточного отношения передачи
%
%fprintf('\n NP =%i WZV(NP,1)= %g  WZV(NP,NZV)= %g',NP,WZV(NP,1),WZV(NP,NZV));

	IPKP(NP)=WZV(NP,1)/WZV(NP,NZV);
%
%      Расчет моментов
%
for I1=1:25                                   %      DO 31 I=1,25
for J1=1:25                                   %      DO 31 J=1,25
	A2(I1,J1)=0;
    A3(I1,J1)=0;
end
end
for I1=1:NZV                                  %      DO 30 I=1,NZV
for J1=1:NPR                                  %      DO 30 J=1,NPR
     A2(I1,J1)=A1(J1,I1);
end
end
NT=1;
NM=1;
for I1=1:NSS                                  %     DO 32 I=1,NSS
KE=MPT(I1,NP);
if KE==0                                      %	 IF (KE.EQ.0) GO TO 33
    break
end
	 L1=MYF(1,KE);
	 L2=MYF(2,KE);
     A2(L1,NPR+I1)=1;
	 IEU(I1)=KE;
if L2~=0                                      %	IF(L2.NE.0) A2(L2,NPR+I)=-1.
     A2(L2,NPR+I1)=-1;
end
end                                           %   32 CONTINUE
                                              %   33 CONTINUE                 
A2(NZV,NZV)=1;
for I1=1:NZV                                  %       DO 34 I=1,100
    PMM(I1,1)=0;                              %    34 PM(I1)=0
end
PMM(1,1)=-1;
for I1=1:NZV                                  %       DO 35 I=1,NZV
for J1=1:NZV                                  %       DO 35 J=1,NZV
    A3M(J1,I1)=A2(J1,I1);
end
end
%
% Расчет моментов, действующих на звенья ПР и ФЭУ
%
MZV=A3M\PMM;                                  %      CALL GELG (PM,B1,NZV,1,0.0001,IER)
%
for I1=1:NZV                                  %      DO 38 I=1,NZV
if abs(MZV(I1))<0.0001
    MZV(I1)=0;
end
end                                           %     38 continue
for I1=1:NPR                                  %	DO 36 I=1,NPR
	TMCK(NP,I1)=-MZV(I1);
	TBCK(NP,I1)=MZV(I1)*CPR(I1);
    TWOD(NP,I1)=(MZV(I1)*(1-CPR(I1)));
end                                           %  36 continue
for I1=1:NYF
    TUPRM(I1,NP)=0;
end
for I1=1:NSS                                  %      DO 37 I=1,NSS     
	 KE=IEU(I1);
if KE~=0                                      %	 IF (KE.EQ.0) GO TO 37
     TUPRM(KE,NP)=MZV(NPR+I1);
end
end
                                              %  37 CONTINUE
%
%      Расчет КПД передач
%
for I1=1:NZV                                  %	DO 40 I=1,NZV
for J1=1:NPR                                  % DO 40 J=1,NPR
if A2(I1,J1)==0                               % IF(A2(I1,J1).EQ.0.) GO TO 40
    continue
end
if A2(I1,J1)==-1                              % IF(A2(I1,J1).EQ.(-1.)) GO TO 40
    continue
end
      I11=MPR(J1,1);
      I21=MPR(J1,2);
      WM=MZV(J1)*(WZV(NP,I11)-WZV(NP,I21));
	  KP=+1;
if WM<0                                       % IF(WM.LT.0) KP=-1
    KP=-1;
end
if abs(A2(I1,J1))==abs(CPR(J1))               %IF(ABS(A2(I1,J1)).NE.ABS(CPR(J1))) GO TO 41
       A2(I1,J1)=A2(I1,J1)*KPDR(J1)^KP;
       continue
end                                           %  GO TO 40                                         
       A2(I1,J1)=(1-CPR(J1)*KPDR(J1)^KP);     % 41 A2(I1,J1)=(1-CPR(J1)*KPDR(J1)^KP
end
end                                           % 40  CONTINUE                                
for I1=1:NZV                                  %      DO 42 I=1,NZV
    PMKPD(I1,1)=0;
end
PMKPD(1,1)=-1; 
for I1=1:NZV                                  %    DO 43 I=1,NZV
for J1=1:NZV                                  %	DO 43 J=1,NZV
    AKPD(J1,I1)=A2(J1,I1);
end
end
%
%       Расчет КПД
%
KPDZ=AKPD\PMKPD;                              %      CALL GELG (PM,B1,NZV,1,0.0001,IER)
%
for I1=1:NZV                                  %      DO 39 I=1,NZV
if abs(KPDZ(I1))<0.0001                       %      IF(ABS(PM(I)).LT.0.0001) PM(I)=0.
    KPDZ(I1)=0;
end
end
KPD(NP)=KPDZ(NZV)*WZV(NP,NZV);
KPD(NP)=abs(KPD(NP));
if KPD(NP)<0.01                               %	IF(KPD(NP).LE.0.01) IPKP(NP)=0.
     IPKP(NP)=0;
end
%
%     Расчет относительных угловых скоростей сателлитов
%
for J1=1:NPR                                  %      DO 50 J=1,NPR
	Z(J1,4)=Z(J1,1)*abs(CPR(J1));
    I1=MPR(J1,1); 
    I2=MPR(J1,2);  
    WSAT(NP,J1,1)=0;
if WZV(NP,I1)~=WZV(NP,I2)                     % 	IF(WZV(NP,I1).NE.WZV(NP,I2)) THEN
   WSAT(NP,J1,1)=(-2/(abs(Z(J1,4)/Z(J1,1))-1))*(WZV(NP,I1)-WZV(NP,I2));
if Z(J1,3)==0                                 % IF(Z(J1,3).EQ.0) 
   WSAT(NP,J1,1)=(-2/(abs(Z(J1,4)/Z(J1,1))-1))*(WZV(NP,I1)-WZV(NP,I2));
end
if Z(J1,3)>0                                  %      IF(Z(J1,3).GT.0) THEN
     WSAT(NP,J1,1)=(Z(J1,1)/Z(J1,2))*(WZV(NP,I1)-WZV(NP,I2));
	 WSAT(NP,J1,2)=-WSAT(NP,J1,1)*Z(J1,2)/Z(J1,3);
end                                           %	END IF
if Z(J1,3)<0                                  %   IF(Z(J1,3).LT.0) WSAT(NP,J1,2)=WSAT(NP,J1,1)
     WSAT(NP,J1,2)=WSAT(NP,J1,1);
end
end                                           %	END IF
end                                           %   50 CONTINUE
%
%     Расчет мощности на звеньях ПКП
%
for I1=1:NPR                                  %      DO 60 I=1,NPR
    I11=MPR(I1,1);
    I21=MPR(I1,2);
	I31=MPR(I1,3);
	NMCK(NP,I1)=TMCK(NP,I1)*WZV(NP,I11);
    NWOD(NP,I1)=TWOD(NP,I1)*WZV(NP,I21);
    NBCK(NP,I1)=TBCK(NP,I1)*WZV(NP,I31);
end                                           %   60 CONTINUE
%
%     Расчет скорости скольжения в элементах управления
%
for I1=1:NYF                                  %      DO 70 I=1,NYF
	I11=MYF(1,I1);
	I21=MYF(2,I1);
	W1=WZV(NP,I11);
	W2=0;
if I21~=0                                     %	IF(I21.NE.0) 
    W2=WZV(NP,I21);
end
end                                           %   70 CONTINUE
end





