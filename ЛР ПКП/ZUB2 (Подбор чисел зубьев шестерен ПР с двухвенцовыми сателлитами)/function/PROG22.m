function [PPP] = PROG22(IRED)
global fid ZMCKZ ZMAX
%
fprintf(fid,'\n Расчет числа зубьев зубчатых колес планетарного ряда');
fprintf(fid,'\n        2-го класса с двухвенцовыми сателлитами');
fprintf(fid,'\n       '); 
fprintf('\n Расчет числа зубьев зубчатых колес планетарного ряда');
fprintf('\n        2-го класса с двухвенцовыми сателлитами');
fprintf('\n       ');
PPP=1;
%
fprintf('\n Минимальное число зубьев зубчатых колёс: %3i',ZMCKZ);
fprintf(fid,'\n Минимальное число зубьев зубчатых колёс: %3i',ZMCKZ);
fprintf('\n Максимальное число зубьев МЦК и сателлита МЦК: %3i',ZMAX);
fprintf(fid,'\n Максимальное число зубьев МЦК и сателлита МЦК: %3i',ZMAX);
% Максимальное число зубьев МЦК и сателлитов:
%
% Минимальное число сателлитов:
AST=3;
fprintf('\n Минимальное число сателлитов: %1i',AST);
fprintf('\n Конструктивный параметр: %g',IRED);
fprintf(fid,'\n Минимальное число сателлитов: %1i',AST);
fprintf(fid,'\n Конструктивный параметр: %g',IRED);
%
NV=0;
for AST=3:6
    for ZMCK=ZMCKZ:ZMAX
        for ZSTMCK=ZMCKZ:ZMAX
            AZ=IRED*ZMCK^2+IRED*ZMCK*ZSTMCK;
            BZ=IRED*ZMCK-ZSTMCK;
            ZBCK=AZ/BZ;
            if ZBCK > ZMAX, continue; end
            ZSTBCK=ZBCK-ZMCK-ZSTMCK;
            KZ=round(ZSTBCK);
            KONTROL=abs(ZSTBCK-KZ);
            if KONTROL ~= 0, continue; end
            if ZSTBCK < ZMCKZ, continue; end
            K=(ZBCK*ZSTMCK+ZMCK*ZSTBCK)/AST;
            KZ=round(K);
            KONTROL=abs(K-KZ);
            if KONTROL == 0
                PRED=ZBCK*ZSTMCK/(ZMCK*ZSTBCK);
                NV=NV+1;
fprintf(fid,'\n k= %6.3f A(CT)= %2i Z(МЦК)= %3i Z(CTМЦК)= %3i',PRED,AST,ZMCK,ZSTMCK); 
fprintf(fid,'\n Z(CTБЦК)= %3i Z(БЦК)= %3i ЦЕЛОЕ ЧИСЛО= %8.3f',ZSTBCK,ZBCK,K);
fprintf(fid,'\n------------------------------------------------------- ');
            end            
        end
    end
end
fprintf('\n  ');
fprintf('\n Найдено %i вариантов',NV);
fprintf('\n Решение окончено');
end


