function [ BNER ] = TOCHNOSTY( ITOCH,AST )
%Подпрограмма определения коэффициента неравномерности распределения нагрузки между сателлитам
BNER=1;
if AST==2 
  if ITOCH>=7
    BNER=1.16; end
end
%
if AST==3
  if ITOCH>=7 
   BNER=1.23; 
  end
end
%
if AST==4  
 if ITOCH>=7
  BNER=1.32;
  if ((ITOCH==6)||(ITOCH==5))
   BNER=1.25; end 
   if ITOCH<5 
     BNER=1.15; 
   end 
 end
end
%C
if AST==5 
 if ITOCH>=7 
  BNER=1.35; 
 end
 if ((ITOCH==6)||(ITOCH==5)) 
  BNER=1.35; 
 end
 if ITOCH<5 
  BNER=1.19; 
 end  
end 
%
if AST==6 
 if ITOCH>=7 
  BNER=1.38; 
 end
 if ((ITOCH==6)||(ITOCH==5)) 
  BNER=1.44; end
 if ITOCH<5 
  BNER=1.23; end
end
%C
if AST==7
 if ITOCH>=7
  BNER=1.47; end
 if ((ITOCH==6)||(ITOCH==5)) 
  BNER=1.47; end
 if ITOCH<5 
  BNER=1.27; end 
end
%
if AST==8
 if ITOCH>=7 
  BNER=1.6; end
 if ((ITOCH==6)||(ITOCH==5)) 
  BNER=1.6; end
 if ITOCH<5 
  BNER=1.3; end 
end
%
if AST==9  
 if ITOCH>=7 
  BNER=1.61; end
 if ((ITOCH==6)||(ITOCH==5)) 
  BNER=1.61; end
 if ITOCH<5 
  BNER=1.61; end 
end
end

