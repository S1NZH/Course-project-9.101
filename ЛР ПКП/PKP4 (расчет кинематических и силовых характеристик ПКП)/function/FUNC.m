function [ POPW ] = FUNC
global NPT KR0 KMUF0 KRJA
%
addpath([pwd '\function'])
%
POPW=0;
[TYT]=WWODID;
%
if KR0 ~= 0 || KMUF0 ~= 0
if KRJA==0
NPRIZN=0;
for I1=1:NPT
I11=I1;
%
[NPIZNAK]=RASCHET(I11,NPRIZN);
%
end
%
[POP5]=PECAT;
%
end
end
end

