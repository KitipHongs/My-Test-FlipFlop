clc, close all,clear all;
dutycycle = 0.5;%duty cycle ratio
Tpr = 5;
clkstop = 60;
tstep = 0.1;

%%% Initialization %%%
% clkL = Low
[Q0x] = FlipFlop(1,0,0);
[Q1x] = FlipFlop(2,0,0);
[Q2x] = FlipFlop(3,0,0);
%% clkI = High
[Q0x] = FlipFlop(1,1,1);
[Q1x] = FlipFlop(2,0,1);
[Q2x] = FlipFlop(3,0,1);


[clkL clkT clkI] =clkgen(tstep,dutycycle,Tpr);
U(clkI) = 0;
D(clkI) = 0;

[Q0(clkI)] = FlipFlop(1,0, clkL(clkI));
[Q1(clkI)] = FlipFlop(2,0, clkL(clkI));
[Q2(clkI)] = FlipFlop(3,0, clkL(clkI));


q2 = 0;
q1 = 0;
q0 = 0;
nq2 = not(q2);
nq1 = not(q1);
nq0 = not(q0);

LED(clkI) = 0;
DLG(clkI) = 0;

while(clkT(clkI) < clkstop)
[clkL clkT clkI] =clkgen(tstep,dutycycle,Tpr);
U(clkI) = 0;
D(clkI) = 0;

% input pattern assignment
if (clkT(clkI) >= 0 && clkT(clkI) < 5)
  U(clkI) = 0;
  D(clkI) = 0;
endif
if (clkT(clkI) >= 5 && clkT(clkI) < 10)
  U(clkI) = 0;
  D(clkI) = 1;
endif
if (clkT(clkI) >= 10 && clkT(clkI) < 15)
  U(clkI) = 1;
  D(clkI) = 0;
endif
if (clkT(clkI) >= 15&& clkT(clkI) < 20)
  U(clkI) = 1;
  D(clkI) = 1;
endif
if (clkT(clkI) >= 20 && clkT(clkI) < 25)
  U(clkI) = 1;
  D(clkI) = 1;
endif
if (clkT(clkI) >= 25&& clkT(clkI) < 30)
  U(clkI) = 0;
  D(clkI) = 0;
endif
if (clkT(clkI) >= 30 && clkT(clkI) < 35 )
  U(clkI) = 1;
  D(clkI) = 0;
endif
if (clkT(clkI) >= 35&& clkT(clkI) < 40)
  U(clkI) = 1;
  D(clkI) = 1;
endif
if (clkT(clkI) >= 40&& clkT(clkI) < 45)
  U(clkI) = 0;
  D(clkI) = 1;
endif
if (clkT(clkI) >= 45&& clkT(clkI) < 50)
  U(clkI) = 0;
  D(clkI) = 0;
endif
if (clkT(clkI) >= 50&& clkT(clkI) < 55)
  U(clkI) = 1;
  D(clkI) = 0;
endif
if (clkT(clkI) >= 55)
  U(clkI) = 0;
  D(clkI) = 0;
endif


%%% input
u = U(clkI);
d = D(clkI);
nu = not(u);
nd = not(d);

%%% Output
D0 = or(and(nu,nd,nq2,nq1,q0),and(u,d,nq2,nq1,q0),and(nu,d,nq2,q1,nq0),and(u,nd,q2,nq1,nq0));
D1 = or(and(u,nd,nq2,nq1,q0),and(nu,nd,nq2,q1,nq0),and(u,d,nq2,q1,nq0),and(nu,d,q2,nq1,nq0));
D2 = or(and(nu,d,nq2,nq1,q0),and(u,nd,nq2,q1,nq0),and(nu,nd,q2,nq1,nq0),and(u,d,q2,nq1,nq0));

%%% DFF
[Q0(clkI)] = FlipFlop(1,D0, clkL(clkI));
[Q1(clkI)] = FlipFlop(2,D1, clkL(clkI));
[Q2(clkI)] = FlipFlop(3,D2, clkL(clkI));

q2 = Q2(clkI);
q1 = Q1(clkI);
q0 = Q0(clkI);
nq2 = not(q2);
nq1 = not(q1);
nq0 = not(q0);



L0(clkI) = and(nq2,nq1,q0);
L1(clkI) = and(nq2,q1,nq0);
L2(clkI) = and(q2,nq1,nq0);

end;


subplot(9,1,1);plot(clkT, clkL);axis on; title("Clock");
axis([0 clkstop -0.1  1.1]);
subplot(9,1,2); plot(clkT, U); axis on;title("UUUUU");
axis([0 clkstop -0.1  1.1]);
subplot(9,1,3); plot(clkT, D); axis on;title("DDDDD");
axis([0 clkstop -0.1  1.1]);
subplot(9,1,4);plot(clkT, Q2);axis on; title("Q2");
axis([0 clkstop -0.1  1.1]);
subplot(9,1,5); plot(clkT, Q1); axis on;title("Q1");
axis([0 clkstop -0.1  1.1]);
subplot(9,1,6); plot(clkT, Q0); axis on;title("Q0");
axis([0 clkstop -0.1  1.1]);
subplot(9,1,7); plot(clkT, L2); axis on;title("LED 2");
axis([0 clkstop -0.1  1.1]);
subplot(9,1,8); plot(clkT, L1); axis on;title("LED 1");
axis([0 clkstop -0.1  1.1]);
subplot(9,1,9); plot(clkT, L0); axis on;title("LED 0");
axis([0 clkstop -0.1  1.1]);
