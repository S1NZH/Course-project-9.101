function [NPIZNAK] = BLOCK1N(NPR,NP,LK)
%      опнбейю мю мюкхвхе бедсыецн хкх беднлнцн гбемю 
%      б янярюбе окюмерюпмшу леуюмхглнб

global	MPR MYF MPT IPKP 
%
NPIZNAK=0;
for I=1:NPR
    for J=1:3        
        if MPR(J,I) == LK; return; end
    end
end
%     опх нрясрярбхх бедсыецн гбемю б янярюбе оп опнбепйю мю рн, 
%     врнаш мю оепедювE хяонкэгсеряъ лстрю я бедсыхл хкх беднлшл гбемнл
KMUF0=0;
for J=1:3
    L1=MPT(J,NP);
	if MYF(1,L1) == LK, KMUF0=1; end
end
if KMUF0 == 0, NPIZNAK=5; IPKP(NP)=10000; return; end
end

