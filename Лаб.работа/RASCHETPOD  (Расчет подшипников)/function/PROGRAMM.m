function [TRE] = PROGRAMM(NPRIZ)
global fid NPRIZNAK
TRE=0;
fprintf (fid,'\n ****************************************************');
fprintf (fid,'\n  ');
%      пюявер ярюрхвеяйни цпсгнондзелмнярх
%
[TRQ] = STATGRUS;
%
if TRQ == 0
fprintf (fid,'\n ****************************************************');
fprintf (fid,'\n  ');
%      пюявер мюцпсфеммнярх ондьхомхйю
%
[BVC,NPRIZ] = NAGRUZKA(NPRIZNAK);
%
if NPRIZ == 0, return; end
%      пюявер дхмюлхвеяйни цпсгнондзелмнярх
%
fprintf (fid,'\n ****************************************************');
%       пюявер дхмюлхвеяйни цпсгнондзелмнярх:');
%
[TRQ] = DINGRUS;
fprintf ('\n        пюявер нйнмвем');
end

