function [clkL clkT clkI] =clkgen(tstep,Lpr,Tpr)
  persistent cT cL;
  persistent k ; %translate
  persistent Tduty;

  if isempty(k)
    k = 0; cL(1) = 0 ; cT(1) = 0 ;
   Tduty =  Lpr*Tpr;
  end;
 k= k+1;
 cT(k)= k*tstep;
 x = mod(cT(k),(Tpr));%xxxxxxxxx
 if(x <= Tduty)
 cL(k) =1;
 else
 cL(k) = 0;
 end;
 clkI=k;
 clkL = cL;
 clkT = cT;
endfunction

