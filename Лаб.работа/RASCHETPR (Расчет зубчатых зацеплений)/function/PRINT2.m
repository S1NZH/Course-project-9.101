function [QWE] = PRINT2(KNMCK,KNVOD,KMMCK)
global fid
QWE=0;
fprintf(fid,'\nКоэффициенты частоты вращения МЦК на передачах: \n%g %g',...
        KNMCK(1),KNMCK(2));
fprintf(fid,'\nКоэффициенты частоты вращения водила на передачах: \n%g %g',...
        KNVOD(1),KNVOD(2));
fprintf(fid,'\nКоэффициенты момента МЦК на передачах: \n%g %g',...
        KMMCK(1),KMMCK(2));
end

