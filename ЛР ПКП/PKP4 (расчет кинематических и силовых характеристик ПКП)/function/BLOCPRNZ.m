function [ NPIZNAK ] = BLOCPRNZ(NP,LK)
global MPR MYF MPT NPR NSS
NPIZNAK=0;
%
%  Œ“¡–¿ Œ¬ ¿ œŒ ¬¿–»¿Õ“” ∆)
%
NPM=0;
for I=1:3
	if MPT(I,NP)==0, continue; end
    KP=MPT(I,NP);
	L1=MYF(1,KP);
	L2=MYF(2,KP);
	if (L1==0)||(L2==0), continue; end
	if (L1==LK)||(L2==LK), NPM=NPM+1; end
end
if NPM==2
    KK=0;
    for I=1:3
        if MPT(I,NP)==0, continue; end
        KP=MPT(I,NP);
	    L1=MYF(1,KP);
	    L2=MYF(2,KP);
	    if (L1==0)||(L2==0), continue; end
	    if (L1==LK)||(L2==LK)
            KK=KK+1;
            if L1==LK, L(KK)=L2; end
            if L2==LK, L(KK)=L1; end
        end     
    end
    for I=1:NPR
        NPM=0;
        for J=1:3
            JK=I;
	        for IJ=1:2
                if MPR(J,I)==L(IJ), NPM=NPM+1; end
            end 
        end
        if NPM==2
            for J=1:3
                if (MPR(J,JK)==L(1))||(MPR(J,JK)==L(2)), continue; end
                L3=MPR(J,JK);
            end
        for IJ=1:3
            if MPT(IJ,NP)==0, continue; end
            KP=MPT(IJ,NP);
	        L1=MYF(1,KP);
	        L2=MYF(2,KP);
	        if (L1~=0)&&(L2~=0), continue; end
            if (L1==L3)||(L2==L3)
                NPIZNAK=1;                
%      PRINT *,'9 NP=',NP,' DANNAJA KOMBINACIJA PT NE DOPUSTIMA'
                return
             end
          end
        end 	
    end
end
%
%  Œ“¡–¿ Œ¬ ¿ œŒ ¬¿–»¿Õ“” «)
%
NPM=0;      
M1=0;
M2=0;
for I=1:3
	if MPT(I,NP)==0, continue; end
    KP=MPT(I,NP);
	L1=MYF(1,KP);
	L2=MYF(2,KP);
	if (L1==0)||(L2==0), continue; end
    if (L1==LK)||(L2==LK)
        NPM=NPM+1;  
	    JG=I;
        if L1==LK, M1=L2; end
        if L2==LK, M1=L1; end
    end
end
if NPM==1
    for I=1:NPR
        NPM=0;
	    for J=1:3
            if MPR(J,I)==M1, NPM=1; end
        end
        if NPM==0, continue; end
	    KK=0;
        for J=1:3
            if MPR(J,I)==M1, continue; end
            KK=KK+1;
	        L(KK)=MPR(J,I);
        end
        for J=1:NSS
            if J==JG, continue; end
	        if MPT(J,NP)==0, continue; end
            KP=MPT(J,NP);
	        L1=MYF(1,KP);
	        L2=MYF(2,KP);
	        NPM=0
            if (L1==0)||(L2==0), continue; end
	        if (L1==L(1))&&(L2==L(2)), NPM=1; end
	        if (L1==L(2))&&(L2==L(1)), NPM=1; end
	        if (L1==L(1))&&(L2==M1),   NPM=1; end
	        if (L1==M1)&&(L2==L(1)),    NPM=1; end
	        if (L1==L(2))&&(L2==M1),    NPM=1; end
	        if (L1==M1)&&(L2==L(2)),    NPM=1; end
            if NPM==0, continue; end
            for JI=1:NSS
                if JI==JG, continue; end
	            if JI==J, continue; end 
	            if MPT(JI,NP)==0, continue; end
                KP=MPT(JI,NP);
	            L1=MYF(1,KP);
	            L2=MYF(2,KP);
                if (L1~=0)&&(L2~=0), continue; end
	            NPM=0;
	            if (L1==L(1))||(L2==L(1)), NPM=1; end
	            if (L1==L(2))||(L2==L(2)), NPM=1; end
	            if (L1.EQ.M1)||(L2.EQ.M1), NPM=1; end
                if NPM==1
                    NPIZNAK=1;
%      PRINT *,'10 NP=',NP,' DANNAJA KOMBINACIJA PT NE DOPUSTIMA'
                    return 
                end
            end
        end
    end
end     
C
C  Œ“¡–¿ Œ¬ ¿ œŒ ¬¿–»¿Õ“” E)
C
NPP=0;
for I=1:NPR
	for J=1:3
        if MPR(J,I)==LK
            NPP=NPP+1;
	        LP=J;
	        LT=I;
        end
    end
end
if NPP~=1
    NPIZNAK=0;
	return
end
K=0;
for I=1:3
	if I==LP, continue; end
	K=K+1;
	L(K)=MPR(I,LT);
end
LTT=0;
for I=1:3
	if MPT(I,NP)==0, continue; end
    KP=MPT(I,NP);
	L1=MYF(1,KP);
	L2=MYF(2,KP);
	if (L1~=0)&&(L2~=0), continue; end
	if (L1==L(1))||(L2==L(1)), LTT=L(1); end
	if (L1==L(2))||(L2==L(2)), LTT=L(2); end
end
if LTT==0
    NPIZNAK=0;
	return
end 
for I=1:3
	if MPR(I,LT)==LK, continue; end
	if MPR(I,LT)==LTT, continue; end
	LM=MPR(I,LT);
end
for I=1:3  	
	if MPT(I,NP)==0, continue; end 
	KP=MPT(I,NP);
	L1=MYF(1,KP);
	L2=MYF(2,KP);
	if (L1==LM)&&(L2==0), NPIZNAK=1; end
    if (L1==LM)&&(L2==LK), NPIZNAK=1; end
    if (L1==LM)&&(L2==LTT), NPIZNAK=1; end
    if (L1==LTT)&&(L2==LK), NPIZNAK=1; end
    if (L2==LM)&&(L1==LK), NPIZNAK=1; end
    if (L2==LM)&&(L1==LTT), NPIZNAK=1; end
    if (L2==LTT)&&(L1==LK), NPIZNAK=1; end
end
if NPIZNAK=1
%C      PRINT *,'8 NP=',NP,' DANNAJA KOMBINACIJA PT NE DOPUSTIMA'
      return
end
end
