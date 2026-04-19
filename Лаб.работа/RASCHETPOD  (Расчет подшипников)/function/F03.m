function [F0,NTR] = F03(A)
%  
global ALFA DW DPE
%
NEQ=0; NTR=0; F0=0;
F45 = [42.1,51.7,58.2,63.3,67.3,70.7,73.5,75.9,78.0,79.7,81.1,...
       82.3,83.3,84.1,84.7,85.1,85.4,85.5,85.5,85.4,85.2,84.9,...
       84.5,84.0,83.4,82.8,82.0,81.3,80.4,79.6];
F60 = [39.2,48.1,54.2,58.9,62.6,65.8,68.4,70.7,72.6,74.2,75.5,...
       76.6,77.5,78.3,78.8,79.2,79.5,79.6,79.6,79.5];
F75 = [37.3,45.9,51.7,56.1,59.7,62.7,65.2,67.3,69.2,70.7];
F90 = [36.7,45.2,51.1,55.7,59.5,62.9,65.8,68.5,71.0,73.3,75.4,...
       77.4,79.3,81.1,82.7,84.4,85.9,87.4,88.8,90.2,91.5,92.8,...
       94.4,95.3,96.4,97.6,98.7,99.8,100.8,101.9,102.9,103.9,...
       104.8,105.8,106.7];  
%
if NEQ == 0
    OTN(1)=0.01;
	for I=2:35
        OTN(I)=OTN(I-1)+0.01;
    end
    NEQ=1;
end
%
if ALFA == 45
    for I=2:30
        if A == OTN(I)
            F0=F45(I);
            return
        end
	    if A > OTN(I), continue; end
        F0=(F45(I)-F45(I-1))/(OTN(I)-OTN(I-1));
        F0=F45(I-1)+F0*(A-OTN(I-1));
        return
    end
end
%
if ALFA < 60
    for I=2:20
        if A > OTN(I), continue; end
	    YN=(F45(I)-F45(I-1))/(OTN(I)-OTN(I-1));
	    YN=F45(I-1)+YN*(A-OTN(I-1));
	    YV=(F60(I)-F60(I-1))/(OTN(I)-OTN(I-1));
  	    YV=F60(I-1)+YV*(A-OTN(I-1));
        F0=(YV-YN)/(60-45);
	    F0=YN+F0*(ALFA-45);
        return
    end
    fprintf ('\n ÍÅÏÐÀÂÈËÜÍÎ ÇÀÄÀÍÛ Dw=%g È Dpe= %g',DW,DPE);
    NTR=1;
    return
end
%
if ALFA == 60
    for I=2:20
        if A == OTN(I)
            F0=F60(I);
            return
        end 
        if A > OTN(I), continue; end
        F0=(F60(I)-F60(I-1))/(OTN(I)-OTN(I-1));
        F0=F60(I-1)+F0*(A-OTN(I-1));
        return
    end
end
%
if ALFA < 75
    for I=2:10
        if A > OTN(I), continue; end
        YN=(F60(I)-F60(I-1))/(OTN(I)-OTN(I-1));
	    YN=F60(I-1)+YN*(A-OTN(I-1));
	    YV=(F75(I)-F75(I-1))/(OTN(I)-OTN(I-1));
  	    YV=F75(I-1)+YV*(A-OTN(I-1));
        F0=(YV-YN)/(75-60);
	    F0=YN+F0*(ALFA-60);
        return
    end
    fprintf ('\n ÍÅÏÐÀÂÈËÜÍÎ ÇÀÄÀÍÛ Dw=%g È Dpe= %g',DW,DPE);
    NTR=1;
    return
end
%
if ALFA == 75
    for I=2:10
        if A == OTN(I)
            F0=F75(I);
            return
        end
	    if A > OTN(I), continue; end
        F0=(F75(I)-F75(I-1))/(OTN(I)-OTN(I-1));
        F0=F75(I-1)+(F0*(A-OTN(I-1)));
        return
    end 
end
%
if ALFA < 90
    for I=2:10
        if A > OTN(I), continue; end
	    YN=(F75(I)-F75(I-1))/(OTN(I)-OTN(I-1));
	    YN=F75(I-1)+YN*(A-OTN(I-1));
	    YV=(F90(I)-F90(I-1))/(OTN(I)-OTN(I-1));
  	    YV=F90(I-1)+YV*(A-OTN(I-1));
        F0=(YV-YN)/(90-75);
	    F0=YN+F0*(ALFA-75);
        return
    end 
    fprintf ('\n ÍÅÏÐÀÂÈËÜÍÎ ÇÀÄÀÍÛ Dw=%g È Dpe= %g',DW,DPE);
    NTR=1;
    return
end
%
if ALFA == 90
    for I=2:41
        if A == OTN(I)
            F0=F90(I);
            return
        end
        if A > OTN(I), continue; end
        F0=(F90(I)-F90(I-1))/(OTN(I)-OTN(I-1));
        F0=F90(I-1)+F0*(A-OTN(I-1));
        return
    end
end
end

