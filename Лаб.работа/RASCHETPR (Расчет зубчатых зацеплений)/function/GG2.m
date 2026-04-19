function [ RR ] = GG2( X )
%
global PROM
%
RR=tan(X)-X-PROM;
%fprintf('\n RR= %g  X= %g  PROM= %g',RR,X,PROM);
%
end

