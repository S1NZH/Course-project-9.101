function [LSTAL] = NOMERSTALIB (ASTAL1, BSTAL1, NST)
%   Detailed explanation goes here
LSTAL=0; IPRIZ1=0; IPRIZ2=0;
for IU=1:20
    if ASTAL1(IU) == ' ', break; end
    IPRIZ1=IPRIZ1+1;
end
for IU=1:20
    if BSTAL1(IU) == ' ', break; end
    IPRIZ2=IPRIZ2+1;
end
if IPRIZ1 ~= IPRIZ2, return; end
if ASTAL1 == BSTAL1, LSTAL=NST; end
end


