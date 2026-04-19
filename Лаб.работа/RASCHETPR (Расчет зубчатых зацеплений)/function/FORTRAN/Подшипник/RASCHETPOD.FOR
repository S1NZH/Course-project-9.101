C
      SUBROUTINE RASCHETPOD
	BYTE FDSA(80)
	INTEGER TIP,Z,IR
      REAL LWE,MDVSMAX,NDVSMAX,NDVSSR,KNMCK,KNVOD,KR,KA,MST,MMCK,KMMCK
	COMMON /BL1/ TIP,DW,DPE,LWE,Z,IR,ALFA,FR,FA
	COMMON /BLV/ V
	COMMON /BLNAGR/ KR(15),KA(15),MST,RVOD
	COMMON /BL12/ IDVIJ
      COMMON /BL5/ MDVSMAX,NDVSMAX,ADVS,NDVSSR,VSR,KNMCK(15),KNVOD(15),
     *             KMMCK(15),SMAX,AST
      COMMON /BL3/ HPOVZUB1,HPOVZUB2,NPER,NTERMO1,NTERMO2
	COMMON /BLPOD1/ Z1,Z2,Z3,Z4
	COMMON /BLPOD2/ MMCK,BETTA
C
	WRITE (15,*) '   '
	WRITE (15,*) '     хяундмше дюммше'
	WRITE (15,*) '   '
	DO 500 IE=1,5
C      рхо ондьхомхйю
      READ  (14,1000) (FDSA(I),I=1,80)
  500 WRITE (15,1000) (FDSA(I),I=1,80)
      READ  (14,1003) TIP 
      WRITE (15,1003) TIP
C      дхюлерп рек йювемхъ
      READ (14,1000) (FDSA(I),I=1,80)
      WRITE (15,1000) (FDSA(I),I=1,80)
      READ  (14,1001) DW 
      WRITE (15,1001) DW
C      дхюлерп нйпсфмнярх жемрпнб рек йювемхъ
      READ (14,1000) (FDSA(I),I=1,80)
	WRITE (15,1000) (FDSA(I),I=1,80)
      READ  (14,1001) DPE
	WRITE (15,1001) DPE
C      дкхмю пнкхйю
      READ (14,1000) (FDSA(I),I=1,80)
	WRITE (15,1000) (FDSA(I),I=1,80)
      READ  (14,1001) LWE
	WRITE (15,1001) LWE
C      вхякн рек йювемхъ б ндмнл пъдс ондьхомхйю
      READ (14,1000) (FDSA(I),I=1,80)
	WRITE (15,1000) (FDSA(I),I=1,80)
      READ  (14,1003) Z
	WRITE (15,1003) Z
C	Z=3.14*DPE/DW
C	PRINT *,'Z=',Z
C      вхякн пъднб рек йювемхъ б ондьхомхйе
      READ (14,1000) (FDSA(I),I=1,80)
	WRITE (15,1000) (FDSA(I),I=1,80)
      READ  (14,1003) IR
	WRITE (15,1003) IR
C      мнлхмюкэмши сцнк йнмрюйрю ондьхомхйю
      READ (14,1000) (FDSA(I),I=1,80)
	WRITE (15,1000) (FDSA(I),I=1,80)
      READ  (14,1001) ALFA
	WRITE (15,1001) ALFA
C      опхгмюй, йюйне йнкэжн ондьхомхйю бпюыюеряъ
      READ (14,1000) (FDSA(I),I=1,80)
      WRITE (15,1000) (FDSA(I),I=1,80)
      READ (14,1000) (FDSA(I),I=1,80)
      READ (14,1000) (FDSA(I),I=1,80)
      READ  (14,1003) KK
	WRITE (15,1003) KK
	V=1.
	IF(KK.EQ.2) V=1.2
C      люяяю яюреккхрю
	READ (14,1000) (FDSA(I),I=1,80)
      WRITE (15,1000) (FDSA(I),I=1,80)
      READ  (14,1001) MST 
      WRITE (15,1002) MST 
C      пюдхся нях яюреккхрю
	READ (14,1000) (FDSA(I),I=1,80)
      WRITE (15,1000) (FDSA(I),I=1,80)
      READ  (14,1001) RVOD
      WRITE (15,1002) RVOD
C
	TMAX=SMAX/VSR
	DO 1 I=1,NPER
      KNMCK(I)=KNMCK(I)*NDVSSR
      KNVOD(I)=KNVOD(I)*NDVSSR
    1 KNMCK(I)=Z1*(KNMCK(I)-KNVOD(I))/Z2
C     PRINT *,'KNMCK=',(KNMCK(I),I=1,NPER)
      FR=0.
	FA=0.
      DO 2 I=1,NPER
	TMCK=MDVSMAX*KMMCK(I)/AST
	FOKR=2000.*TMCK*COS(BETTA)/(MMCK*Z1)
	FOKR=2.*ABS(FOKR)
      IF(FR.LT.FOKR) FR=FOKR
      KR(I)=ADVS*FOKR
    2 KA(I)=0.
C 	
C      пюявер ярюрхвеяйни цпсгнондзелмнярх
C
	WRITE(15,*)'****************************************************'
	WRITE(15,*)'     '
C
      CALL STATGRUS
C
	WRITE(15,*)'****************************************************'
	WRITE(15,*)'     '
C
C      пюявер мюцпсфеммнярх ондьхомхйю
C
      CALL NAGRUZKA(TMAX)
C
C      пюявер дхмюлхвеяйни цпсгнондзелмнярх
C
      CALL DINGRUS
C
      STOP
 1000 FORMAT(1X,80(A1))
 1001 FORMAT(12F10.5)
 1002 FORMAT(1X,12F10.3)
 1003 FORMAT(10I3)
 1004 FORMAT(1X,10(I2,2X))
 1005 FORMAT(F8.1)
 1006 FORMAT(1X,F8.1)
 1007 FORMAT(1X,10(F5.0,2X))
 1008 FORMAT(80(A1))
      END
C