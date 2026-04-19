function [ KFBETTA ] = KFBET(  )
%SUBROUTINE KFBET(KFBETTA)
global KSHEMA D1 BW
PSI=BW/D1;
if KSHEMA==1, KFBETTA=1.+1.625*PSI; end
if KSHEMA==2
if PSI<=0.4, KFBETTA=1.+1.05*PSI; end
if PSI>0.4, KFBETTA=1.4187+1.5*(PSI-0.4); end, end
if KSHEMA==3
if PSI<=0.4, KFBETTA=1.+0.435*PSI; end
if (PSI>0.4)&&(PSI<=0.8), KFHBETTA=1.1735+0.612*(PSI-0.4); end
if PSI>0.8, KFBETTA=1.418+0.752*(PSI-0.8); end, end
if KSHEMA==4
if PSI<=0.4, KFBETTA=1.+0.224*PSI; end
if (PSI>0.4)&&(PSI<=0.8), KFBETTA=1.0897+0.43*(PSI-0.4); end
if (PSI>0.8)&&(PSI<=1.2), KFBETTA=1.26+0.682*(PSI-0.8); end
if PSI>1.2 KFBETTA=1.53+0.941*(PSI-1.2); end, end
if KSHEMA==5
if PSI<=0.4, KFBETTA=1.+0.156*PSI; end
if (PSI>0.4)&&(PSI<=0.8), KFBETTA=1.062+0.335*(PSI-0.4); end
if (PSI>0.8)&&(PSI<=1.2), KFBETTA=1.196+0.518*(PSI-0.8); end
if PSI>1.2, KFBETTA=1.4032+0.679*(PSI-1.2); end, end
%	PRINT *,'KSHEMA=',KSHEMA,' PSI=',PSI
if KSHEMA==6
if PSI<=0.4 KFBETTA=1.+0.097*PSI; end
if (PSI>0.4)&&(PSI<=0.8), KFBETTA=1.039+0.35*(PSI-0.4); end
if PSI>0.8, KFBETTA=1.139+0.7575*(PSI-0.8); end, end
if KSHEMA==7
if PSI<=0.4, KFBETTA=1.+0.016*PSI; end
if (PSI>0.4)&&(PSI<=0.8), KFBETTA=1.006+0.136*(PSI-0.4); end
if (PSI>0.8)&&(PSI<=1.2), KFBETTA=1.06+0.244*(PSI-0.8); end
if PSI>1.2, KFBETTA=1.158+0.322*(PSI-1.2); end, end
if KSHEMA>7 
fprintf ('\nяуелю пюяонкнфемхъ гсавюршу йнкея гюдюмю ме бепмн'), end
%  stop
end

