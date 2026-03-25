function [NPRIZ] =  IDANNYE2
%
global TIP DW DPE LWE Z IR ALFA V fid WWW IDVIJ SMAX AST NDVSSR
global KNMCK KNVOD KR KA MST RVOD NPER TMAX IRASPRED DOLJA NDVSMAX
global MDVSMAX ADVS
%
NPRIZ=0;
fprintf (fid,'\n        ИСХОДНЫЕ ДАННЫЕ');
%      ТИП ПОДШИПНИКА
TIP=WWW(1); 
if TIP == 1, fprintf (fid,'\n Тип подшипника: шариковый радиальный или радиально-упорный'); end
if TIP == 2, fprintf (fid,'\n Тип подшипника: шариковый упорный или упорно-радиальный'); end
if TIP == 3, fprintf (fid,'\n Тип подшипника: роликовый радиальный или радиально-упорный'); end
if TIP == 4, fprintf (fid,'\n Тип подшипника: роликовый упорный или упорно-радиальный'); end
%      ДИАМЕТР ТЕЛ КАЧЕНИЯ
DW=WWW(2); 
fprintf (fid,'\n Диаметр тел качения - %i, мм',DW);
%      ДИАМЕТР ОКРУЖНОСТИ ЦЕНТРОВ ТЕЛ КАЧЕНИЯ
DPE=WWW(3);
fprintf (fid,'\n Диаметр окружности центров тел качения - %g, мм',DPE);
%      ДЛИНА РОЛИКОВ
LWE=WWW(4);
fprintf (fid,'\n Длина роликов - %g, мм',LWE);
%      ЧИСЛО ТЕЛ КАЧЕНИЯ В ОДНОМ РЯДУ ПОДШИПНИКА
Z=WWW(5);
fprintf (fid,'\n Число тел качения в одном ряду подшипника - %i',Z);
%	Z=3.14*DPE/DW
%	PRINT *,'Z=',Z
%      ЧИСЛО РЯДОВ ТЕЛ КАЧЕНИЯ В ПОДШИПНИКЕ
IR=WWW(6);
fprintf (fid,'\n Число рядов тел качения - %i',IR);
%      НОМИНАЛЬНЫЙ УГОЛ КОНТАКТА ПОДШИПНИКА
ALFA=WWW(7);
fprintf (fid,'\n Номинальный угол контакта подшипника - %i, град.',ALFA);
% ПРИЗНАК, КАКОЕ КОЛЬЦО ПОДШИПНИКА ВРАЩАЕТСЯ
KK=WWW(8);
if KK == 1,	fprintf (fid,'\n Вращается внутреннеее кольцо подшипника'); end
if KK == 2,	fprintf (fid,'\n Вращается внешнее кольцо подшипника'); end
V=1;
if KK == 2, V=1.2; end
%      КОЛИЧЕСТВО ПЕРЕДАЧ В КПП
NPER=WWW(9); 
fprintf (fid,'\n Количество передач в КПП - %i',NPER);
%      МАКСИМАЛЬНЫЙ МОМЕНТ ДВИГАТЕЛЯ
MDVSMAX=WWW(10); 
fprintf (fid,'\n Максимальный момент на ведущем валу КПП - %g, Нм',MDVSMAX);
%      Максимальная частота вращения ведущего вала КПП
NDVSMAX=3.14*WWW(11)/30; 
fprintf (fid,'\n Максимальная частота вращения ведущего вала КПП - %g, об/мин',NDVSMAX);
%      Коэффициент использования момента двигателя 
ADVS=WWW(12); 
fprintf (fid,'\n Коэффициент использования момента двигателя - %g',ADVS);
%      Средняя частота вращения двигателя 
NDVSSR=3.14*WWW(13)/30;
fprintf (fid,'\n Средняя частота вращения двигателя - %g, об/мин',NDVSSR);
%      Пробег до капитального ремонта 
SMAX=WWW(14); 
fprintf (fid,'\n Пробег до капитального ремонта - %g, км',SMAX);
%      Средняя скорость 
VSR=WWW(15); 
fprintf (fid,'\n Средняя скорость - %g, км/ч',VSR);
%      Обороты сателлитов на передачах
fprintf (fid,'\n Угловая скорость подшипника на передачах:');
for I=1:NPER
    KNMCK(I)=WWW(I+15); 
    fprintf (fid,'\n %i - %g',I,KNMCK(I));
end
%     Обороты водила на передачах
NNN=15+NPER;
%fprintf (fid,'\n Относительная угловая скорость водила на передачах:');
%for I=1:NPER
%    KNVOD(I)=WWW(NNN+I); 
%    fprintf (fid,'\n %i - %g',I,KNVOD(I));
%end
%NNN=NNN+NPER;
%      Масса сателлита, кг 
%MST=WWW(NNN+1);
%fprintf (fid,'\n Масса сателлита - %g, кг',MST);
%      РАДИУС ЦЕНТРОВ ОСЕЙ САТЕЛЛИТОВ
%RVOD=WWW(NNN+2);
%fprintf (fid,'\n Радиус осей сателлитов - %g, мм',RVOD);
%RVOD=RVOD/1000;
%NNN=NNN+2;
%      Радиальная нагрузка на подшипник по передачам
fprintf (fid,'\n Радиальная нагрузка на подшипник по передачам');
for I=1:NPER
     KR(I)= WWW(NNN+I);
     fprintf (fid,'\n %i - %g',I,KR(I));
end
NNN=NNN+NPER;
%       Относительная осевая нагрузка на подшипник по передачам
fprintf (fid,'\n Осевая нагрузка на подшипник по передачам:');
for I=1:NPER
     KA(I)= WWW(NNN+I);     
     fprintf (fid,'\n %i - %g',I,KA(I));
end
NNN=NNN+NPER;
%      ТИП ДВИЖИТЕЛЯ
IDVIJ=WWW(NNN+1);
if IDVIJ == 1, fprintf (fid,'\n Тип движителя: колесный'); end
if IDVIJ == 2, fprintf (fid,'\n Тип движителя: гусеничный'); end
TMAX=SMAX/VSR;
%  Число сателлитов планетарного ряда
%AST=WWW(NNN+2);
% Какая гистограмма распределения времени работы по передачам используется
% 0 - заданная в программе; 1 - оригинальная
IRASPRED=WWW(NNN+2);
fprintf (fid,'\n IRASPRED= %i',IRASPRED);
if IRASPRED == 0
    if IDVIJ == 1
        if NPER > 11
            fprintf('\n Статистика по распределению времени работы на передачах для колесных машин'); 
            fprintf('\n имеется только для КП, реализующих не более 11 передач переднего хода');
            return
        end
    end
    if IDVIJ == 2
        if NPER > 8
            fprintf('\n Статистика по распределению времени работы на передачах для гусеничных машин'); 
            fprintf('\n имеется только для КП, реализующих не более 8 передач переднего хода');
            return
        end
    end
end
if IRASPRED ~= 0
    NPRIZ=1;
    K=0;
    for I=NNN+3:NNN+2+NPER
        K=K+1;
        DOLJA(K)=WWW(I);
    end        
end
end

