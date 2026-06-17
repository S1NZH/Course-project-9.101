clc;
clear;

%% Исходные данные

g = 9.81; % Ускорение свободного падения, м/с^2
m = 10000; %Масса машины, кг
v_max_km = 80; % Минимальная скорость движения машины, км/ч
v_max = v_max_km/3.6; %Макс скорость машины, м/с   
F_lob = 4.26; %Площадь лобового, м^2
alpha_max = deg2rad(30); %Максимальный угол подъема, град -> рад
r_ved = 0.350; %Радиус ведущего колеса, м
L = 3000; %Ресурс, ч
f_min = 0.019; %Мин. коэффициент сопротивления движению
f_max = 0.04; %Мин. коэффициент сопротивления движению
fi = 0.85; % Коэффициент сцепления с дорогой
%Разбиение на передачи производится по геометрическому закону

%% Хар-ки двигателя КамАЗ 740.51-320

n = 1000:100:2200; % Частота вращения, об/мин
M_ef = [1180 1209.6 1230 1243.6 1250 1243.6 1230 1208.6 1180 1149.8 1116.8 1079.9 1040]; % Эффективный момент, Н*м
N_ef = [123.57 139.33 154.57 169.29 183.26 195.34 206.09 215.16 222.42 228.78 233.84 237.49 239.6]; % Эффекстивная мощность, Вт
dvig = [n; M_ef; N_ef]; % Просто так

n_nom = max (n); % Номинальная частота оборотов двигателя, об/мин
n_m = n(M_ef == max(M_ef)); % Частота вращения двигателя при максимальном моменте, об/мин
M_e_max = max(M_ef); % Максимальный момент двигателя, Н*м
M_e_nom = M_ef(n == max(n)); % Момент при номинальных оборотах двигателя, Н*м

%% Определения максимальной мощности двигателя

alpha_min = deg2rad(1); % Продольный уклон дороги дороги, град -> рад
c_x = 0.9; % Коэффициент полной аэродинамической силы5
ro_v = 1.225; % Плотность воздуха, кг/м^3
eta_k = 0.96; % КПД конической передачи
eta_c = 0.97; % КПД цилиндрической передачи
eta_p = 0.96; % КПД планетарной одноступенчатой передачи
k_w = 0.5*c_x*ro_v; % коэффициент обтекаемости (среднее значение по В.Н.Наумову)

G = m*g; % вес, Н
f_0 = f_min*cos(alpha_min)+sin(alpha_min); % Суммарный коэф. сопротивления движению
P_v = k_w*F_lob*v_max^2; % Сила воздушного сопротивления, Н
P_dv = f_0*G+P_v; % Потребная сила тяги, Н
eta_tr = eta_k*eta_c^2*eta_p; % КПД трансмисии     ПОСМОТРЕТЬ НА РЕАЛЬНЫХ ПРИМЕРАХ
eta_gd = 0.919-0.01386*v_max; % КПД гусенечного движителя (для резинометалического шарнира)
eta_0 = eta_tr*eta_gd; % КПД машины 
% eta_0 = 0.9;
N_sv = (P_dv*v_max)/eta_0; % Максимальная свободная мощность двигателя, Вт


%N_emax = N_sv+N_p;
%N_p = N_v+N_vyh+N_vo; % Суммарные потери в энергетической установке, Вт
%N_v = 0,1*N_emax;
%N_vyh = 0,03*N_emax;
%N_vo = 0,02*N_emax;
%N_emax = N_sv+0,1*N_emax+0,03*N_emax+0,02*N_emax;
%N_emax = N_sv+0,15*N_emax;
%0,85*N_emax = N_sv
N_emax = N_sv/0.85; % Номинальная эффективная мощность, Вт
% проверили, что мощности хватает, и теперь опять смотрим на параметры
% двигателя
N_sv_sv = N_ef*0.85; % Свободное то, что оталось у двигатель после того, как забрали 15% на потери кВт
M_sv = 9549*N_sv_sv./n; % Свободный момент, Н*м


%% Определния минимальной скорости и кинематического диапазона трансмиссии

eta_gd_min = 0.919; % КПД гусеницы при минимальной скорости движения
eta_0_min = eta_tr*eta_gd_min; % Общий КПД машины при минимальной скорости движения
f_0_max = f_max*cos(alpha_max)+sin(alpha_max); % Максимальный общий коэффициент сопротивления движению
P_max = f_0_max*G; % Максимальная потребная сила тяги, Н
v_min = (N_sv*eta_0_min)/P_max; % Минимальная скорость движения машины, м/с 
v_min_km = v_min*3.6; % Минимальная скорость движения машины, км/ч
d = v_max/v_min; % Кинематический диапозон трансмисии                        
P_fi_max = fi*G*cos(alpha_max); % Максимальная сила тяги по сцеплению, Н
if (P_max>P_fi_max)
    disp ('Максимальная сила тяги превышает ограничение по сцеплению'); % максимальная сила тяги ограничивается сцеплением с дорогой
end

%% Построение характеристики двигателя КамАЗ 740.51-320

xlabel('Обороты в минуту')
ylabel('Крутящий момент, Н*м')
xlabel('Обороты в минуту')
ylabel('Мощность, Вт')
plot(n, N_ef, n, N_sv)

%% Выбор и разбивка промежуточных передач ступенчатой КПП

k_min = log10(d)/log10(n_nom/n_m); % Минимальное число передач (-1 на заднюю передачу)
k = ceil(k_min); % Число передач
q = nthroot(d, k-1); % Знаменатель геом. прогрессии
for j = 1:k
    v(j) = v_min*q^(j-1); % Скорости на i-ой передаче, м/с
end
v_km = v.*3.6;% Скорости на i-ой передаче, км/ч

i_0 = zeros(1,k);
i_0(k) = (3.6*r_ved*pi*n_nom)/(v_max_km*30);
for j = 1:length(i_0)-1
    i_0(k-j) = i_0(k+1-j)*q;
end

STRAIGHT = 3; % Номер прямой передачи
i_mp = 1; %
i_bp = i_0(STRAIGHT)/i_mp;
i_tm = i_bp*i_mp;
I = i_0/i_tm;


% Передаточные числа на передачах + подбор передаточных чисел

for j = 1:k
    i(j) = I(j)*i_tm;
end

% Скорости по передачам в зависимости от оборотов + КПД на разных скоростях
% + Сила сопротивления воздуха на разных скоростях + Сила сопротивления
% + Воздуха на разных скоростях
%  + Сила тяги по двигателю по передачам  + Динамические факторы по скоростям

for j = 1:k                                % _v - вектор     j - число передач    l - значение
    for l = 1:length(n)
    %v_v(j,l) = 0.337*r_ved.*n(l)/i(j)/3.6;
    v_v(j,l) = pi*r_ved.*n(l)/(30*i(j));
    v_km_v(j,l) = v_v(j,l)*3.6;
    eta_gd_v(j,l) = 0.919-0.01386.*v_v(j,l);
    eta_0_v(j,l) = eta_tr.*eta_gd_v(j,l);
    P_v_v(j,l) = k_w*F_lob.*v_v(j,l).^2;
    P_dv_v(j,l) = (M_sv(l)*i(j).*eta_0_v(j,l))/r_ved;
    D_v(j,l) = (P_dv_v(j,l)-P_v_v(j,l))/G;
    end
end

%plot (D_v(1,:));

for j = 1:k
    plot(v_km_v(j,:), D_v(j,:))
    hold on
end
grid on;
%legend('show');
xlabel ('Скорость, км/ч');
ylabel ('Динамический фактор')


%% Расчёт межосевого расстояния

K = 6.5; % H = 56..63 HRC HRCср =  60
M_max_vh = max(M_sv)
n_max_vh = max(n)
I_vh = 2; % Входной
M_max = M_max_vh*I_vh; % Момент максимальный на первой передаче
n_max = n_max_vh/I_vh;
a1w = K*(I(1)+1)*nthroot(M_max/I(1),3); % Предварительное межосевое расстояние, мм
for cyc = 1:k
    v_okr(cyc) = (2*pi*a1w*n_max)/(6*10^4*(I(cyc)+1)); % Окружная скорость на пятой передаче, м/с
end
psi_ba = 0.20; % Коэффициент ширины
N_HG = 30*611^(2.4); % Число циклов
if N_HG > 12*10^7
    N_HG = 12*10^7;
end
n_z = 1; %кол-во вхождений в зацепление
N_k = 60*n_max*n_z*3000*0.4; % Ресурс в циклах
Z_N = nthroot((N_HG/N_k),6); % Коэффициент долговечности
Z_V = 0.925*v_okr(1)^(0.05); % Коэффициент влияния окружной скорости
Z_R = 1; % Коэффициент влияния шероховатости
sigma_Hlim = 23*60;
S_H = 1.2; % Поверхность упрочнена
sigma_H = sigma_Hlim*Z_N*Z_R*Z_V/S_H;
K_Hv = 1.04 % Коэффициент внутренней динамики нагружения (степень точности 6)
psi_bd = 0.5*psi_ba*(I(1)+1);
K_0Hb = 1.28;
K_0Ha = 1
K_Hw = 1;
K_Ha = 1+(K_0Ha-1)*K_Hw
K_Hb = 1+(K_0Hb-1)*K_Hw
K_H = K_Hv*K_Hb*K_Ha; % Коэффициент нагрузки в расчётах на контактную точность
K_a = 450;
a_w = K_a*(I(1)+1)*nthroot((K_H*M_max)/(psi_ba*I(1)*sigma_H^2), 3); % Уточненное межосевое, мм
a_w = floor(a_w/10)*10+10

%% Расчёт модуля колес
%for cyc = 1:k
    %d2(cyc) = (2*a_w*I(cyc))/(I(cyc)+1) % ?
%end
b2 = psi_ba*a_w; % Ширина колеса, мм
b2 = 60; % Из ряда стандартных значений
b1 = b2+5
K_m = 3.4*10^3; % Для прямозубых
K_Fv = 1.10; % Коэффициент внутренней динамики нагружения (степень точности 6)
K_Fb = 0.18+0.82*K_0Hb
K_Fa = K_0Ha;
K_F = K_Fv*K_Fb*K_Fa; % Коэффициент нагрузки по напряжениям изгиба
sigma_Flim = 800; % Предел выносливости МПА
q = 9;
N_FG = 4*10^6
if N_k > N_FG
    N_k = N_FG;
end
Y_N = nthroot(N_FG/N_k, q);
Y_R = 1.2; % ?
Y_A = 0.75; 
S_F = 1.55;
sigma_F = sigma_Flim*Y_N*Y_R*Y_A/S_F
mod_max = (2*a_w)/(17*(I(1)+1)); % Максимальное значение модуля передачи;
mod_min = (K_m*K_F*M_max*(I(1)+1))/(a_w*b2*(sigma_F)) % Минимальное значение модуля
MOD_VALUE = [mod_min mod_max]
mod = 5; % Стандартное значение из 1-го ряда


z_s = floor((2*a_w)/mod); % Суммарное число зубьев
for cyc = 1:k
    z(1,cyc) = floor(z_s/(I(cyc)+1)); % Предварительное число зубьев шестерни на cyc-й передаче
    z(2,cyc) = z_s-z(1,cyc); % Предварительное число зубьев колеса на cyc-й передаче
    U(cyc) = z(2,cyc)/z(1,cyc); % Фактическое передаточное число
    delta(cyc) = abs((I(cyc)-U(cyc))/I(cyc))*100;
end
z(1,6) = z(1,1);
z(2,6) = z(2,1);
U(6) = U(1);
I(6) = I(1);
delta(6) = delta(1);
PEREDAT = [1:1:6;I;U;delta]; % для визуального сравнения передаточных чисел
ZUB = z

%% Расчёт основных размеров зубчатых колес
x=0 % Коэффицент смещения инструмента
for CYC = 1:2
    for cyc = 1:k+1
        d_k_d(CYC,cyc) = z(CYC,cyc)*mod; % Делительный диаметр шестерни(1,cyc) и колеса(2,cyc)    
        a(cyc) = ceil((0.5*mod*(z(2,cyc)+z(1,cyc)))/10)*10; % Делительное межосевое
        y(cyc) = -(a_w-a(cyc))/mod
        d_k_a(CYC,cyc) = d_k_d(CYC,cyc)+2*(1+x-y(cyc))*mod % Диаметр окружности вершин зубьев шестерни(1,cyc) и колеса(2,cyc) 
        d_k_f(CYC,cyc) = d_k_d(CYC,cyc)-2*(1.25-x)*mod % Диаметр окружностей впадин шестерни(1,cyc) и колеса(2,cyc)
    end
end

% Проверка кружной скорости на пятой и первой передачах, м/с
for cyc = 1:k
    v_okr(2,cyc) = pi*d_k_f(1,cyc)*(n_max/(6*10^4));
end 
%% Проверка зубьев по напряжениям

% По контактным напряжениям
minkol = 20
for cyc = 1:k+1      %ЭТО СТРАННО
        b2(cyc) = ceil((9600^2*K_H*M_max*(U(cyc)+1)^3)/(((sigma_Hlim/1.2)*a_w)^2*U(cyc)));
        if b2(cyc) < minkol
            b2(cyc) = minkol;
        end
        b1(cyc) = b2(cyc)+5;
end

B12 = [b1;b2]
KOLESA = [1:1:cyc; z; 1:1:cyc; d_k_d(1,:); d_k_a(1,:); d_k_f(1,:);1:1:cyc ; d_k_d(2,:); d_k_a(2,:); d_k_f(2,:); 1:1:cyc; B12; 1:1:cyc; (d_k_d(1,:)+d_k_d(2,:))/2]; % таблица параметров

% Силы в зацеплении

for cyc = 1:k
    Ft1(cyc) = 2*10^3*(M_max/d_k_d(1,cyc)); % Окружная сила
    Ft2(cyc) = 2*10^3*(M_max/d_k_d(2,cyc)); 
    Fr1(cyc) = Ft1(cyc)*0.364; % Радиальная сила
    Fr2(cyc) = Ft2(cyc)*0.364;
end
FORCE = [Ft1; Ft2; Fr1; Fr2]

% По изгибным напряжениям


Y_beta = 1;
Y_epsilon = 0.8;
Y_FS = [4.16 3.79 3.67 3.62 3.6;
        3.59 3.59 3.6  3.62 3.67]
for cyc = 1:k
    sigma_F2(cyc) = ((K_F*Ft2(cyc)*Y_FS(2,cyc)*Y_beta*Y_epsilon)/(b2(cyc)*mod)); % Для колеса
    sigma_F1(cyc) = sigma_F2(cyc)*(Y_FS(1,cyc)/Y_FS(2,cyc)); % Для шестерни
end

%% Расчет валов

Tb = M_max; % Максимальный момент на быстроходном валу
Tt = M_max*U(1); % Максимальный момент на тихоходном валу
d_valb = ceil(6*nthroot(Tb, 3))+2; % Диаметр вала по Ра40
d_valt = ceil(5*nthroot(Tt, 3))+8; % Диаметр вала по Ра40


zAz_kol = 25; %Зазор между колесами
zAz_sin = 125; %Зазор на синхронизатор/муфту
zAz_op = 85; % Зазор на опору
b1(1) = ceil(0.1*(b2(1)+b2(6)+zAz_sin)*2/3)/0.1
b1(6) = b1(1)
KOLESA(13,1) = b1(1)
KOLESA(13,6) = b1(6)
lvalb = zAz_sin+zAz_kol+b2(4)+zAz_sin+b2(5)+zAz_kol+zAz_op+zAz_kol+b2(1)+zAz_sin+b2(6)+zAz_sin+b2(2)+zAz_sin+b2(3)+zAz_kol+zAz_sin;

% Входной валик

z2vh = floor(z(1,4)/I_vh); % Число зубьев зубчатого колеса 4-й передачи с которой сопряжен валик 
a_vh= ((0.5*mod*(z(1,4)+z2vh))/10)*10; % Делительное межосевое
d_k_dvh = (z2vh*mod/10)*10; % Делительный диаметр шестерни
d_k_avh = d_k_dvh+2*(1+x-y(4))*mod % Диаметр окружности вершин зубьев шестерни
d_k_fvh = d_k_dvh-2*(1.25-x)*mod % Диаметр окружностей впадин шестерни
b1vh = b1(4)+5;
a_vhcheck = (d_k_d(1,4)+d_k_dvh)/2
A_VH = [a_vh a_vhcheck]
Tvh = M_max_vh; % Максимальный момент на входном валу
d_val_vh = ceil(6*nthroot(Tvh, 3))+1; % Диаметр вала по Ра40

KOL_VH = [z2vh z(1,4); A_VH; d_k_dvh d_k_avh; d_k_fvh b1vh]




a_l1 = zAz_kol+b2(4)+zAz_sin+b2(5)+135+b2(1)/2;
a_l2 = zAz_kol+b2(4)+zAz_sin+b2(5)+135+b2(1)+zAz_sin+b2(6)+zAz_kol+b2(2)/2;
a_l3 = zAz_kol+b2(4)+zAz_sin+b2(5)+135+b2(1)+zAz_sin+b2(6)+zAz_kol+b2(2)+zAz_sin+b2(3)/2;
a_l5 = zAz_kol+b2(4)/2;
a_l4 = zAz_kol+b2(4)+zAz_sin+b2(5)/2
a_l6(2) = zAz_kol+b2(4)+zAz_sin+b2(5)+135+b2(1)+zAz_sin+b2(6)/2;
a_l6(1) = zAz_kol+b2(4)+zAz_sin+b2(5)+135+(b2(1)+zAz_sin+b2(6))/2
       

l_val = zAz_kol+b2(4)+zAz_sin+b2(5)+zAz_kol+zAz_op+zAz_kol+b2(1)+zAz_sin+b2(6)+zAz_sin+b2(2)+zAz_sin+b2(3)+zAz_kol; % От опоры до опоры, мм
% l_val = l_val/1000;% м
l1 = a_l4+b2(5)/2+135/2; % 4 и 5 передачи, мм
% l1 = l1/1000; % м
l2 = l_val-l1; % 1, 2, 3 и задняя передачи, мм


 
a_l = [l_val-a_l1 l_val-a_l2 l_val-a_l3 l_val-a_l4 l_val-a_l5 l_val-a_l6(1);
       l_val-a_l1 l_val-a_l2 l_val-a_l3 l_val-a_l4 l_val-a_l5 l_val-a_l6(2)]% мм

a_l = a_l./1000
l1 = l1/1000; % м
l_val = l_val/1000;% м
l2 = l2/1000; % м

for CYC = 1:2 % 1-шестерня 2-зубчатое клесо
    for cyc = 1:k+1 % передачи
        F_t(1,cyc) = (2*10^3*Tb)/d_k_d(1,cyc);
        F_t(2,cyc) = (2*10^3*Tb*U(cyc))/d_k_d(2,cyc);
        F_r(CYC,cyc) = F_t(CYC,cyc)*0.364;
        P(CYC,cyc) = sqrt(F_t(CYC,cyc)^2+F_r(CYC,cyc)^2);
        C(CYC,cyc) = (P(CYC,cyc)*a_l(CYC, cyc)*(l_val^2-a_l(CYC, cyc)^2-l1^2))/(2*l1*l2^2);
        B(CYC,cyc) = (P(CYC,cyc)*(l_val-a_l(CYC,cyc))-C(CYC,cyc)*l1)/l_val;
        A(CYC,cyc) = (C(CYC,cyc)*l2-P(CYC,cyc)*(a_l(CYC,cyc)))/l_val;
    end
end

l_val_vh = l1
a_l_vh = l_val_vh-a_l4*10^-3
F_z_vh = (2*10^3*Tvh)/d_k_dvh;
F_r_vh = F_z_vh*0.364;
P_vh = sqrt(F_z_vh^2+F_r_vh^2);
A_vh = (P_vh*(l_val_vh-a_l_vh))/l_val_vh
B_vh = 0;
C_vh = (P_vh*(a_l_vh))/l_val_vh


VALEK1 = [1:1:cyc; F_t(1,:); F_r(1,:); P(1,:); a_l(1,:); zeros(1,cyc); A(1,:); C(1,:); B(1,:)];
VALEK2 = [1:1:cyc; F_t(2,:); F_r(2,:); P(2,:); a_l(2,:); zeros(1,cyc); A(2,:); C(2,:); B(2,:)]
VALEKVH =[F_z_vh; F_r_vh; P_vh; 0; A_vh; C_vh]

M_izg_vh = A_vh*(a_l_vh)
for CYC=1:2
        % M_izgP(CYC,6) = A(CYC,6)*(l_val-a_l(CYC, 6));
        % M_izgC(CYC,6) = A(CYC,6)*l1-P(CYC,6)*(a_l(CYC, 6)-l2);
    for cyc = 4:k
        M_izgP(CYC,cyc) = A(CYC,cyc)*(l_val-a_l(CYC, cyc))-C(CYC,cyc)*(l2-a_l(CYC, cyc));
        M_izgC(CYC,cyc) = A(CYC,cyc)*l1;
    end
    for cyc = [1:3 6]
        M_izgP(CYC,cyc) = A(CYC,cyc)*(l_val-a_l(CYC,cyc));
        M_izgC(CYC,cyc) = A(CYC,cyc)*l1-P(CYC,cyc)*(a_l(CYC,cyc)-l2);
    end
end

M_izg1 = abs([M_izgP(1,:) ; zeros(1,cyc); M_izgC(1,:)])
M_izg2 = abs([M_izgP(2,:) ; zeros(1,cyc); M_izgC(2,:)])
M_izg_max1 = max(M_izg1,[],"all")
M_izg_max2 = max(M_izg2,[],"all")
sigma_sm = 392*10^6; % МПА
E = 2*10^5; % Модуль упругости, МПА

%d_valb = ceil(((10^3)*nthroot(sqrt(Tb^2+M_izg_max1^2)/(0.1*sigma_sm),3))/10)*10-2; % Для Шлицов
%d_valt = ceil((10^3)*nthroot(sqrt(Tt^2+M_izg_max2^2)/(0.1*sigma_sm),3)/10)*10-2; % 

d_valvh = ceil((10^3)*nthroot(sqrt(Tvh^2+M_izg_vh^2)/(0.1*sigma_sm),3)/10)*10+6 % Для Шлицов
d_valb = ceil((10^3)*nthroot(sqrt(Tb^2+M_izg_max1^2)/(0.1*sigma_sm),3))+4 % Для Шлицов
d_valt = floor((10^3)*nthroot(sqrt(Tt^2+M_izg_max2^2)/(0.1*sigma_sm),3)/10)*10-2; % 



DIAM_VALEK = [d_valvh d_valb  d_valt]

d_valvh_check = nthroot((32*Tvh*l_val_vh)/(10^6*pi*2*E),4)
d_valb_check = nthroot((32*Tb*l_val)/(10^6*pi*2*E),4)
d_valt_check = nthroot((32*Tt*l_val)/(10^6*pi*2*E),4)

DIAM_VALEK_CHECK = [d_valvh_check d_valb_check d_valt_check]*1000

DIAM_VALEK_COMPARE = [DIAM_VALEK; DIAM_VALEK_CHECK]

% Паразиты
P_par = P(1,6)
gamma = 74
F_par = sqrt(2*P_par^2*(1-cosd(180-gamma)))
a_par = 0.190
R_par = F_par/2
y_par = 1e-6
J_par = (R_par*a_par^3)/(3*E*1e6*y_par)
d_par = ceil((1e3)*nthroot(sqrt(M_izg_max1^2)/(0.1*sigma_sm),3))


%% Расчёт подшипников (Носов)
ny(1) = n_max;
ny(2) = n_max/U(5)
ny(3) = n_max_vh

nn1 = (n_max)./(ny(1))
nn2 = (n_max./U)./(ny(2))

alfa = [0.05 0.10 0.20 0.35 0.30 0.05]; % коэффициенты брались как для 6-ступенчатой коробки, где 6-я передача - задняя
Q_ekvA(1) = nthroot((sum(alfa.*nn1.*abs(A(1,:)).^3.33)),3.33);
Q_ekvA(2) = nthroot((sum(alfa.*nn2.*abs(A(2,:)).^3.33)),3.33);
Q_ekvA(3) = nthroot((sum(alfa(4).*abs(A_vh).^3.33)),3.33);

Q_ekvB(1) = nthroot((sum(alfa.*nn1.*abs(B(1,:)).^3.33)),3.33);
Q_ekvB(2) = nthroot((sum(alfa.*nn2.*abs(B(2,:)).^3.33)),3.33);
Q_ekvB(3) = nthroot((sum(alfa(4).*abs(B_vh).^3.33)),3.33);

Q_ekvC(1) = nthroot((sum(alfa.*nn1.*abs(C(1,:)).^3.33)),3.33);
Q_ekvC(2) = nthroot((sum(alfa.*nn2.*abs(C(2,:)).^3.33)),3.33);
Q_ekvC(3) = nthroot((sum(alfa(4).*abs(C_vh).^3.33)),3.33);

Q_ekv = [Q_ekvA' Q_ekvC' Q_ekvB']


Kb = 1.5;
Kt = 1;
for CYC = 1:3
    C_Q(CYC,:) = floor((0.1*Q_ekv(CYC,:))*((ny(CYC)*L)^0.3)*Kb*Kt);
end
F_ig = 1.5*P(2,:);
F_ig_par = 1.5*P_par;
%% Расчёт подшипников (Леликов)
% V = 1
% X = 1
% Y = 0
% R_a = 1
% Kb = 1.65;
% Kt = 1;
% a1 = 1
% a23_roll = 0.75
% a23_ball = 0.55
% k_roll = 10/3
% k_ball = 3
% for CYC=1:2
%     Pr_A(CYC) = (V*X*max(abs(A(CYC,:)))+Y*R_a)*Kb*Kt
%     Pr_B(CYC) = (V*X*max(abs(B(CYC,:)))+Y*R_a)*Kb*Kt
%     Pr_C(CYC) = (V*X*max(abs(C(CYC,:)))+Y*R_a)*Kb*Kt
% end
% Pr_A = Pr_A'
% Pr_A(3,1) = (V*X*abs(A_vh)+Y*R_a)*Kb*Kt
% Pr_B = Pr_B'
% Pr_B(3,1) = (V*X*abs(C_vh)+Y*R_a)*Kb*Kt
% Pr_C = Pr_C'
% Pr_C(3,1) = 0
% 
% for CYC=1:2
%     C_rA(CYC) = nthroot((L*60*ny(CYC))/(10^6*a1*a23_roll),k_roll)*Pr_A(CYC)
%     C_rB(CYC) = nthroot((L*60*ny(CYC))/(10^6*a1*a23_roll),k_roll)*Pr_B(CYC)
%     C_rC(CYC) = nthroot((L*60*ny(CYC))/(10^6*a1*a23_roll),k_roll)*Pr_C(CYC)
% end
% C_r = [C_rA' C_rB' C_rC']

%% Расчет шлицевых соединений 
% Промежуточный вал (1) (10 х 62 х 68  ГОСТ 1139-80)
l_sh123r = (lvalb-l_val*1000)/2+(l_val*1000 - (zAz_op+zAz_kol+b2(5)+zAz_sin+b2(4)+15))
l_sh45 = (lvalb-l_val*1000)/2+(l_val*1000 - (zAz_op+zAz_kol+b2(1)+zAz_sin+b2(6)+zAz_kol+b2(2)+zAz_sin+b2(3)+15))

lambda = 0.75
d_n1 = d_valb/1000
d_v1 = 62/1000
z_sh1 = 10
b_sh1 = 12/1000
l_sh1 =25/1000
sigma_smsh1 = (8*M_max)/(lambda*(d_n1^2-d_v1^2)*l_sh1*z_sh1)*10^-6
tau_srsh1 = (4*M_max)/(lambda*(d_n1+d_v1)*l_sh1*z_sh1*b_sh1)*10^-6

% Выходной вал (2) (10 х 102 х 108  ГОСТ 1139-80)

lambda = 0.75
d_n2 = d_valt/1000
d_v2 = 62/1000
z_sh2 = 10
b_sh2 = 14/1000
l_sh2 =20/1000
sigma_smsh2 = (8*M_max)/(lambda*(d_n2^2-d_v2^2)*l_sh2*z_sh2)*10^-6
tau_srsh2 = (4*M_max)/(lambda*(d_n2+d_v2)*l_sh2*z_sh2*b_sh2)*10^-6

% Входной вал (2) (10 х 42 х 46  ГОСТ 1139-80)

lambda = 0.75
d_nvh = d_valvh/1000  
d_vvh = 42/1000
z_shvh = 8
b_shvh = 8/1000
l_shvh =25/1000
sigma_smshvh = (8*M_max_vh)/(lambda*(d_nvh^2-d_vvh^2)*l_shvh*z_shvh)*10^-6
tau_srshvh = (4*M_max_vh)/(lambda*(d_nvh+d_vvh)*l_shvh*z_shvh*b_shvh)*10^-6

SHLITZ = [sigma_smsh1 tau_srsh1; sigma_smsh2 tau_srsh2; sigma_smshvh tau_srshvh;]
%% Расчёт синхронизаторов

r_c = 0.153;
b_tr = 0.015;
q_c = 1.5*10^6; % для стали, Па
alpha_sync = 10
P_sync = 2*pi*r_c*b_tr*sind(alpha_sync)*q_c 
P_sync_n = 2*pi*r_c*b_tr*q_c 

z_spring = 8;
alpha_k = 35;
P_n = (P_sync/z_spring)*tand(alpha_k)
r_0c = 0.158
ac = r_c/(r_0c*sind(alpha_sync))
beta_sk = ceil(atand((0.06*ac+0.1)/(1-0.06*0.1*ac)))

%% Расчет толщины стенок картера

delta_k = ceil(1.3*nthroot(M_max*U(1),4))+1
B_crtr = d_k_avh/2+a_vh+a_w+d_k_a(2,1)+4*delta_k
%% Расчет диаметра болтов картера

d_b_k = ceil(1.25*nthroot(M_max,3))+1

