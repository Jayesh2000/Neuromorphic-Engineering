function [V,iNa,iK,iL,pC,pNa,pK,pL,t] = hh_neuron(I, tspan, dt, v, mi, hi, ni)   

  loop  = ceil(tspan/dt);   
  
  C = 1; %uF/cm2
  eNa = 50; %mV
  eK = -77; 
  eL = -55; 
  gNa = 120; %mS/cm2  
  gK = 36;  
  gL=0.3;
  
  t = (1:loop)*dt;
  V = zeros(loop,1);
  m = zeros(loop,1);
  h = zeros(loop,1);
  n = zeros(loop,1);
  
  V(1)=v;
  m(1)=mi;
  h(1)=hi;
  n(1)=ni;
  
  for i=1:loop-1 
      V(i+1) = V(i) + dt*(gNa*m(i)^3*h(i)*(eNa-V(i)) + gK*n(i)^4*(eK-V(i)) + gL*(eL-V(i)) + I(i))/C;
      m(i+1) = m(i) + dt*(alphaM(V(i))*(1-m(i)) - betaM(V(i))*m(i));
      h(i+1) = h(i) + dt*(alphaH(V(i))*(1-h(i)) - betaH(V(i))*h(i));
      n(i+1) = n(i) + dt*(alphaN(V(i))*(1-n(i)) - betaN(V(i))*n(i)); 
      
  end
  
  iNa = gNa*((m.^3).*h).*(V-eNa);
  iK = gK*(n.^4).*(V-eK);
  iL = gL*(V-eL);
  pC = (I-iNa-iK-iL).*V;
  pNa = iNa.*(V-eNa);
  pK = iK.*(V-eK);
  pL = iL.*(V-eL);
end

% alpha and beta functions

function aM = alphaM(V)
aM = (0.1*(V+40))/(1 - exp(-(V+40)/10));
end

function bM = betaM(V)
bM = 4*exp(-0.0556*(V+65));
end

function aH = alphaH(V)
aH = 0.07*exp(-0.05*(V+65));
end

function bH = betaH(V)
bH = 1/(1 + exp(0.1*(V+35)));
end

function aN = alphaN(V)
aN = (0.01*(V+55))/(1 - exp(-(V+55)/10));
end

function bN = betaN(V)
bN = 0.125*exp(-(V+65)/80);
end

