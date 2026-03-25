C
      SUBROUTINE NAGRUZKA(TMAX)
	INTEGER TIP,Z,IR
      REAL LWE,MDVSMAX,NDVSMAX,NDVSSR,KNMCK,KNVOD,KR,KA,NCR,MST,LT
	REAL OBOR(20),FCB(20),AYP(20),KMMCK
	COMMON /BL1/ TIP,DW,DPE,LWE,Z,IR,ALFA,FR,FA
	COMMON /BLNAGR/ KR(15),KA(15),MST,RVOD
      COMMON /BL8/ DOLJA(15)
	COMMON /BLLT/ LT
      COMMON /BL5/ MDVSMAX,NDVSMAX,ADVS,NDVSSR,VSR,KNMCK(15),KNVOD(15),
     *             KMMCK(15),SMAX,AST
      COMMON /BL3/ HPOVZUB1,HPOVZUB2,NPER,NTERMO1,NTERMO2

C
      IF(NPER.EQ.1) THEN
	 FR=KR(1)
	 FA=KA(1)
	 RETURN
	END IF
C      
      CALL DANNYEPOD
C
	WRITE(15,*)'пюяопедекемхе бпелемх пюанрш ондьхомхйю он оепедювюл:'
	WRITE(15,116) (DOLJA(I),I=1,NPER)
	NCR=0
	LT=0
      DO 1 I=1,NPER
      LT=LT+60.*DOLJA(I)*TMAX*ABS(KNMCK(I))/1000000.
	OBOR(I)=60.*DOLJA(I)*TMAX*ABS(KNMCK(I))
    1 NCR=NCR+OBOR(I)
      FR=0
	FA=0
	DO 2 I=1,NPER
	WVOD=3.14*KNVOD(I)/30.
	FCB(I)=MST*RVOD*WVOD**2
      AY=SQRT(KR(I)**2+FCB(I)**2)
	AYP(I)=AY
      AY=AY**(10./3.)
      FR=FR+AY*OBOR(I)/NCR
      AY=KA(I)**(10./3.)
    2 FA=FA+AY*OBOR(I)/NCR
      FR=FR**0.3
	FA=FA**0.3
C
	WRITE(15,103) (FCB(I),I=1,NPER)
	WRITE(15,104) (AYP(I),I=1,NPER)
      WRITE(15,102) NCR
      WRITE(15,100) FR
      WRITE(15,101) FA
	RETURN
  100 FORMAT(1X,'япедмъъ пюдхюкэмюъ яхкю F(r)=',F12.2)
  101 FORMAT(1X,'япедмъъ няебюъ яхкю     F(a)=',F12.2)
  102 FORMAT(1X,'Cсллюпмне вхякн нанпнрнб ондьхомхйю N= ',F15.1)
  103 FORMAT(1X,'жемрпнаефмюъ яхкю он оепедювюл, H:',/
     *       1X,10(F7.2,2X))
  104 FORMAT(1X,'ясллюпмюъ пюдхюкэмюъ яхкю он оепедювюл, H:',/
     *       1X,10(F7.2,2X))
  116 FORMAT(1X,10(F5.3,2X))
	END