function [F0,NTR] = F05(A)
%     
global ALFA
%
NEQ=0; NYR=0;
F50 = [109.7,127.8,139.5,148.3,155.2,160.9,165.6,169.5,172.8,...
            174.5,177.8,179.7,181.1,182.3,183.1,183.7,184.0,184.1,...
            184.0,183.7,183.2,182.6,181.8,180.9,179.8,178.7];
F65 = [107.1,124.7,136.2,144.7,151.5,157.0,161.6,165.5,168.7,...
            171.4,173.6,175.4,176.8,177.9,178.8,179.3,179.6,179.7,179.6,179.3];
F80 = [105.6,123.0,134.3,142.8,149.4,154.9,159.4,163.2,166.4,...
            169.0,171.2,173.0,174.4,175.5,176.3];
F90 = [105.4,122.9,134.5,143.4,150.7,156.9,162.4,167.2,171.7,...
            175.7,179.5,183.0,186.3,189.4,192.3,195.1,197.7,200.3,...
            207.7,205.0,207.2,209.4,211.5,213.5,215.4,217.3,219.1,219.1,222.7,224.3];  
%
if NEQ == 0
    OTN(1)=0.01;
    for I=2:30
        OTN(I)=OTN(I-1)+0.01;
    end
       NEQ=1;
end
%
if ALFA < 65
    for I=2:20
        if A <= OTN(I), continue; end
        YN=(F50(I)-F50(I-1))/(OTN(I)-OTN(I-1));
	    YN=F50(I-1)+YN*(A-OTN(I-1));
	    YV=(F65(I)-F65(I-1))/(OTN(I)-OTN(I-1));
  	    YV=F65(I-1)+YV*(A-OTN(I-1));
        F0=(YV-YN)/(65-50);
	    F0=YN+F0*(ALFA-50);
        return
    end
    fprintf ('\n НЕПРАВИЛЬНО ЗАДАНЫ Dw И Dpe');
    fprintf ('\n ОТНОШЕНИЕ Dw*cos(ALFA)/Dpw не должно превышать 0,26;')
    fprintf ('\n Dw*cos(ALFA)/Dpw= %g',A);
    NTR=1;
    return
end
%
if ALFA <= 80
    for I=2:15
        if A > OTN(I), continue; end
	    YN=(F65(I)-F65(I-1))/(OTN(I)-OTN(I-1));
	    YN=F65(I-1)+YN*(A-OTN(I-1));
	    YV=(F80(I)-F80(I-1))/(OTN(I)-OTN(I-1));
  	    YV=F80(I-1)+YV*(A-OTN(I-1));
        F0=(YV-YN)/(80-65);
	    F0=YN+F0*(ALFA-65);
        return
    end
    fprintf ('\n НЕПРАВИЛЬНО ЗАДАНЫ Dw И Dpe');
    fprintf ('\n ОТНОШЕНИЕ Dw*cos(ALFA)/Dpw не должно превышать 0,2;')
    fprintf ('\n Dw*cos(ALFA)/Dpw= %g',A);
    NTR=1;
    return
end
%
if ALFA <= 90
    for I=2:15
        if A > OTN(I), continue; end
	    YN=(F80(I)-F80(I-1))/(OTN(I)-OTN(I-1));
	    YN=F80(I-1)+YN*(A-OTN(I-1));
	    YV=(F90(I)-F90(I-1))/(OTN(I)-OTN(I-1));
  	    YV=F90(I-1)+YV*(A-OTN(I-1));
        F0=(YV-YN)/(90-80);
	    F0=YN+F0*(ALFA-80);
     return
    end
    fprintf ('\n НЕПРАВИЛЬНО ЗАДАНЫ Dw И Dpe');
    fprintf ('\n ОТНОШЕНИЕ Dw*cos(ALFA)/Dpw не должно превышать 0,15;')
    fprintf ('\n Dw*cos(ALFA)/Dpw= %g',A);
    NTR=1;
    return
end
end

