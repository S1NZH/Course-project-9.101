function [QWE] = PRINT11(KNMCK,KNVOD,KMMCK)
global fid
QWE=0;
fprintf(fid,'\nКоэффициенты частоты вращения МЦК на передачах: \n%g %g %g %g %g %g %g %g %g %g %g',...
        KNMCK(1),KNMCK(2),KNMCK(3),KNMCK(4),KNMCK(5),KNMCK(6),KNMCK(7),KNMCK(8),KNMCK(9),KNMCK(10),KNMCK(11));
fprintf(fid,'\nКоэффициенты частоты вращения водила на передачах: \n%g %g %g %g %g %g %g %g %g %g %g',...
        KNVOD(1),KNVOD(2),KNVOD(3),KNVOD(4),KNVOD(5),KNVOD(6),KNVOD(7),KNVOD(8),KNVOD(9),KNVOD(10),KNVOD(11));
fprintf(fid,'\nКоэффициенты момента МЦК на передачах: \n%g %g %g %g %g %g %g %g %g %g %g',...
        KMMCK(1),KMMCK(2),KMMCK(3),KMMCK(4),KMMCK(5),KMMCK(6),KMMCK(7),KMMCK(8),KMMCK(9),KMMCK(10),KMMCK(11));
end

