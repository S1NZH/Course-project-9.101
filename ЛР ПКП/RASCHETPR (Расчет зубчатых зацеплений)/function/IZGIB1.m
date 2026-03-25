function [SIGMAFLIM,KFG,KFD,SFI] = IZGIB1(MHS,NTERMO,UGLEROD,MOLIB,HPOVZUB)
global LSTAL1
KLIN=0;
%     Œ“∆»√, ÕŒ–Ã¿À»«¿÷»ﬂ » ”À”◊ÿ≈Õ»≈
if NTERMO==1 
SIGMAFLIM=1.35*HPOVZUB+100; KFG=1.1; KFD=1.3; SFI=1.75; end
%      Œ¡⁄≈ÃÕ¿ﬂ «¿ ¿À ¿
if NTERMO==2 
SIGMAFLIM=600; KFG=0.9; KFD=1.2; SFI=1.75; end
%      «¿ ¿À ¿ “¬◊
if NTERMO==3  
SIGMAFLIM=700; KFG=1; KFD=1.1; SFI=1.75;  
if (UGLEROD>=50)&&(UGLEROD<60) 
SIGMAFLIM=900; KFG=0.75; KFD=1; SFI=1.75; end
if UGLEROD>=60 
SIGMAFLIM=750; KFG=0.8; KFD=1; SFI=1.75; end 
end 
%      ÷≈Ã≈Õ“¿÷»ﬂ
if NTERMO==4 
if LSTAL1(MHS)==13, KLIN=1; end
if LSTAL1(MHS)==14, KLIN=1; end
if LSTAL1(MHS)==17, KLIN=1; end
if LSTAL1(MHS)==20, KLIN=1; end
if LSTAL1(MHS)==27, KLIN=1; end
if LSTAL1(MHS)==28, KLIN=1; end
if LSTAL1(MHS)==30, KLIN=1; end
if LSTAL1(MHS)==31, KLIN=1; end
if LSTAL1(MHS)==32, KLIN=1; end
if LSTAL1(MHS)==33, KLIN=1; end
if LSTAL1(MHS)==34, KLIN=1; end
if KLIN==1
SIGMAFLIM=950; KFG=0.75; KFD=1; SFI=1.55; end
if LSTAL1(MHS)==8,  KLIN=2; end
if LSTAL1(MHS)==16, KLIN=2; end
if LSTAL1(MHS)==21, KLIN=2; end
if LSTAL1(MHS)==22, KLIN=2; end
if LSTAL1(MHS)==24, KLIN=2; end
if LSTAL1(MHS)==29, KLIN=2; end
if KLIN==2, SIGMAFLIM=820; KFG=0.75; KFD=1.1; SFI=1.55; end
if KLIN==0, SIGMAFLIM=800; KFG=0.8; KFD=1.2; SFI=1.65; end 
end
%      ¿«Œ“»–Œ¬¿Õ»≈
if NTERMO==5 
SIGMAFLIM=18.*32+50; KFG=0.9; KFD=1.15; SFI=2.2; end
%      Õ»“–Œ÷≈Ã≈Õ“¿÷»ﬂ
if NTERMO==6 
SIGMAFLIM=750; KFG=0.75;KFD=1.1; SFI=1.55;  
if MOLIB==1 
SIGMAFLIM=1000; KFG=0.7; KFD=1; SFI=1.55; end
end 
end