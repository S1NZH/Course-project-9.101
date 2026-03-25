function [ KHBETTA ] = KHBET(  )
%
global KSHEMA BW D1
%
PSI=BW/D1;
if KSHEMA==1, KHBETTA=1.+1.125*PSI; 
end
if KSHEMA==2
if PSI<=0.2, KHBETTA=1.+0.5*PSI; end
if (PSI>0.2)&&(PSI<=0.4), KHBETTA=1.1+0.75*(PSI-0.2); end
if PSI>0.4, KHBETTA=1.25+1.04*(PSI-0.4); end 
end
if KSHEMA==3
if PSI<=0.33, KHBETTA=1.+0.3*PSI; end
if (PSI>0.33)&&(PSI<=0.6), KHBETTA=1.1+0.37*(PSI-0.33); end
if PSI>0.6, KHBETTA=1.2+0.463*(PSI-0.6); end
end
if KSHEMA==4
if PSI<=0.4, KHBETTA=1.+0.203*PSI; end
if (PSI>0.4)&&(PSI<=0.8), KHBETTA=1.081+0.308*(PSI-0.4); end
if PSI>0.8, KHBETTA=1.204+0.463*(PSI-0.8); end
end
if KSHEMA==5
if PSI<=0.2, KHBETTA=1.+0.108*PSI; end
if (PSI>0.2)&&(PSI<=0.4), KHBETTA=1.02+0.135*(PSI-0.2); end
if (PSI>0.4)&&(PSI<=0.8), KHBETTA=1.047+0.237*(PSI-0.4); end
if PSI>0.8, KHBETTA=1.142+0.287*(PSI-0.8); end 
end
if KSHEMA==6
if PSI<=0.4, KHBETTA=1.+0.06*PSI; end
if (PSI>0.4)&&(PSI<=0.8), KHBETTA=1.024+0.142*(PSI-0.4); end
if (PSI>0.8)&&(PSI<=1.2), KHBETTA=1.08+0.2067*(PSI-0.8); end
if PSI>1.2, KHBETTA=1.163+0.256*(PSI-1.2); end 
end
if KSHEMA==7
if PSI<=0.4, KHBETTA=1.+0.0188*PSI, end
if (PSI>0.4)&&(PSI<=0.8), KHBETTA=1.0075+0.08*(PSI-0.4); end
if (PSI>0.8)&&(PSI<=1.2), KHBETTA=1.04+0.128*(PSI-0.8); end
if PSI>1.2, KHBETTA=1.09+0.173*(PSI-1.2); end 
end
if KSHEMA>7
 fprintf('\nяуелю пюяонкнфемхъ гсавюршу йнкея гюдюмю ме бепмн'); 
 return
end

end

