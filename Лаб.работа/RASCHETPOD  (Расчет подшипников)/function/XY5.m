function [X,Y,NTR] = XY5
%
global IR ALFA FR FA
%
ALFAR=3.14*ALFA/180;
OT=FA/FR;
E=1.5*tan(ALFAR);
NTR=0;
%
if IR == 1
    if OT <= E
        fprintf ('\n ÎÒÍÎØÅÍÈÅ ÍÅ ÏÐÈÌÅÍÈÌÎ ÄËß ÎÄÈÍÀÐÍÛÕ ÏÎÄØÈÏÍÈÊÎÂ’');
        fprintf ('\n FA/FR= %g  E= %g',OT,E');
        NTR=1;
        return
    end
    if OT > E
        X=tan(ALFAR);
	    Y=1;
    end
end
%
if IR == 2
    if OT <= E
        X=1.5*tan(ALFAR);
        Y=0.67;
    end
	if OT > E
	  X=tan(ALFAR);
	  Y=1;
    end
end
end

