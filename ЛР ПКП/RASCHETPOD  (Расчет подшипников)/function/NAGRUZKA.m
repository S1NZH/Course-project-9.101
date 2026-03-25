function [BVC,NPRIZ] = NAGRUZKA(NPRIZNAK)
%
global fid KNMCK KNVOD KR KA MST RVOD NPER LT TMAX FA FR IDVIJ...
           IRASPRED AST NDVSSR MDVSMAX ADVS DOLJA
if NPRIZNAK == 2, AST=1; RVOD=1; MST=0; end      
BVC=0;
if NPER == 1
    FR=KR(1);
	FA=KA(1);
	return
end
%
if IRASPRED == 0
%
[DOLJA,NPRIZ] = DANNYEPOD(NPER,IDVIJ,IRASPRED);
%
if NPRIZ == 0, return; end
end
%

fprintf (fid,'\n пюяопедекемхе бпелемх пюанрш ондьхомхйю он оепедювюл:');
for I=1:NPER
    fprintf (fid,'\n %i -  %g:',I,DOLJA(I));
end
NCR=0; LT=0;
for I=1:NPER
    OBOR(I)=60*DOLJA(I)*TMAX*abs(KNMCK(I))*NDVSSR;
    LT=LT+OBOR(I)/1000000;	
    NCR=NCR+OBOR(I);
end
FR=0; FA=0;
for I=1:NPER
    KR1(I)=abs(KR(I))*MDVSMAX*ADVS/(AST*RVOD);
    WVOD=abs(KNVOD(I))*NDVSSR;
	FCB(I)=MST*RVOD*WVOD^2;
    AY=sqrt(KR1(I)^2+FCB(I)^2);
	AYP(I)=AY;
    AY=AY^(10/3);
    FR=FR+AY*OBOR(I)/NCR;
    AY=(abs(KA(I))*MDVSMAX*ADVS/AST)^(10/3);
    FA=FA+AY*OBOR(I)/NCR;
end
FR=FR^0.3;
FA=FA^0.3;
%
fprintf (fid,'\n пюдхюкэмюъ, жемрпнаефмюъ х ясллюпмюъ пюдхюкэмюъ яхкш');
fprintf (fid,'\n он оепедювюл, H:');
for I=1:NPER
    fprintf (fid,'\n %i -  %9.2f   %9.2f   %9.2f:',I,KR1(I),FCB(I),AYP(I));
end
fprintf (fid,'\n Cсллюпмне вхякн нанпнрнб ондьхомхйю  N= %g',NCR);
fprintf (fid,'\n япедмъъ пюдхюкэмюъ яхкю F(r)= %g H',FR);
fprintf (fid,'\n япедмъъ няебюъ яхкю     F(a)= %g H',FA);
end

