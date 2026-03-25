C
C      ондопнцпюллю пюяверю дхмюлхвеяйни цпсгнондзелмнярх
C
      SUBROUTINE DINGRUS
	INTEGER TIP,Z
      REAL LWE,L10,KB,KT,LT,LS
	REAL KNMCK,KNVOD,KR,KA,MST,KMMCK,MDVSMAX,NDVSMAX,NDVSSR
	COMMON /BL1/ TIP,DW,DPE,LWE,Z,IR,ALFA,FR,FA
	COMMON /BLV/ V
	COMMON /BLLT/ LT
	COMMON /BLNAGR/ KR(15),KA(15),MST,RVOD
	COMMON /BL8POD/ DOLJA(15)
      COMMON /BL5/ MDVSMAX,NDVSMAX,ADVS,NDVSSR,VSR,KNMCK(15),KNVOD(15),
     *             KMMCK(15),SMAX,AST
      COMMON /BL3/ HPOVZUB1,HPOVZUB2,NPER,NTERMO1,NTERMO2

C
	DATA BM,KB,KT,A23 /1.3,1.4,1.,0.8/
C
	WRITE(15,*) '****************************************************'
      WRITE(15,*) '   '
	WRITE(15,*) 'пюявер дхмюлхвеяйни цпсгнондзелмнярх:'
      WRITE(15,*) '      '
	WRITE(15,*) '   '
	ALFAR=3.14*ALFA/180.
	IF(ALFA.NE.90.) A=DW*COS(ALFAR)/DPE
	IF(ALFA.EQ.90.) A=DW/DPE
C
C      пюявер ьюпхйнбнцн пюдхюкэмнцн х пюдхюкэмн-сонпмнцн ондьхомхйю
C
      IF(TIP.EQ.1) THEN
C
C      аюгнбюъ дхмюлхвеяйюъ пюдхюкэмюъ пюявермюъ цпсгнондзEлмнярэ
C
       CALL F02(FC,A)
C
       WRITE(15,109) FC
	 WRITE(15,111) BM
       A1=Z**(2./3.)
	 A3=(IR*COS(ALFAR))**0.7
	 IF(DW.LE.25.4) THEN
	  A2=DW**1.8	  
        CR=BM*FC*A1*A2*A3
	 END IF
	 IF(DW.GT.25.4) THEN
	  A2=DW**1.4
        CR=3.647*BM*FC*A1*A2*A3
	 END IF  
       WRITE(15,102) CR
	 WRITE(15,*)'    '
C      дхмюлхвеяйюъ щйбхбюкемрмюъ пюдхюкэмюъ мюцпсгйю
C
       CALL XY2(X0,Y0)
C
       WRITE(15,107) X0
       WRITE(15,108) Y0
	 WRITE(15,112) KB
	 WRITE(15,113) KT
	 WRITE(15,114) V 
       PR=(X0*V*FR+Y0*FA)*KB*KT
	 WRITE(15,104) PR
C      аюгнбши пюявермши пеяспя, [лхккхнм нанпнрнб]
       WRITE(15,115) A23
       L10=A23*(CR/PR)**3.
	 LS=SMAX*L10/LT
       WRITE(15,105) L10
       WRITE(15,106) LT
	 WRITE(15,110) LS
	END IF   
C
C      пюявер ьюпхйнбнцн сонпмнцн х сонпмнцн-пюдхюкэмнцн ондьхомхйю
C
      IF(TIP.EQ.2) THEN
C
C      аюгнбюъ дхмюлхвеяйюъ няебюъ пюявермюъ цпсгнондзEлмнярэ
C
       CALL F03(FC,A)
C
       WRITE(15,109) FC
	 WRITE(15,111) BM
	 IF(DW.LE.25.4) THEN
	 COSI=COS(ALFAR)
	 TANG=TAN(ALFAR)
        IF(ALFA.EQ.90.) THEN
	   A1=Z**(2./3.)
	   A2=DW**1.8
	   CR=BM*FC*A1*A2
	  END IF
	  IF(ALFA.NE.90.) THEN
	   A1=COSI**0.7
	   A2=Z**(2./3.)
	   A3=DW**1.8
	   CR=BM*FC*A1*TANG*A2*A3
	  END IF
       END IF
	 IF(DW.GT.25.4) THEN
        IF(ALFA.EQ.90.) THEN
	   A2=Z**(2./3.)
	   A3=DW**1.4	  
	   CR=3.647*BM*FC*A2*A3
	  END IF
        IF(ALFA.NE.90.) THEN
	   A1=COSI**0.7
	   A2=Z**(2./3.)
         A3=DW**1.4
         CR=3.647*BM*FC*A1*TANG*A2*A3
	  END IF
	 END IF
       WRITE(15,102) CR
	 WRITE(15,*)'    '
C      дхмюлхвеяйюъ щйбхбюкемрмюъ няебюъ мюцпсгйю
C
       CALL XY3(X0,Y0)
C
       WRITE(15,107) X0
       WRITE(15,108) Y0
	 WRITE(15,112) KB
	 WRITE(15,113) KT
       PR=(X0*FR+Y0*FA)*KB*KT
	 WRITE(15,103) PR
C      аюгнбши пюявермши пеяспя, [лхккхнм нанпнрнб]
       WRITE(15,115) A23
       L10=A23*(CR/PR)**3.
	 LS=SMAX*L10/LT
       WRITE(15,105) L10
       WRITE(15,106) LT
	 WRITE(15,110) LS
	END IF
C
C      пюявер пнкхйнбнцн пюдхюкэмнцн хкх пюдхюкэмн-сонпмнцн ондьхомхйю
C
      IF(TIP.EQ.3) THEN
C
C      аюгнбюъ дхмюлхвеяйюъ пюдхюкэмюъ пюявермюъ цпсгнондзEлмнярэ
C
       CALL F04(FC,A)
C
       WRITE(15,109) FC
       BM3=1.1
	 WRITE(15,111) BM3
       A1=(IR*LWE*COS(ALFAR))**(7./9.)
	 A2=Z**(3./4.)
	 A3=DW**(29./27.)
       CR=BM3*FC*A1*A2*A3
       WRITE(15,102) CR
	 WRITE(15,*)'    '
C      дхмюлхвеяйюъ щйбхбюкемрмюъ пюдхюкэмюъ мюцпсгйю
C
       PR=FR 
       IF(ALFA.NE.0.) THEN
        CALL XY4(X0,Y0)
C
        WRITE(15,107) X0
        WRITE(15,108) Y0
	  WRITE(15,112) KB
	  WRITE(15,113) KT
	  WRITE(15,114) V
        PR=(X0*V*FR+Y0*FA)*KB*KT
       END IF
	 WRITE(15,104) PR
C      аюгнбши пюявермши пеяспя, [лхккхнм нанпнрнб]
       L10=A23*(CR/PR)**(10./3.)
	 LS=SMAX*L10/LT
       WRITE(15,*) '  '
       WRITE(15,115) A23
       WRITE(15,105) L10
       WRITE(15,106) LT
	 WRITE(15,110) LS
	END IF
C
C      пюявер пнкхйнбнцн сонпмнцн х сонпмн-пюдхюкэмнцн ондьхомхйю
C
      IF(TIP.EQ.4) THEN
C
C      аюгнбюъ дхмюлхвеяйюъ няебюъ пюявермюъ цпсгнондзEлмнярэ
C
       CALL F05(FC,A)
C
       WRITE(15,109) FC
       BM3=1. 
	 WRITE(15,111) BM3
	 IF(ALFA.NE.90.) THEN
        A1=(LWE*COS(ALFAR))**(7./9.)
	  A2=Z**(3./4.)
	  A3=DW**(29./27.)
        CR=BM3*FC*A1*TAN(ALFAR)*A2*A3
	 END IF
	 IF(ALFA.EQ.90.) THEN
        A1=LWE**(7./9.)
        A2=Z**(3./4.)
        A3=DW**(29./27.)
        CR=BM3*FC*A1*A2*A3
	 END IF
       WRITE(15,102) CR
	 WRITE(15,*)'    '
C      дхмюлхвеяйюъ щйбхбюкемрмюъ няебюъ мюцпсгйю
C
       CALL XY5(X0,Y0)
C
       WRITE(15,107) X0
       WRITE(15,108) Y0
	 WRITE(15,112) KB
	 WRITE(15,113) KT
       PR=(X0*FR+Y0*FA)*KB*KT
	 WRITE(15,103) PR
C      аюгнбши пюявермши пеяспя, [лхккхнм нанпнрнб]
       WRITE(15,115) A23
       L10=A23*(CR/PR)**(10./3.)
	 LS=SMAX*L10/LT
       WRITE(15,105) L10
       WRITE(15,106) LT
	 WRITE(15,110) LS
	END IF
C
      RETURN
  100 FORMAT(1X,'Cor=',F15.3,2X,'Por=',F15.3)
  101 FORMAT(1X,'Coa=',F15.3,2X,'Poa=',F15.3)
  102	FORMAT(1X,'аюгнбюъ дхмюлхвеяйюъ пюдхюкэмюъ пюявермюъ ',
     *          'цпсгнондзEлмнярэ C(r)=:',F12.1,' H')
  103 FORMAT(1X'дхмюлхвеяйюъ щйбхбюкемрмюъ няебюъ мюцпсгйю P(Ю)=',F12.1,
     *' H')
  104 FORMAT(1X,'дхмюлхвеяйюъ щйбхбюкемрмюъ пюдхюкэмюъ мюцпсгйю P(r)=',
     *       F12.1,' H')
  105 FORMAT(1X,'аюгнбши пюявермши пеяспя, [лхк.нанпнрнб] L(10)=:',
     *       F7.1)
  106 FORMAT(1X,'рпеаселши пеяспя, [лхк.нанпнрнб]         L(T)=: ',
     *       F7.1)
  107 FORMAT(1X,'йнщттхжхемр дхмюлхвеяйни пюдхюкэмни мюцпсгйх X=',F7.2)
  108 FORMAT(1X,'йнщттхжхемр дхмюлхвеяйни няебни мюцпсгйх     Y=',F7.2)
  109 FORMAT(1X,'йнщт., гюбхяъыхи нр ценлерпхх, рнвмнярх х люрепхюкю ',
     *       'ондьхомхйю F(c):',F7.2)
  110 FORMAT(1X,'пюявермши пеяспя ондьхомхйнб б йхкнлерпюу опнаецю ',
     *       'L(s)=',F12.2,' ЙЛ')
  111 FORMAT(1X,'йнщттхжхемр, уюпюйрепхгсчыхи ябниярбю ярюкх я свернл ',
     *       'яонянаю ее хгцнрнбкемхъ B(m): ',F4.2)
  112 FORMAT(1X,'дхмюлхвеяйхи йнщттхжхемр K(а): ',F4.2)
  113 FORMAT(1X,'релоепюрспмши йнщттхжхемр й(р): ',F4.2)
  114 FORMAT(1X,'йнщттхжхемр V: ',F4.2)
  115 FORMAT(1X,'йнщттхжхемр A(23): ',F4.2)
  	END
C