function [X,Y,NPR] = XY2
%
global DW Z IR ALFA FR FA
OTN = [0.,0.172,0.345,0.689,1.03,1.38,2.07,3.45,5.17,6.89,0.0];
E0 = [0.,0.19,0.22,0.26,0.28,0.30,0.34,0.38,0.42,0.44,0.0];
E5 = [0.,0.23,0.26,0.30,0.34,0.36,0.40,0.45,0.50,0.32,0.0];
E10 = [0.,0.29,0.32,0.36,0.38,0.40,0.44,0.49,0.54,0.54,0.0];
E15 = [0.,0.38,0.40,0.43,0.26,0.47,0.5,0.55,0.56,0.56,0.0];
E201 = [0.0,10*0.57];
E20=0.57; E25=0.68; E30=0.8; E35=0.95; E40=1.14; E45=1.34;
Y0 = [0.,2.3,1.99,1.71,1.55,1.45,1.31,1.15,1.04,1.0,0.0];
Y5 = [0.,2.3,1.99,1.71,1.55,0,0,0,0,0,0];
Y10 = [0.,1.88,1.71,1.52,1.41,1.34,1.23,1.1,1.01,1.0,0.0];
Y15 = [0.,1.47,1.4,1.3,1.23,1.19,1.12,1.02,1.0,1.0,0.0];
Y20 = [0,1,1,1,1,1,1,1,1,1,1];
NPR=0;
FAFR=FA/FR;
X=1.0;
if FA == 0
    Y=0;
	return
end
OTNOSCH=FA/(IR*Z*DW^2);
NPRIZ=0;
for I=1:11
    if OTN(I) < OTNOSCH, continue; end
	KOTR=I;
    NPRIZ=1;
	break
end
if NPRIZ == 0
    if ALFA < 20
        if KOTR == 0
            fprintf ('\n ÍÅÏÐÀÂÈËÜÍÎ ÂÛÁÐÀÍ ÒÈÏ ÏÎÄØÈÏÍÈÊÀ:');
            fprintf ('\n ÎÒÍÎØÅÍÈÅ= %g  ÄÎÏÓÑÊÀÅÌÎÅ ÎÒÍÎØÅÍÈÅ== %g',OTNOSCH,OTN(10));
            NPR=1;
        end
    end
end 
%
if ALFA <= 0.1
    E=(E0(KOTR)-E0(KOTR-1))/(OTN(KOTR)-OTN(KOTR-1));
	E=E0(KOTR-1)+E*(OTNOSCH-OTN(KOTR-1));
    Y=0;
	if FAFR > E
        X=0.56;
        Y=(Y0(KOTR)-Y0(KOTR-1))/(OTN(KOTR)-OTN(KOTR-1));
        Y=Y0(KOTR-1)+Y*(OTNOSCH-OTN(KOTR-1));
    end
    return
end
%
if ALFA < 5    
%
    [Y,E] = YPROM(E0,E5,Y0,Y5,OTN,KOTR,0.,5);
%
	if FAFR > E
        X=0.56;
	    if KOTR > 5, X=1; end
    end
	return
end
%
if ALFA == 5
    E=(E5(KOTR)-E5(KOTR-1))/(OTN(KOTR)-OTN(KOTR-1));
	E=E5(KOTR-1)+E*(OTNOSCH-OTN(KOTR-1));
    Y=0.
	if FAFR > E
        if KOTR <= 5
            X=0.56;
            Y=(Y5(KOTR)-Y5(KOTR-1))/(OTN(KOTR)-OTN(KOTR-1));
            Y=Y5(KOTR-1)+Y*(OTNOSCH-OTN(KOTR-1));
	        return
        end
	    if KOTR > 5
            Y=0;
            return
        end
        return
    end
end
%
if ALFA < 10    
%
   [Y,E] = YPROM(E5,E10,Y5,Y10,OTN,KOTR,5.,10);
%
	if FAFR > E
        if KOTR <= 5
            X=(0.46-0.56)/(10-5);
	        X=0.56+X*(ALFA-5);
        end
	    if KOTR > 5
            X=(0.46-1)/(10-5);
	        X=1.+X*(ALFA-5);
        end
    end
    return
end
%
if ALFA == 10
    E=(E10(KOTR)-E10(KOTR-1))/(OTN(KOTR)-OTN(KOTR-1));
	E=E10(KOTR-1)+E*(OTNOSCH-OTN(KOTR-1));
    Y=0;
	if FAFR > E
        X=0.46;
        Y=(Y10(KOTR)-Y10(KOTR-1))/(OTN(KOTR)-OTN(KOTR-1));
        Y=Y10(KOTR-1)+Y*(OTNOSCH-OTN(KOTR-1));
    end
    return
end
%
if ALFA < 15
%    
    [Y,E] = YPROM(E10,E15,Y10,Y15,OTN,KOTR,10.,15);
%    
	if FAFR > E
        X=(0.44-0.46)/(15-10);
        X=0.46+X*(ALFA-10);
        return
    end
end
%
if ALFA == 15
    E=(E15(KOTR)-E15(KOTR-1))/(OTN(KOTR)-OTN(KOTR-1));
	E=E15(KOTR-1)+E*(OTNOSCH-OTN(KOTR-1));
    Y=0;
	if FAFR > E
        X=0.44;
        Y=(Y15(KOTR)-Y15(KOTR-1))/(OTN(KOTR)-OTN(KOTR-1));
        Y=Y15(KOTR-1)+Y*(OTNOSCH-OTN(KOTR-1));
    end
    return
end
%
if ALFA < 20    
%
    [Y,E] = YPROM(E15,E201,Y15,Y20,OTN,KOTR,15.,20);
%       
	if FAFR > E
        X=(0.43-0.44)/(20-15);
        X=0.44+X*(ALFA-15);
        return
    end
end
if ALFA == 20
    Y=0;
    if FAFR > 20
        X=0.43;
	    Y=1;
    end
    return
end
if ALFA < 25
    Y=0;
	E=(0.68-0.57)/(25-20);
	E=0.57+E*(ALFA-20);
	if FAFR > E
        Y=(0.87-1)/(25-20);
	    Y=1.+Y*(ALFA-20);
	    X=(0.41-0.43)/(25-20);
        X=0.43+X*(ALFA-20);
    end
    return
end
%
if ALFA == 25
	 Y=0;
     if FAFR > 25
         X=0.41;
	     Y=0.87;
     end
     return
end
if ALFA < 30
    Y=0;
	E=(0.8-0.68)/(30-25);
	E=0.68+E*(ALFA-25);
	if FAFR > E
        Y=(0.76-0.87)/(30-25);
	    Y=0.87+Y*(ALFA-25);
	    X=(0.39-0.41)/(30-25);
        X=0.41+X*(ALFA-25);
    end
    return
end
%
if ALFA == 30
    Y=0;
    if FAFR > E30
        X=0.39;
	    Y=0.76;
    end
    return
end
if ALFA < 35
    Y=0;
	E=(0.95-0.8)/(35-30);
	E=0.8+E*(ALFA-30);
	if FAFR > E
        Y=(0.66-0.76)/(35-30);
	    Y=0.76+Y*(ALFA-30);
	    X=(0.37-0.39)/(35-30);
        X=0.39+X*(ALFA-30);
    end
    return
end
%
if ALFA == 35
    Y=0;
    if FAFR > E35
        X=0.37;
	    Y=0.66;
    end
    return
end
%
if ALFA < 40
    Y=0;
	E=(1.14-0.95)/(40-35);
	E=0.95+E*(ALFA-35);
	if FAFR > E
        Y=(0.57-0.66)/(40-35);
	    Y=0.66+Y*(ALFA-35);
	    X=(0.35-0.37)/(40-35);
        X=0.37+X*(ALFA-35);
    end
    return
end
if ALFA ==40
    Y=0;
    if FAFR > E40
        X=0.35;
	    Y=0.57;
    end
    return
end
if ALFA < 45
    Y=0;
	E=(1.34-1.14)/(45-40);
	E=1.14+E*(ALFA-40);
	if FAFR > E
        Y=(0.50-0.57)/(45-40);
	    Y=0.57+Y*(ALFA-40);
	    X=(0.33-0.35)/(45-40);
        X=0.35+X*(ALFA-40);
    end
    return
end
%
if ALFA == 45
    Y=0;
    if FAFR > E45
        X=0.33;
	    Y=0.5;
    end
end
end

