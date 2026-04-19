function [QWE] = PRINT1(KNMCK,KNVOD,KMMCK)
global fid
QWE=0;
fprintf(fid,'\nКоэффициент частоты вращения МЦК на передачах: \n%g %g',KNMCK(1));
fprintf(fid,'\nКоэффициент частоты вращения водила на передачах: \n%g',KNVOD(1));
fprintf(fid,'\nКоэффициент момента МЦК на передачах: \n%g',KMMCK(1));
end

