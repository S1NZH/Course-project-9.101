function [LSTALA] = NOMERSTALIA(ASTAL1)
% Определение марки стали зубчатых колес для дальнейших расчетов
IPRIZ=1;
LSTALA=0;
for IU=1:20
switch IPRIZ
    case 1
if ASTAL1(IU)~=' ', LSTALA=LSTALA+1; end
if ASTAL1(IU)==' ', IPRIZ=2; end
    case 2       
end
end
end

