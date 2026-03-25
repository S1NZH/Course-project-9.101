function [X,Y,NTR] = XY3
%
global ALFA FR FA
OTN = [0.66,0.73,0.81,0.92,1.06,1.28,1.66,2.43,4.80];
E0 = [1.25,1.48,1.79,2.17,2.68,3.43,4.67,7.09,14.28];
AL = [45.,50.,55.,60.,65.,70.,75.,80.,85.];
%
NTR=0;
if ALFA < 45
    fprintf ('\n ÍÅÏÐÀÂÈËÜÍÎ ÇÀÄÀÍ ÒÈÏ ÏÎÄØÈÏÍÈÊÀ!!!');
    NTR=1;
    return
end
ALFAR=3.14*ALFA/180;
OT=FA/FR;
Y=1;
X=1.25*tan(ALFAR)*(1-2*SIN(ALFAR)/3);
for I=1:9
    if ALFA == AL(I)
        if OT >= E0(I)
            fprintf ('\n ÍÅ ÂÛÏÎËÍßÅÒÑß ÓÑËÎÂÈÅ FA/FR > E!');
            fprintf ('\n FA/FR= %g  E= %g',OT,E0(I));
            NTR=1;
            return
        end
    end
    if ALFA < AL(I), continue; end
	E=(E0(I+1)-E0(I))/(AL(I+1)-AL(I));
	E=E0(I)+E*(ALFA-AL(I));
	if OT <= E
        fprintf ('\n ÍÅ ÂÛÏÎËÍßÅÒÑß ÓÑËÎÂÈÅ FA/FR > E!');
        fprintf ('\n FA/FR= %g  E= %g',OT,E);
        NTR=1;
        return
    end
end
end

