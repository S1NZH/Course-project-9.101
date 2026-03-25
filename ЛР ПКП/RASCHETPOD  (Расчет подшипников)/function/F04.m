function [F0,NRE] = F04(A)
%
global IR
%
NEQ=0; NRE=0;
F1 = [52.1,60.8,66.5,70.7,74.1,76.9,79.2,81.2,82.8,84.2,85.4,...
         86.4,87.1,87.7,88.2,88.5,88.7,88.8,88.8,88.7,88.5,88.2,...
         87.9,87.5,87.0,86.4,85.8,85.2,84.5,83.8];
%
if NEQ == 0
    OTN(1)=0.01;
	for I=2:30
        OTN(I)=OTN(I-1)+0.01;
    end
    NEQ=1;
end
%
for I=2:30
    if A == OTN(I)
        if IR == 1, F0=F1(I); end
        return
    end
	if A > OTN(I), continue; end
    F0=(F1(I)-F1(I-1))/(OTN(I)-OTN(I-1));
    F0=F1(I-1)+(F0*(A-OTN(I-1)));
    return
end
end

