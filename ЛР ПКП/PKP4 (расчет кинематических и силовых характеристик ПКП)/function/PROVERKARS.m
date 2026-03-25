function [ NPIZNAK ] = PROVERKARS(NPR,NP)
%
global MPR MPT MYF NZV IPKP CPR W0 K0
%
% Определение остановленных звеньев в элементах управления
%
%  Тормоза
%
for I=1:10
    W0(I)=0;
end
IPKP(NP)=0;
NPIZNAK=0;
MS=NZV-NPR-1;
K0=0;
for II=1:MS
        KE=MPT(II,NP);                                                      
	    L1=MYF(1,KE);                                                      
	    L2=MYF(2,KE);
        if L2 == 0
            K0=K0+1;
            W0(K0)=L1;
        end
end
if W0(1) == 0, return; end
%
%  Блокировочные муфты
%
for JH=1:MS
for II=1:MS
    KE=MPT(II,NP);                                                      
	L1=MYF(1,KE);                                                      
	L2=MYF(2,KE);
    if L2 == 0, continue; end
    K00=K0;
    for JJ=1:K00
        if W0(JJ) == L1
            NB=0;
            for JL=1:K00
                if W0(JL) == L2, NB=1; end
            end
            if NB == 0            
            K0=K0+1; W0(K0)=L2; 
            end
        end
        if W0(JJ) == L2
            NB=0;
            for JL=1:K00
                if W0(JL) == L1, NB=1; end
            end
            if NB == 0
                K0=K0+1; W0(K0)=L1; 
            end
        end
    K00=K0;
    for JJ=1:K00
        NB=0;
        for NN=1:K00
            if W0(NN) == L1, NB=1; end
            if W0(NN) == L2, NB=1; end
        end
        if NB ~= 0, continue; end
        if W0(JJ) == L1, K0=K0+1; W0(K0)=L2; end
        if W0(JJ) == L2, K0=K0+1; W0(K0)=L1; end
    end
end
end
 %
 % Ряд, в котором одно звено остановлено, а два других сблокированы между собой.
 %
K00=K0;
for II=1:K00
    LK=W0(II);
    for K=1:NPR
        [KL1,KL2,L] = PROV1(LK,K);
        if L == 0, continue; end 
        for JJ=1:MS
            NB=0;
            KE=MPT(JJ,NP);
            L1=MYF(1,KE); 
	        L2=MYF(2,KE);
            if L2 == 0, continue; end
            if (L1 == KL1) || (L1 == KL2), NB=NB+1; end
            if (L2 == KL1) || (L2 == KL2), NB=NB+1; end
            if NB ~= 2, continue; end
            ML=0;
            for JL=1:K00
                if W0(JL) == KL1, ML=ML+1; end                
            end
            if ML == 0,K0=K0+1; W0(K0)=KL1; end
            ML=0;
            for JL=1:K00
                if W0(JL) == KL1, ML=ML+1; end                
            end
            if ML == 0,K0=K0+1; W0(K0)=KL2; end
        end
    end
end
%
% Определение остановленных звеньев в планетарных рядах
%
for IKJ=1:NPR
K00=K0;
LL=[0,0,0,0];
LK=0;
for I=1:NPR
    NB=0;
    for J=1:3
        for IJ=1:K00
        if MPR(J,I) == W0(IJ), NB=NB+1; LL(NB)=MPR(J,I); end
        end
    end
    if NB == 2
        for J=1:3
            if MPR(J,I) == LL(1) || MPR(J,I) == LL(2), continue; end
            LK=MPR(J,I);
        end

        if LK ~= 0
            ML=0;
            for JL=1:K00
                if W0(JL) == LK, ML=ML+1; end                
            end
            if ML == 0, K0=K0+1; W0(K0)=LK; end
        end
    end
end
end
%
% Есть ли среди остановленных звеньев ведущее или ведомое звено.
%
for III=1:K0
    if W0(III) == 1 || W0(III) == NZV, NPIZNAK=2; return; end
end
%
% ПР составляют ведущее и ведомое звенья, а третье звено остановлено.
%
NZ=0;
for K=1:NPR
    [KL1,KL2,L] = PROV1(1,K);
    [KLL1,KLL2,LL] = PROV1(NZV,K);
    if (L ~= 0) && (LL ~= 0)
        KPRJ=K;
        NZ=KL1;
        if KL1 == NZV, NZ=KL2; end        
        break
    end
end
for I=1:K0
    if W0(I) == NZ, NPIZNAK=10; IPKP(NP)=CPR(KPRJ)-1; return; end
end
end
            

