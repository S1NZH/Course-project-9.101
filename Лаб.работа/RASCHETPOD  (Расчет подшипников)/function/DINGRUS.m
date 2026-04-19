%      ондопнцпюллю пюяверю дхмюлхвеяйни цпсгнондзелмнярх
%
function [TRQ] = DINGRUS
%
global TIP DW DPE LWE Z IR ALFA FR FA fid SMAX...    
          FC BM CR X0 Y0 KB KT V PR A23 L10 LT LS 
%
fprintf (fid,'\n  ');
fprintf (fid,'\n пюявер дхмюлхвеяйни цпсгнондзелмнярх:');
fprintf (fid,'\n  ');
%
BM=1.3; KB=1.4; KT=1.; TRQ=0;
%
ALFAR=3.14*ALFA/180;
if ALFA ~= 90, A=DW*cos(ALFAR)/DPE; end
if ALFA == 90, A=DW/DPE; end
%
%      пюявер ьюпхйнбнцн пюдхюкэмнцн х пюдхюкэмн-сонпмнцн ондьхомхйю
%
if TIP == 1  
    A23=1;
%
%      аюгнбюъ дхмюлхвеяйюъ пюдхюкэмюъ пюявермюъ цпсгнондзEлмнярэ
%
    [FC] = F02(A);
%
    A1=Z^(2/3);
    A3=(IR*cos(ALFAR))^0.7;
	if DW <= 25.4
        A2=DW^1.8;	  
        CR=BM*FC*A1*A2*A3;
    end
	if DW > 25.4
        A2=DW^1.4;
        CR=3.647*BM*FC*A1*A2*A3;
    end  
%      дхмюлхвеяйюъ щйбхбюкемрмюъ пюдхюкэмюъ мюцпсгйю
%
    [X0,Y0] = XY2;
%
    PR=(X0*V*FR+Y0*FA)*KB*KT;
%      дхмюлхвеяйюъ щйбхбюкемрмюъ пюдхюкэмюъ мюцпсгйю
    L10=A23*(CR/PR)^3;
	LS=SMAX*L10/LT;
    [TTT] = PRNTD; 
end   
%
%      пюявер ьюпхйнбнцн сонпмнцн х сонпмнцн-пюдхюкэмнцн ондьхомхйю
%
if TIP == 2    
    A23=1;
%
%      аюгнбюъ дхмюлхвеяйюъ няебюъ пюявермюъ цпсгнондзEлмнярэ
%
    [FC,NTR] = F03(A);
    if NTR ~= 0, return; end
%
	if DW <= 25.4
        COSI=cos(ALFAR);
	    TANG=tan(ALFAR);
        if ALFA == 90
            A1=Z^(2/3);
	        A2=DW^1.8;
	        CR=BM*FC*A1*A2;
        end
        if ALFA ~= 90
            A1=COSI^0.7;
	        A2=Z^(2/3);
	        A3=DW^1.8;
	        CR=BM*FC*A1*TANG*A2*A3;
        end
    end
	if DW > 25.4
        if ALFA == 90
            A2=Z^(2/3);
	        A3=DW^1.4;	  
	        CR=3.647*BM*FC*A2*A3;
        end
        if ALFA ~= 90
            A1=COSI^0.7;
	        A2=Z^(2/3);
            A3=DW^1.4;
            CR=3.647*BM*FC*A1*TANG*A2*A3;
        end
    end
%      дхмюлхвеяйюъ щйбхбюкемрмюъ няебюъ мюцпсгйю
%
    [X0,Y0] = XY3;
%
    PR=(X0*FR+Y0*FA)*KB*KT;
%      аюгнбши пюявермши пеяспя, [лхккхнм нанпнрнб]
    L10=A23*(CR/PR)^3;
	LS=SMAX*L10/LT;
    [TTT] = PRNTD; 
end
%
%       пюявер пнкхйнбнцн пюдхюкэмнцн хкх пюдхюкэмн-сонпмнцн ондьхомхйю
%
if TIP == 3    
    A23=0.8;
%
%      аюгнбюъ дхмюлхвеяйюъ пюдхюкэмюъ пюявермюъ цпсгнондзEлмнярэ
%
    [FC,NRE] = F04(A);
%
if NRE ~= 0, return; end
X0=0; Y0=0;
    BM3=1.1;
    A1=(IR*LWE*cos(ALFAR))^(7/9);
	A2=Z^(3/4);
	A3=DW^(29/27);
    CR=BM3*FC*A1*A2*A3;
%      дхмюлхвеяйюъ щйбхбюкемрмюъ пюдхюкэмюъ мюцпсгйю
%
    PR=FR; 
    if ALFA ~= 0
%
        [X0,Y0] = XY4;
%
        PR=(X0*V*FR+Y0*FA)*KB*KT;
    end
%       аюгнбши пюявермши пеяспя, [лхккхнм нанпнрнб]
    L10=A23*(CR/PR)^(10/3);
	LS=SMAX*L10/LT;
    [TTT] = PRNTD; 
end
%     пюявер пнкхйнбнцн сонпмнцн х сонпмн-пюдхюкэмнцн ондьхомхйю
%
if TIP == 4    
    A23=0.9;
%
%      аюгнбюъ дхмюлхвеяйюъ няебюъ пюявермюъ цпсгнондзEлмнярэ
%
    [FC] = F05(A);
%
    BM3=1;
	if ALFA ~= 90
        A1=(LWE*cos(ALFAR))^(7/9);
	    A2=Z^(3/4);
	    A3=DW^(29/27);
        CR=BM3*FC*A1*tan(ALFAR)*A2*A3;
    end
	if ALFA == 90
        A1=LWE^(7/9);
        A2=Z^(3/4);
        A3=DW^(29/27);
        CR=BM3*FC*A1*A2*A3;
    end
fprintf (fid,'    ');
%       дхмюлхвеяйюъ щйбхбюкемрмюъ няебюъ мюцпсгйю
%
    [X0,Y0] = XY5;
%
    PR=(X0*FR+Y0*FA)*KB*KT;
%      аюгнбши пюявермши пеяспя, [лхккхнм нанпнрнб]
    L10=A23*(CR/PR)^(10/3);
	LS=SMAX*L10/LT;
    [TTT] = PRNTD; 
end
end