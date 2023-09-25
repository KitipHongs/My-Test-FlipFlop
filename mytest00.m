clc, close all,clear all;
dutycycle = 0.5;%duty cycle ratio
Tpr = 5;
clkstop = 100;
tstep = 0.1;
%%% Initialization %%%
% clkL = Low


[clkL clkT clkI] =clkgen(tstep,dutycycle,Tpr);
P(clkI) = 0;
X(clkI) = 0;

q2 = 0;
q1 = 0;
q0 = 0
nq2 = not(q2);
nq1 = not(q1);
nq0 = not(q0);

LED(clkI) = 0;
DLG(clkI) = 0;
%%% END of Initialization %%%


while(clkT(clkI) < clkstop)
[clkL clkT clkI] =clkgen(tstep,dutycycle,Tpr);
P(clkI) = 0;
X(clkI) = 0;

% input pattern assignment
if (clkT(clkI) >= 0 && clkT(clkI) < 8)
  P(clkI) = 0;
  X(clkI) = 0;
endif
if (clkT(clkI) >= 8 && clkT(clkI) < 14)
  P(clkI) = 1;
  X(clkI) = 0;
endif
if (clkT(clkI) >= 14&& clkT(clkI) < 24)
  P(clkI) = 0;
  X(clkI) = 0;
endif
if (clkT(clkI) >= 24&& clkT(clkI) < 31)
  P(clkI) = 1;
  X(clkI) = 1;
endif
if (clkT(clkI) >= 31 && clkT(clkI) < 38)
  P(clkI) = 1;
  X(clkI) = 0;
endif
if (clkT(clkI) >= 38&& clkT(clkI) < 45)
  P(clkI) = 0;
  X(clkI) = 0;
endif
if (clkT(clkI) >= 45&& clkT(clkI) < 54)
  P(clkI) = 1;
  X(clkI) = 0;
endif
if (clkT(clkI) >= 60)
  P(clkI) = 0;
  X(clkI) = 0;
endif
%%% input of CKT 1 are P, X
p = P(clkI);
x = X(clkI);
np = not(p);
nx = not(x);

%%% Output of CKT 1 are D0 D1 D2
D0 = or(and(np,nx,nq2,nq1,q0),and(np,x,nq2,nq1,q0),and(p,x,nq2,nq1,q0),...
        and(p,nx,q2,nq1,nq0));
D1 = or(and(p,nx,nq2,nq1,q0),and(np,nx,nq2,q1,nq0),and(p,x,nq2,q1,nq0),...
        and(np,x,q2,nq1,nq0));
D2 = or(and(p,nx,nq2,q1,nq0),and(np,nx,q2,nq1,nq0),and(p,x,q2,nq1,nq0));

Q0(clkI) = D0;
Q1(clkI) = D1;
Q2(clkI) = D2;
LED(clkI) = 0;
DLG(clkI) = 0;


end;

figure(1);
subplot(8,1,1);plot(clkT, clkL);axis on; title("Clock");
axis([0 clkstop -0.1  1.1]);
subplot(8,1,2); plot(clkT, P); axis on;title("PPPP");
axis([0 clkstop -0.1  1.1]);
subplot(8,1,3); plot(clkT, X); axis on;title("XXXX");
axis([0 clkstop -0.1  1.1]);
subplot(8,1,4);plot(clkT, Q2);axis on; title("Q2");
axis([0 clkstop -0.1  1.1]);
subplot(8,1,5); plot(clkT, Q1); axis on;title("Q1");
axis([0 clkstop -0.1  1.1]);
subplot(8,1,6); plot(clkT, Q0); axis on;title("Q0");
axis([0 clkstop -0.1  1.1]);
subplot(8,1,7); plot(clkT, LED); axis on;title("LED");
axis([0 clkstop -0.1  1.1]);
subplot(8,1,8); plot(clkT, DLG); axis on;title("Dialoge");
axis([0 clkstop -0.1  1.1]);
