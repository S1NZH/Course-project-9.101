function [ NPIZNAK ] = BLOCKOPR(NPR,NP)
% опнбепйю мю мюкхвхе ндхмнвмнцн оп, гбемэъ йнрнпнцн ме бундър мх б йюйхе дпсцхе оп
global MPR IPKP
NPIZNAK=0;
IPKP(NP)=0.;
for K=1:NPR
    NPRIZ(K)=0; 
    for L=1:3
        for I=1:NPR
            if I == K, continue; end
            for J=1:3
                if MPR(K,L) == MPR(I,J), NPRIZ(K)=NPRIZ(K)+1; end
            end
        end
     end
end
NPR=0;
for I=1:NPR
    if NPRIZ(I) == 0, NPIZNAK=40; IPKP(NP)=10000.; return; end
end
end
