C
C      ондопнцпюллю пюяверю ярюрхвеяйни цпсгнондзелмнярх
C
      SUBROUTINE STATGRUS
	INTEGER TIP,Z
      REAL LWE
	COMMON /BL1/ TIP,DW,DPE,LWE,Z,IR,ALFA,FR,FA
C
      WRITE(15,*) 'пюявер ярюрхвеяйни цпсгнондзелмнярх:'
	WRITE(15,*) '         '
	ALFAR=3.14*ALFA/180.
	A=DW*COS(ALFAR)/DPE
C
C      пюявер ьюпхйнбнцн пюдхюкэмнцн хкх пюдхюкэмн-сонпмнцн ондьхомхйю
C
      IF(TIP.EQ.1) THEN
C      аюгнбюъ ярюрхвеяйюъ пюдхюкэмюъ цпсгнондзEлмнярэ
C
       CALL F01(F0,A)
C
       WRITE(15,109) F0
       COR=F0*IR*Z*(DW**2)*COS(ALFAR)
C      ярюрхвеяйюъ щйбхбюкемрмюъ пюдхюкэмюъ мюцпсгйю
C
      CALL XY1(ALFA,IR,X0,Y0)
C
      WRITE(15,107) X0
      WRITE(15,108) Y0
      POR=X0*FR+Y0*FA
	IF(POR.LT.FR) POR=FR
      IF(POR.GT.COR) THEN
	 PRINT *,'PODSHIPNIK NE PROHODIT PO STATISHECKOY GP'
	 WRITE (15,*) 
     *  'ондьхомхй ме опнундхр он ярюрхвеяйни цпсгнондзелмнярх'
	 WRITE (15,100) COR,POR
	 STOP
	END IF
	WRITE (15,100) COR,POR 
      RETURN
	END IF
C
C      пюявер ьюпхйнбнцн пюдхюкэмн-сонпмнцн хкх пюдхюкэмнцн ондьхомхйю
C
      IF(TIP.EQ.2) THEN
C      аюгнбюъ ярюрхвеяйюъ няебюъ цпсгнондзлEмнярэ
C
       CALL F01(F0,A)
C
      WRITE(15,109) F0
       COA=F0*Z*(DW**2)*SIN(ALFAR)
C      ярюрхвеяйюъ щйбхбюкемрмюъ няебюъ мюцпсгйю
       POA=FA
	 IF(ALFA.NE.90.) POA=2.3*FR*TAN(ALFAR)+FA
       IF(POA.GT.COA) THEN
	 PRINT *,'PODSHIPNIK NE PROHODIT PO STATISHECKOY GP'
	 WRITE (15,*) 
     *  'ондьхомхй ме опнундхр он ярюрхвеяйни цпсгнондзелмнярх'
	 WRITE (15,101) COA,POA
	 STOP
	END IF
	WRITE (15,101) COA,POA
      RETURN
	END IF
C
C      пюявер пнкхйнбнцн пюдхюкэмнцн хкх пюдхюкэмн-сонпмнцн ондьхомхйю
C
      IF(TIP.EQ.3) THEN
C      аюгнбюъ ярюрхвеяйюъ пюдхюкэмюъ цпсгнондзEлмнярэ
       COR=44.*(1-A)*IR*Z*LWE*DW*COS(ALFAR)
C      ярюрхвеяйюъ щйбхбюкемрмюъ пюдхюкэмюъ мюцпсгйю
      POR=FR
      IF(ALFA.NE.0) THEN
       IF(IR.EQ.1) X0=0.5
       IF(IR.EQ.2) X0=1.0
       IF(IR.EQ.1) Y0=0.22/TAN(ALFAR)
       IF(IR.EQ.2) Y0=0.44/TAN(ALFAR)
      WRITE(15,107) X0
      WRITE(15,108) Y0
       POR=X0*FR+Y0*FA
	 IF(POR.LT.FR) POR=FR
       IF(POR.GT.COR) THEN
	  PRINT *,'PODSHIPNIK NE PROHODIT PO STATISHECKOY GP'
	  WRITE (15,*) 
     *  'ондьхомхй ме опнундхр он ярюрхвеяйни цпсгнондзелмнярх'
	  WRITE (15,100) COR,POR
	  STOP
	 END IF
      END IF
	WRITE (15,100) COR,POR
      RETURN
	END IF
C
C      пюявер пнкхйнбнцн пюдхюкэмн-сонпмнцн хкх пюдхюкэмнцн ондьхомхйю
C
      IF(TIP.EQ.4) THEN
C      аюгнбюъ ярюрхвеяйюъ няебюъ цпсгнондзEлмнярэ
       COA=220.*(1-A)*Z*LWE*DW*SIN(ALFAR)
	END IF
C      ярюрхвеяйюъ щйбхбюкемрмюъ няебюъ мюцпсгйю
      POA=FA
	IF(ALFA.NE.90.) POA=2.3*FR*TAN(ALFAR)+FA
      IF(POA.GT.COA) THEN
	 PRINT *,'PODSHIPNIK NE PROHODIT PO STATISHECKOY GP'
	 WRITE (15,*) 
     *  'ондьхомхй ме опнундхр он ярюрхвеяйни цпсгнондзелмнярх'
	 WRITE (15,100) COA,POA
	 STOP
	END IF
	WRITE (15,100) COA,POA
      RETURN
  100 FORMAT(1X,'аюгнбюъ ярюрхвеяйюъ пюдхюкэмюъ цпсгнондзEлмнярэ C(or)='
     *       ,F15.3,' H',/,1X,
     *'ярюрхвеяйюъ щйбхбюкемрмюъ пюдхюкэмюъ мюцпсгйю   P(or)=',F15.3,
     * ' H')
  101 FORMAT(1X,'аюгнбюъ ярюрхвеяйюъ няебюъ цпсгнондзEлмнярэ Coa=',
     * F15.3,' H'/,1X,'ярюрхвеяйюъ щйбхбюкемрмюъ няебюъ мюцпсгйю   Poa=',
     * F15.3,' H')
  107 FORMAT(1X,'йнщттхжхемр дхмюлхвеяйни пюдхюкэмни мюцпсгйх X=',F7.2)
  108 FORMAT(1X,'йнщттхжхемр дхмюлхвеяйни няебни мюцпсгйх     Y=',F7.2)
  109 FORMAT(1X,'йнщт., гюбхяъыхи нр ценлерпхх, рнвмнярх х люрепхюкю ',
     *       'ондьхомхйю F(c):',F7.2)
	END
C