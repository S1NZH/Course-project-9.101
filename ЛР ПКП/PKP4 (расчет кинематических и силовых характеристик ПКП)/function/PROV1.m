function [KL1,KL2,L] = PROV1(NZVENA,K)
global MPR
L=0;
KL1=0;
KL2=0;
for L11=1:3
     if MPR(L11,K) == NZVENA, L=L11; end
end
if L == 0, return; end
    if L == 1
        KL1=MPR(2,K);
        KL2=MPR(3,K);           
    end
    if L == 2
        KL1=MPR(1,K);
        KL2=MPR(3,K);           
    end
    if L == 3
        KL1=MPR(1,K);
        KL2=MPR(2,K);           
    end
end

