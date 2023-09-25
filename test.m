clear all;
dutycycle = 0.5;%duty cycle ratio
Tpr = 3;
clkstop = 100;
tstep = 0.01;
clkI =1;
clkL(1) = 0;
clkT(1) = 0;
Qa(1) = 0;

while(clkT(clkI) < clkstop)
[clkL clkT clkI] =clkgen(tstep,dutycycle,Tpr);
if (clkT(clkI) >= 0 && clkT(clkI) < 8)
  Da(clkI) = 0;
endif
if (clkT(clkI) >= 8 && clkT(clkI) < 14)
  Da(clkI) = 1;
endif
if (clkT(clkI) >= 14&& clkT(clkI) < 24)
  Da(clkI) = 0;
endif
if (clkT(clkI) >= 24&& clkT(clkI) < 31)
  Da(clkI) = 0;
endif
if (clkT(clkI) >= 31 && clkT(clkI) < 38)
  Da(clkI) = 1;
endif
if (clkT(clkI) >= 38&& clkT(clkI) < 45)
  Da(clkI) = 0;
endif
if (clkT(clkI) >= 45&& clkT(clkI) < 54)
  Da(clkI) = 1;
endif
if (clkT(clkI) >= 54&& clkT(clkI) < 61)
  Da(clkI) = 0;
endif
if (clkT(clkI) >= 61)
  Da(clkI) = 0;
endif

[Qa(clkI)] = FlipFlop(1,Da(clkI), clkL(clkI));
a(clkI) = Qa(clkI);


end;
subplot(3,1,1);plot(clkT, clkL);axis on; title("Clock");
axis([0 clkstop -0.1  1.1]);
subplot(3,1,2); plot(clkT, Da); axis on;title("D");
axis([0 clkstop -0.1  1.1]);
subplot(3,1,3); plot(clkT, Qa); axis on;title("Q");
axis([0 clkstop -0.1  1.1]);
