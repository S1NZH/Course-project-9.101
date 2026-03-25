function [LSTAL] = NOMERSTALIB (ASTAL1, BSTAL1, LSTALA, NST)
%   Detailed explanation goes here
LSTAL=0;
IPRIZ=1;
LSTALB=0;
for IU=1:20
    switch IPRIZ
    case 1
    if BSTAL1(IU) ~= ' ', LSTALB=LSTALB+1; end
    if BSTAL1(IU) == ' ', IPRIZ=2; end
    case 2       
end
end
if LSTALB == LSTALA
IPRIZ=0;
for IK=1:LSTALA
    if BSTAL1(IK) == ASTAL1(IK), IPRIZ=IPRIZ+1; end
end
if IPRIZ == LSTALA, LSTAL=NST; end
end
end


