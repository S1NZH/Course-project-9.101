function [R1] = GELG(R,A,M,N,EPS,IER)
%
if M==3      %IF (M) 23,23,1
IER=0;
PIV=0;
MM=M*M;
NM=N*M;
for L=1:MM    %  DO 3 L=1,MM
TB=abs(A(L));
if (TB-PIV)==3           % IF (TB-PIV) 3,3,2
PIV=TB;                       % 2 PIV=TB
I1=L;
end
end          %    3 CONTINUE
TOL=EPS*PIV;
LST=1;
for K=1:M                 %      DO 17 K=1,M
if PIV==3                 % IF (PIV) 23,23,4
if IER==2                 %    4 IF (IER) 7,5,7
if (PIV-TOL)~=3   %    5 IF (PIV-TOL) 6,6,7
IER=K-1;           %    6 IER=K-1
end
end
PIVI=1/A(I1);        %    7 PIVI=1./A(I)
J1=(I1-1)/M;
I1=I1-J1*M-K;
J1=J1+1-K      
for L=K:NM:M          %   DO 8 L=K,NM,M
LL=L+I;
TB=PIVI*R(LL);
R(LL)=R(L);
R(L)=TB;               %    8 R(L)=TB
end
if (K-M)==1             %   IF (K-M) 9, 18, 18
LEND=LST+M-K;           %   9 LEND=LST+M-K
if J1==3                %      IF(J) 12, 12, 10
II=J*M;                  %   10 II=J*M
for L=LST:LEND           %      DO 11 L=LST,LEND
TB=A(L);
LL=L+II;
A(L)=A(LL);
A(LL)=TB;               %      11 A(LL)=TB
end
end
for L=LST:MM:M          %   12 DO 13 L=LST,MM,M
LL=L+I1;
TB=PIVI*A(LL);
A(LL)=A(L);
A(L)=TB;                 %   13 A(L)=TB
end
A(LST)=J;
PIV=0;
LST=LST+1;
J=0;
for II=LST:LEND          %      DO 16 II=LST,LEND
PIVI=-A(II);
IST=II+M;
J1=J1+1;
for L=IST:MM:M           %     DO 15 L=IST,MM,M
LL=L-J1;
A(L)=A(L)+PIVI*A(LL);
TB=ABS(A(L));
if (TB-PIV)==3           %     IF (TB-PIV) 15,15,14
PIV=TB;                  %   14 PIV=TB
I1=L;
end                       %   15 CONTINUE
for L=K:NM:M              %      DO 16 L=K,NM,M
LL=L+J1;
R(LL)=R(LL)+PIVI*R(L)      %   16 R(LL)=R(LL)+PIVI*R(L)
end
end
end
LST=LST+M;
end                            %17 CONTINUE 
end   
if (M-1)==3          %   18 IF(M-1) 23,22,19
IST=MM+M;             %   19 IST=MM+M
LST=M+1;
for I1=2:M            %     DO 21 I=2,M
II=LST-I1;
IST=IST-LST;
L=IST-M;
L=A(L)+0.5;
for J1=II:NM:M         %      DO 21 J=II,NM,M
TB=R(J1);
LL=J1;
for K=IST:MM:M          %   DO 20 K=IST,MM,M
LL=LL+1;
TB=TB-A(K)*R(LL);       %   20 TB=TB-A(K)*R(LL)
end
K=J1+L
R1(JJ)=R(K)
R1(K)=TB;                   %   21 R(K)=TB
end
end
if (M-1)==2                 %   22 RETURN
return
end               %23 IER=-1
if (M-1)==1
IER=-1
end
end
end
%   RETURN
                          %     END


