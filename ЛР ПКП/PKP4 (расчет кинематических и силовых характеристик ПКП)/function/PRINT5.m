function [ POP ] = PRINT5
global NPR NZV NYF TMCK TBCK TWOD KPD WSAT fid 
global NMCK NBCK NWOD WZV TUPRM IPKP Z KPDSR D Q IP
POP=2;
[POP2]=LINE(5); 
fprintf (fid,'\n I   Передача    I    %i    I    %i    I    %i    I    %i    I    %i    I',...
    IP(1),IP(2),IP(3),IP(4),IP(5)); 
[POP2]=LINE(5); 
fprintf (fid,'\n I     I(0X)     I %7.3f I %7.3f I %7.3f I %7.3f I %7.3f I',...
    IPKP(1),IPKP(2),IPKP(3),IPKP(4),IPKP(5)); 
[POP2]=LINE(5); 
fprintf (fid,'\n I       q       I         I %6.3f  I %6.3f  I %6.3f  I %6.3f  I',...
    Q(1),Q(2),Q(3),Q(4));	
[POP2]=LINE(5); 
fprintf (fid,'\n I       КПД     I  %6.3f I  %6.3f I  %6.3f I  %6.3f I  %6.3f I',...
    KPD(1),KPD(2),KPD(3),KPD(4),KPD(5)); 
[POP2]=LINE(5);	
fprintf (fid,'\n  Средний КПД: %g;  Диапазон: %g',KPDSR,D);
[POP2]=LINE(5);
fprintf (fid,'\n          Угловые скорости звеньев');
[POP2]=LINE(5); 
for I1=1:NZV                                    
fprintf (fid,'\n I     Звено %i   I %6.3f  I %6.3f  I %6.3f  I %6.3f  I %6.3f  I',...
    I1,WZV(1,I1),WZV(2,I1),WZV(3,I1),WZV(4,I1),WZV(5,I1));  
[POP2]=LINE(5); 
end                                                 
fprintf (fid,'\n          Относительные угловые скорости сателлитов');	
[POP2]=LINE(5);    
for I1=1:NPR                                 
fprintf (fid,'\n I Wст(мцк)%i ряда I %6.3f  I %6.3f  I %6.3f  I %6.3f  I %6.3f  I',...
    I1,WSAT(1,I1,1),WSAT(2,I1,1),WSAT(3,I1,1),WSAT(4,I1,1),WSAT(5,I1,1));
if Z(I1,3)~=0
fprintf (fid,'\n I Wст(бцк)%i ряда I %6.3f  I %6.3f  I %6.3f  I %6.3f  I %6.3f  I',...
    I1,WSAT(1,I1,2),WSAT(2,I1,2),WSAT(3,I1,2),WSAT(4,I1,2),WSAT(5,I1,2));
end
[POP2]=LINE(5);
end                                               
fprintf (fid,'\n          Моменты на МЦК планетарных рядов');	
[POP2]=LINE(5);    
for I1=1:NPR                 
fprintf (fid,'\n I  M(мцк)%i ряда  I %6.2f  I %6.2f  I %6.2f  I %6.2f  I %6.2f  I',...
    I1,TMCK(1,I1),TMCK(2,I1),TMCK(3,I1),TMCK(4,I1),TMCK(5,I1));	
[POP2]=LINE(5);    
end
fprintf (fid,'\n          Моменты на водилах планетарных рядов');  
[POP2]=LINE(5);   
for I1=1:NPR                                      
fprintf (fid,'\n I  M(вод)%i ряда  I %6.2f  I %6.2f  I %6.2f  I %6.2f  I %6.2f  I',...
    I1,TWOD(1,I1),TWOD(2,I1),TWOD(3,I1),TWOD(4,I1),TWOD(5,I1));	   
[POP2]=LINE(5); 
end
fprintf (fid,'\n          Моменты на БЦК планетарных рядов');  
[POP2]=LINE(5);    
for I1=1:NPR                
fprintf (fid,'\n I  M(бцк)%i ряда  I %6.2f  I %6.2f  I %6.2f  I %6.2f  I %6.2f  I',...
    I1,TBCK(1,I1),TBCK(2,I1),TBCK(3,I1),TBCK(4,I1),TBCK(5,I1));
[POP2]=LINE(5);  
end
fprintf (fid,'\n          Мощность на МЦК планетарных рядов');	
[POP2]=LINE(5); 
for I1=1:NPR                                         
fprintf (fid,'\n I  N(мцк)%i ряда  I %6.2f  I %6.2f  I %6.2f  I %6.2f  I %6.2f  I',...
    I1,NMCK(1,I1),NMCK(2,I1),NMCK(3,I1),NMCK(4,I1),NMCK(5,I1));	
[POP2]=LINE(5);    
end
fprintf (fid,'\n          Мощность на водилах планетарных рядов');	
[POP2]=LINE(5);     
for I1=1:NPR                                         
fprintf (fid,'\n I  N(вод)%i ряда  I %6.2f  I %6.2f  I %6.2f  I %6.2f  I %6.2f  I',...
    I1,NWOD(1,I1),NWOD(2,I1),NWOD(3,I1),NWOD(4,I1),NWOD(5,I1));	
[POP2]=LINE(5);   
end
fprintf (fid,'\n          Мощность на БЦК планетарных рядов');   
[POP2]=LINE(5);  
for I1=1:NPR                                     
fprintf (fid,'\n I  N(бцк)%i ряда  I %6.2f  I %6.2f  I %6.2f  I %6.2f  I %6.2f  I',...
    I1,NBCK(1,I1),NBCK(2,I1),NBCK(3,I1),NBCK(4,I1),NBCK(5,I1));	
[POP2]=LINE(5);  
end
fprintf (fid,'\n          Моменты в элементах управления');
[POP2]=LINE(5);     
for I1=1:NYF                                        
fprintf (fid,'\n I    M(ЭУ) %i     I %6.2f  I %6.2f  I %6.2f  I %6.2f  I %6.2f  I',...
    I1,TUPRM(I1,1),TUPRM(I1,2),TUPRM(I1,3),TUPRM(I1,4),TUPRM(I1,5)); 
[POP2]=LINE(5);   
end
%
%[POP2]=RES;
%
end

