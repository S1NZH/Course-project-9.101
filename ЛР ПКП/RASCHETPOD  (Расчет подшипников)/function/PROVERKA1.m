function [TQR] = PROVERKA1(COR,POR)
global fid
%
TQR=0;
if POR > COR
    TQR=1;
    fprintf ('\n ондьхомхй ме опнундхр он ярюрхвеяйни цпсгнондзелмнярх');
    fprintf ('\n  C(or)=%g P(or)=%g',COR,POR);
    fprintf (fid,'\n ондьхомхй ме опнундхр он ярюрхвеяйни цпсгнондзелмнярх');
    fprintf (fid,'\n ярюрхвеяйюъ пюдхюкэмюъ х щйбхбюкемрмюъ пюдхюкэмюъ цпсгнондзEлмнярэ:');
    fprintf (fid,'\n C(or)=%g;  P(or)=%g',COR,POR);
    return
end
fprintf (fid,'\n ярюрхвеяйюъ пюдхюкэмюъ х щйбхбюкемрмюъ пюдхюкэмюъ цпсгнондзEлмнярэ:');
fprintf (fid,'\n C(or)=%g;  P(or)=%g',COR,POR);
end

