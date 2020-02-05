v = -60; %mV
mi = 0;
hi = 0;
ni = 0;
I0 = 15; %uA/cm2
dt = 0.01; %ms             
T = 30;

tspan = 5*T;
loop  = ceil(tspan/dt);   

I = zeros(loop,1);
I(2*(T/dt):3*(T/dt))=ones;
I = I0*I;
  
[V,iNa,iK,iL,pC,pNa,pK,pL,t] = hh_neuron(I, tspan, dt, v, mi, hi, ni);

energyC = sum(pC)*0.01;
energyNa = sum(pNa)*0.01;
energyK = sum(pK)*0.01;
energyL = sum(pL)*0.01;
fprintf('energyC = %f nJ/um2 \n', energyC);
fprintf('energyNa = %f nJ/um2 \n', energyNa);
fprintf('energyK = %f nJ/um2 \n', energyK);
fprintf('energyL = %f nJ/um2 \n', energyL);

figure
plot(t,V);
xlabel('Time (ms)');
ylabel('Membrane Potential (mV)');
title('V vs. t');

figure
plot(t,iNa);
xlabel('Time (ms)');
ylabel('$Na^{+}$ current','Interpreter','latex');
title('$i_{Na}$ vs. t','Interpreter','latex');  

figure
plot(t,iK);
xlabel('Time (ms)');
ylabel('$K^{+}$ current','Interpreter','latex');
title('$i_K$ vs. t','Interpreter','latex');

figure
plot(t,iL);
xlabel('Time (ms)');
ylabel('Leakage current','Interpreter','latex');
title('$i_L$ vs. t','Interpreter','latex');

figure
plot(t,pC);
xlabel('Time (ms)');
ylabel('pC ($\frac{nW}{cm^2}$)','Interpreter','latex');
title('instantaneous power dissipated in membrane capacitor','Interpreter','latex');  

figure
plot(t,pNa);
xlabel('Time (ms)');
ylabel('pNa ($\frac{nW}{cm^2}$)','Interpreter','latex');
title('instantaneous power dissipated in Na ion channel');

figure
plot(t,pK);
xlabel('Time (ms)');
ylabel('pK ($\frac{nW}{cm^2}$)','Interpreter','latex');
title('instantaneous power dissipated in K ion channel');

figure
plot(t,pL);
xlabel('Time (ms)');
ylabel('pL ($\frac{nW}{cm^2}$)','Interpreter','latex');
title('instantaneous power dissipated in leakage ion channel');
