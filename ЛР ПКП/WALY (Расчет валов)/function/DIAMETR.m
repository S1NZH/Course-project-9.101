function RRF = DIAMETR(D)
global TAUMAX Mdv K TAU do
%
%if D < do, D=do+0.01; end
if D < do, do=do-0.002; end
W=((pi*D^3)/16)*(1-(do^4)/(D^4));
TAU=K*Mdv/W; 
RRF=10^6*TAUMAX-TAU; 
end

