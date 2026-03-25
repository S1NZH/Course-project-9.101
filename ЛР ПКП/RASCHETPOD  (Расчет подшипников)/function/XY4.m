function [X,Y] = XY4
%
global IR ALFA FR FA
%
ALFAR=3.14*ALFA/180;
OT=FA/FR;
E=1.5*tan(ALFAR);
%
if IR == 1
    if OT <= E
        X=1;
        Y=0;
    end
	if OT > E
        X=0.4;
	    Y=0.4/tan(ALFAR);
    end
end
%
if IR == 2
    if OT <= E
        X=1;
        Y=0.45/tan(ALFAR);
    end
	if OT > E
        X=0.67;
	    Y=0.67/tan(ALFAR);
    end
end
end

