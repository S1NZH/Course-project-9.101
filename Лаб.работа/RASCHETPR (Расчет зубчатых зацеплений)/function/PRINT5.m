function [QWE] = PRINT5(KNMCK,KNVOD,KMMCK)
global fid
QWE=0;
fprintf(fid,'\nКоэффициенты частоты вращения МЦК на передачах: \n%g %g %g %g %g',...
        KNMCK(1),KNMCK(2),KNMCK(3),KNMCK(4),KNMCK(5));
fprintf(fid,'\nКоэффициенты частоты вращения водила на передачах: \n%g %g %g %g %g',...
        KNVOD(1),KNVOD(2),KNVOD(3),KNVOD(4),KNVOD(5));
fprintf(fid,'\nКоэффициенты момента МЦК на передачах: \n%g %g %g %g %g',...
        KMMCK(1),KMMCK(2),KMMCK(3),KMMCK(4),KMMCK(5));
end

