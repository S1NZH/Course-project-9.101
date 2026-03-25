%
%      ондопнцпюллю пюяверю ярюрхвеяйни цпсгнондзелмнярх
%
function [TRQ] = STATGRUS
global TIP DW DPE LWE Z IR ALFA fid MDVSMAX NDVSMAX RVOD...
          AST KR KNVOD NPER MST KA
%
TRQ=0;
fprintf (fid,'\n пюявер ярюрхвеяйни цпсгнондзелмнярх:');
fprintf (fid,'\n   ');
ALFAR=3.14*ALFA/180;
A=DW*cos(ALFAR)/DPE;
for I=1:NPER
    KR1(I)=KR(I)*MDVSMAX/(RVOD*AST);
    WVOD=KNVOD(I)*NDVSMAX;
	FCB(I)=MST*RVOD*WVOD^2;
    AYP(I)=sqrt(KR1(I)^2+FCB(I)^2);
end
FR=0; FA=0;
for I=1:NPER
    if FR <= abs(AYP(I)), FR=abs(AYP(I)); end
    if FA <= abs(KA(I)), FA=abs(KA(I)); end
end
fprintf (fid,'\n лЮЙЯХЛЮКЭМЮЪ ПЮДХЮКЭМЮЪ МЮЦПСГЙЮ МЮ ОНДЬХОМХЙ - %g, м',FR);
fprintf (fid,'\n лЮЙЯХЛЮКЭМЮЪ НЯЕБЮЪ МЮЦПСГЙЮ МЮ ОНДЬХОМХЙ - %g, м',FA);
%
%      пюявер ьюпхйнбнцн пюдхюкэмнцн хкх пюдхюкэмн-сонпмнцн ондьхомхйю═п²п·п⌠п· п÷п·п■п╗п?п÷п²п?п п░
%
if TIP == 1  
%      аюгнбюъ ярюрхвеяйюъ пюдхюкэмюъ цпсгнондзEлмнярэ
%
    [F0] = F01(A,TIP);
%
    fprintf (fid,'\n йнщт., гюбхяъыхи нр ценлерпхх, рнвмнярх х люрепхюкю: %g',F0);
    COR=F0*IR*Z*(DW^2)*cos(ALFAR);
%      ярюрхвеяйюъ щйбхбюкемрмюъ пюдхюкэмюъ мюцпсгйю
%
    [X0,Y0] = XY1(ALFA,IR);
%
    fprintf (fid,'\n йнщттхжхемр дхмюлхвеяйни пюдхюкэмни мюцпсгйх X= %7.3f',X0);
    fprintf (fid,'\n йнщттхжхемр дхмюлхвеяйни няебни мюцпсгйх           Y= %7.3f',Y0);
    %
    POR=X0*FR+Y0*FA;
    %
    if POR < FR, POR=FR; end
%
        [TRQ] = PROVERKA1(COR,POR);
%
end
%
%      пюявер ьюпхйнбнцн пюдхюкэмн-сонпмнцн хкх пюдхюкэмнцн ондьхомхйю
%
if TIP == 2
    TRQ=0;
    if ALFA < 45
        fprintf ('\n меопюбхкэмн гюдюм рхо ондьхомхйю!!!');
        fprintf ('\n мнлхмюкэмши сцнк йнмрюйрю ондьхомхйю лнфер ашрэ');
        fprintf ('\n лемэье 45  ЦПЮДСЯНБ');
        TRQ=1;
        return
    end
%      аюгнбюъ ярюрхвеяйюъ няебюъ цпсгнондзлEмнярэ
%
     [F0] = F01(A,TIP);
%
    fprintf (fid,'\n йнщт., гюбхяъыхи нр ценлерпхх, рнвмнярх х люрепхюкю: %g',F0);
    COA=F0*Z*(DW^2)*sin(ALFAR);
%      ярюрхвеяйюъ щйбхбюкемрмюъ няебюъ мюцпсгйю
    POA=FA;
	if ALFA ~= 90, POA=2.3*FR*tan(ALFAR)+FA; end
%
    [TRQ] = PROVERKA1(COA,POA);
%  
end
%
%      пюявер пнкхйнбнцн пюдхюкэмнцн хкх пюдхюкэмн-сонпмнцн ондьхомхйю
%
if TIP == 3    
    if A > 0.3
        TRQ=1;
        fprintf ('\n меопюбхкэмн бшапюм рхо ондьхомхйю');
        fprintf ('\n нрмньемхе Dw*cos(ALFA)/Dpw МЕ ДНКФМН ОПЕБШЬЮРЭ 0,3;')
        fprintf ('\n Dw*cos(ALFA)/Dpw= %g',A);
	    return
    end
%      аюгнбюъ ярюрхвеяйюъ пюдхюкэмюъ цпсгнондзEлмнярэ
    COR=44.*(1-A)*IR*Z*LWE*DW*cos(ALFAR);
%      ярюрхвеяйюъ щйбхбюкемрмюъ пюдхюкэмюъ мюцпсгйю
   if ALFA == 0, POR=FR; end
    if ALFA ~= 0
        if IR == 1, X0=0.5; Y0=0.22/tan(ALFAR); end
        if IR == 2, X0=1.0; Y0=0.44/tan(ALFAR); end
        fprintf (fid,'\n йнщттхжхемр дхмюлхвеяйни пюдхюкэмни мюцпсгйх X= %g',X0);
        fprintf (fid,'\n йнщттхжхемр дхмюлхвеяйни няебни мюцпсгйх            Y= %g',Y0);
        %
        POR=X0*FR+Y0*FA;
        %
	    if POR < FR, POR=FR; end
    end 
%
    [TRQ] = PROVERKA1(COR,POR);
%
    return
end
%
%      пюявер пнкхйнбнцн пюдхюкэмн-сонпмнцн хкх пюдхюкэмнцн ондьхомхйю
%
if TIP == 4
    if ALFA < 50
        fprintf ('\n меопюбхкэмн гюдюм рхо ондьхомхйю!!!');
        fprintf ('\n мнлхмюкэмши сцнк йнмрюйрю ондьхомхйю лнфер ашрэ');
        fprintf ('\n лемэье 50 ЦПЮДСЯНБ');
        NTR=1;
        return
    end
%      аюгнбюъ ярюрхвеяйюъ няебюъ цпсгнондзEлмнярэ
    COA=220.*(1-A)*Z*LWE*DW*sin(ALFAR);
%      ярюрхвеяйюъ щйбхбюкемрмюъ няебюъ мюцпсгйю
POA=FA;
if ALFA ~= 90, POA=2.3*FR*tan(ALFAR)+FA; end
%
    [TRQ] = PROVERKA1(COA,POA);
%
end
end

