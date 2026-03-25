%
% Программа расчета пошипниковых узлов на статическую нагрузку и
%                  динамическую выносливость
%
clear, clc
global fid WWW NPRIZNAK
addpath([pwd '\function'])
%
%  Опорой какого элемента является подшипник:
%  NPRIZNAK = 1 - опорой сателлита планетарного ряда;
%  NPRIZNAK = 2 - опорой вала.
%
NPRIZNAK = 1;
%
% Имя файла с исходными данными
WWW=xlsread ('dannye\sat');
% Имя файла для вывода результатов
fid=fopen ('resultat\sat.doc','w+');
%
%     Подпрограмма ввода исходных данных для расчета подшипников сателлитов ПР
%
if NPRIZNAK == 1, [NPRIZ] = IDANNYE1; end
%
%     Подпрограмма ввода исходных данных для расчета подшипников вала
%
if NPRIZNAK == 2, [NPRIZ] = IDANNYE2; end
%
[TRE] = PROGRAMM(NPRIZ);
