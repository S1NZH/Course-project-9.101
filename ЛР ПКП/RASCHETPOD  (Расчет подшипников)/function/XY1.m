function [X0,Y0] = XY1(ALFA,IR)
%
AL = [0,12,15,20,25,30,35,40,45];
X1 = [0.6,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5];
Y1 = [0.5,0.47,0.46,0.42,0.38,0.33,0.29,0.26,0.22];
Y2 = [0.5,0.94,0.92,0.84,0.76,0.66,0.58,0.52,0.44];
%
if ALFA == 0
    X0=0.6;
	Y0=0.5;
    return
end
%
for I=2:8
    if ALFA == AL(I)
        if IR == 1
            X0=0.5;
	        Y0=Y1(I);
	        return
        end
        if IR == 2
            X0=1;
	        Y0=Y2(I);
            return
        end
    end
	if  ALFA > AL(I), continue; end
    if IR == 1
        X0=0.5;
	    Y0=(Y1(I)-Y1(I-1))/(AL(I)-AL(I-1));
	    Y0=Y1(I-1)+Y0*(ALFA-AL(I-1));
        return
    end
	if IR == 2
        X0=1;
	    Y0=(Y2(I)-Y2(I-1))/(AL(I)-AL(I-1));
	    Y0=Y2(I-1)+Y0*(ALFA-AL(I-1));
        return
    end
end 
end

