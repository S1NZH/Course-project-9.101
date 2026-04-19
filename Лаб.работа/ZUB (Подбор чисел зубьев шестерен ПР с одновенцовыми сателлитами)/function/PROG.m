function [PPP] = PROG(IRED)
%
fprintf('\n Расчет числа зубьев зубчатых колес планетарного ряда');
fprintf('\n        2-го класса с одновенцовыми сателлитами');
fprintf('\n       ');     
PPP=1;
% Минимальное число зубьев зубчатых колёс:
%
ZS1=12;
fprintf('\n Минимальное число зубьев зубчатых колёс: %3i',ZS1);
% Минимальное число сателлитов:
%
AST=3;
fprintf('\n Минимальное число сателлитов: %1i',AST);
fprintf('\n Конструктивный параметр: %g\n',IRED);
%
if IRED>=3 
%
    [pr]=SOLNCE (IRED,AST,ZS1);
%
end
if IRED<3
ZST1=ZS1;
%
    [p]=SATELLIT(IRED,AST,ZST1);
%
end
fprintf('\n        Расчет окончен'); 
end

