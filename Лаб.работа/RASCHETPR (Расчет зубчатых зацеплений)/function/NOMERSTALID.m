function [ ASTALD ] = NOMERSTALID( ASTAL,I )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
PRUS=1;
for J=1:20
      switch PRUS
          case 1
if ASTAL(I,J)==' ', PRUS=2; end 
ASTALD(J)=ASTAL(I,J);
      case 2
      end       
end
end

