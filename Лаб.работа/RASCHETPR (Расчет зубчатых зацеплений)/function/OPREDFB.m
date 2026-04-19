function [ FF ] = OPREDFB(ITOCH,M,DW1)
%
FF=0;
if ITOCH==8
if (M>=1)&&(M<=3.5)
if DW1<=125, FF=19; end
if (DW1>125)&&(DW1<=400), FF=21; end
if (DW1>400)&&(DW1<=800), FF=24; end 
end
if (M>3.5)&&(M<=6.3)
if DW1<=125 FF=24; end
if (DW1>125.)&&(DW1<=400) FF=26; end
if (DW1>400.)&&(DW1<=800) FF=26; end 
end 
end
if ITOCH==7
if (M>=1)&&(M<=3.5)
if DW1<=125, FF=13; end
if (DW1>125)&&(DW1<=400), FF=15; end
if (DW1>400)&&(DW1<=800), FF=17; end 
end
if (M>3.5)&&(M<=6.3)
if DW1<=125, FF=17; end
if (DW1>125)&&(DW1<=400), FF=19; end
if (DW1>400)&&(DW1<=800), FF=19; end
end
end
if ITOCH==6
if (M>=1)&&(M<=3.5)
if DW1<=125, FF=9.5; end
if (DW1>125)&&(DW1<=400), FF=10; end
if (DW1>400)&&(DW1<=800), FF=12; end
end
if (M>3.5)&&(M<=6.3)
if DW1<=125, FF=12; end
if (DW1>125)&&(DW1<=400), FF=13; end
if (DW1>400)&&(DW1<=800), FF=13; end 
end 
end
if ITOCH==5
if (M>=1)&&(M<=3.5)
if DW1<=125, FF=5.6; end
if (DW1>125)&&(DW1<=400), FF=6.7; end
if (DW1>400)&&(DW1<=800), FF=7.5; end
end
if (M>3.5)&&(M<=6.3)
if DW1<=125, FF=7.5; end
if (DW1>125)&&(DW1<=400), FF=8.5; end
if (DW1>400)&&(DW1<=800), FF=8.5; end
end
end
FF=FF/1000;
%
end

