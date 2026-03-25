function [ NPIZNAK ] = PROVERKARS2(NPR,NP)
%
global MPR MPT MYF NZV IPKP W0 K0 W1
%
% Определение остановленных звеньев в элементах управления
%
%  Тормоза
%
for I=1:10
    W1(I)=0;
end
IPKP(NP)=0;
NPIZNAK=0;
MS=NZV-NPR-1;
K1=0; K2=0;
%
for JU=1:2
    if JU ==1, NZVENA=1; end
    if JU ==2, NZVENA=NZV; end
    for IT=1:2
    for II=1:NPR
        [KL1,KL2,L] = PROV1(NZVENA,II);
        if L == 0, continue; end
        for JJ=1:MS
            KE=MPT(JJ,NP);                                                      
	        L1=MYF(1,KE);                                                      
	        L2=MYF(2,KE);
            if L2 == 0, continue; end
            if K1 == 0
                NB=0;
                if KL1 == L1 || KL1 == L2, NB=NB+1; end
                if KL2 == L1 || KL2 == L2, NB=NB+1; end            
                if NB ~= 2, continue; end
                K1=K1+1; W1(K1)=L1;
                K1=K1+1; W1(K1)=L2;
                continue;
            end
            if K1 ~= 0
                NB=0;
                if KL1 == L1 || KL1 == L2, NB=1; end
                if KL2 == L1 || KL2 == L2, NB=1; end 
                if NB == 0, continue; end
                K11=K1;
                NB=0;
                for IJ=1:K11
                    if W1(IJ) == L1, NB=1; end
                end
                if NB == 0, K1=K1+1; W1(K1)=L1; end
                NB=0;
                for IJ=1:K11
                    if W1(IJ) == L2, NB=1; end
                end
                if NB == 0, K1=K1+1; W1(K1)=L2; end            
            end
        end
    end
    end
for II=1:NPR
    [KL1,KL2,L] = PROV1(NZVENA,II);
    if L ~= 0
    NB=0;
    for JJ=1:K1
        if W1(JJ) == KL1, NB=NB+1; end
        if W1(JJ) == KL2, NB=NB+1; end
    end
    if NB ~= 1, continue; end
    NB=0;
    for JK=1:K0
        if W0(JK) == KL1, NB=1; end
        if W0(JK) == KL2, NB=1; end
    end
        if NB == 1, NPIZNAK=15; IPKP(NP)=12000; return; end
    end
    NB=0;
    for KJ=1:K1
        if W1(KJ) == MPR(1,II), NB=NB+1; end
        if W1(KJ) == MPR(2,II), NB=NB+1; end
        if W1(KJ) == MPR(3,II), NB=NB+1; end
    end
    if NB ~= 2, continue; end
    NB=0;
    for KJ=1:K1
        for JK=1:3
            if W1(KJ) == MPR(JK,II), continue; end 
            NB=MPR(JK,II);
        end
    end
    for KJ=1:K0
        if W0(KJ) == NB, NPIZNAK=16; IPKP(NP)=10000; return; end
    end
end
NB=1;
for II=1:MS
    KE=MPT(II,NP);
    L1=MYF(1,KE); 
	L2=MYF(2,KE);
    if L2 == 0, continue; end
    if NB == 1
        W2(1)=L1;
        W2(2)=L2;
        K2=2;
        NB=2;
        continue;
    end
        K22=K2;
        for JJ=1:K22
            if W2(JJ) == L1, K2=K2+1; W2(K2)=L2; end
            if W2(JJ) == L2, K2=K2+1; W2(K2)=L1; end
        end
end
for II=1:NPR
    NB=0;
    if K2 ~= 0
    for JJ=1:3
        for JI=1:K2
            if MPR(JJ,II) == W2(JI), NB=NB+1; end
        end
    end
    end
    if NB ~= 2, continue; end
    NB=0;
    for JJ =1:3
        for JI=1:K0
            if MPR(JJ,II) == W0(JI), NB=1; end            
        end            
    end
    if NB == 0, continue; end
    if K2 ~= 0
        for JJ=1:K2
            K0=K0+1;
            W0(K0)=W2(JJ);
        end
    end
end
for II=1:NPR
    NB=0;
    for JJ=1:3
        if MPR(JJ,II) == NZVENA, NB=1; end
    end
    if NB ==0, continue; end
    NB=0;
    for JJ=1:3
        for JI=1:K0
            if MPR(JJ,II) == W0(JI), NB=NB+1; end
        end            
    end
    if NB == 2, NPIZNAK=11; IPKP(NP)=10000; return; end
end
end
end









