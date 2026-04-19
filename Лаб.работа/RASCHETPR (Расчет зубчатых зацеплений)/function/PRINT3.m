function [QWE] = PRINT3(KNMCK,KNVOD,KMMCK)
global fid
QWE=0;
fprintf(fid,'\nКоэффициенты частоты вращения МЦК на передачах: \n%g %g %g',...
        KNMCK(1),KNMCK(2),KNMCK(3));
fprintf(fid,'\nКоэффициенты частоты вращения водила на передачах: \n%g %g %g',...
        KNVOD(1),KNVOD(2),KNVOD(3));
fprintf(fid,'\nКоэффициенты момента МЦК на передачах: \n%g %g %g',...
        KMMCK(1),KMMCK(2),KMMCK(3));
end

