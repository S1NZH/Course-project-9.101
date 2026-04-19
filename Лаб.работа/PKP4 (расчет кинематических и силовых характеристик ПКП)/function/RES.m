function [ POP2 ] = RES
global MPR NPR WZV TMCK NPT
POP2=2;
for I1=1:NPR
    KMCK=MPR(I1,1);  
    KVOD=MPR(I1,2); 
        for III=1:NPT
            wzvm(III,1)=WZV(III,KMCK);
            wzvm(NPT+III,1)=WZV(III,KVOD);
            wzvm(2*NPT+III,1)=TMCK(III,I1);
if I1==1, xlswrite ('resultat\resultat1\PR1',wzvm),end
if I1==2, xlswrite ('resultat\resultat1\PR2',wzvm),end
if I1==3, xlswrite ('resultat\resultat1\PR3',wzvm),end
if I1==4, xlswrite ('resultat\resultat1\PR4',wzvm),end
if I1==5, xlswrite ('resultat\resultat1\PR5',wzvm),end
end
end
end

