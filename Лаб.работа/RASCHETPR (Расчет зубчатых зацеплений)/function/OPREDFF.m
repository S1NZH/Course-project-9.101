function [ FF ] = OPREDFF( ITOCH,M,DW1 )
%	
FF=0;
if ITOCH==8
if (M>=1)&&(M<=3.5)
if DW1<=125, FF=14; end
if (DW1>125)&&(DW1<=400), FF=18; end
if (DW1>400)&&(DW1<=800), FF=25; end
end
if (M>3.5)&&(M<=6.3)
if DW1<=125, FF=20; end
if (DW1>125)&&(DW1<=400), FF=22; end
if (DW1>400)&&(DW1<=800), FF=28; end
end
end
if ITOCH==7
if (M>=1)&&(M<=3.5)
if DW1<=125, FF=11; end
if (DW1>125)&&(DW1<=400), FF=13; end
if (DW1>400)&&(DW1<=800), FF=17; end
end
if (M>3.5)&&(M<=6.3)
if DW1<=125, FF=14; end
if (DW1>125)&&(DW1<=400), FF=16; end
if (DW1>400)&&(DW1<=800), FF=20; end
end
end
if ITOCH==6
if (M>=1)&&(M<=3.5)
if DW1<=125, FF=8; end
if (DW1>125)&&(DW1<=400), FF=9; end
if (DW1>400)&&(DW1<=800), FF=12; end
end
if (M>3.5)&&(M<=6.3)
if DW1<=125, FF=10; end
if (DW1>125)&&(DW1<=400), FF=11; end
if (DW1>400)&&(DW1<=800), FF=14; end
end
end
if ITOCH==5
if (M>=1)&&(M<=3.5)
if DW1<=125, FF=6; end
if (DW1>125)&&(DW1<=400), FF=7; end
if(DW1>400)&&(DW1<=800) FF=9; end
end
if (M>3.5)&&(M<=6.3)
if DW1<=125, FF=7; end
if (DW1>125)&&(DW1<=400), FF=8; end
if (DW1>400)&&(DW1<=800), FF=10; end
end
end
FF=FF/1000;
%
end

