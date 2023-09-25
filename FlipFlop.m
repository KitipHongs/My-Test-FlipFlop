function [Q] = FlipFlop(FFn, D, clkL)
  persistent q;
  persistent qold;
  persistent clkLV;
  persistent clkLVold;
  if isempty(q)
    q(1) = 0;
    qold(1) = 0;
    clkLV(1) = 0;
    clkLVold(1) = 1;
    q(2) = 0;
    qold(2) = 0;
    clkLV(2) = 0;
    clkLVold(2) = 1;
    q(3) = 0;
    qold(3) = 0;
    clkLV(3) = 0;
    clkLVold(3) = 1;
  endif
  clkLV(FFn) = clkL;
  if ((clkLV(FFn) == 1) && (clkLVold(FFn) == 0))
    if (D == 1)
      q(FFn) = 1;
    else
      q(FFn) = 0;
    end
  else
    q(FFn) = qold(FFn);
  endif
  clkLVold(FFn) = clkLV(FFn);
  Q = q(FFn);
  qold(FFn) = q(FFn);
endfunction

