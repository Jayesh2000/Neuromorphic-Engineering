close all;

v = -60; %mV
mi = 0.05197;
hi = 0.6015;
ni = 0.3153;
I0 = 15; %uA/cm2
dt = 0.01; %ms             
T = 30;

tspan = 5*T;
loop  = ceil(tspan/dt);   

I = zeros(loop,1);
I(2*(T/dt):3*(T/dt))=ones;
I = I0*I;
  
[V,iNa,iK,iL,pC,pNa,pK,pL,t] = hh_neuron(I, tspan, dt, v, mi, hi, ni);

t1 = int32(64.29/dt);
t2 = int32(77.41/dt);
energyC = sum(pC(t1:t2)*dt)*0.01;
energyNa = sum(pNa(t1:t2)*dt)*0.01;
energyK = sum(pK(t1:t2)*dt)*0.01;
energyL = sum(pL(t1:t2)*dt)*0.01;
fprintf('energyC = %f mJ/m2 \n', energyC);
fprintf('energyNa = %f mJ/m2 \n', energyNa);
fprintf('energyK = %f mJ/m2 \n', energyK);
fprintf('energyL = %f mJ/m2 \n', energyL);

figure
subplot(2,2,1);
plot(t,V);
xlabel('Time (ms)');
ylabel('Membrane Potential (mV)');
title('V vs. t','Interpreter','latex');

subplot(2,2,2);
plot(t,iNa);
xlabel('Time (ms)');
ylabel('$Na^{+}$ current','Interpreter','latex');
title('$i_{Na}$ vs. t','Interpreter','latex');  

subplot(2,2,3);
plot(t,iK);
xlabel('Time (ms)');
ylabel('$K^{+}$ current','Interpreter','latex');
title('$i_K$ vs. t','Interpreter','latex');

subplot(2,2,4);
plot(t,iL);
xlabel('Time (ms)');
ylabel('Leakage current','Interpreter','latex');
title('$i_L$ vs. t','Interpreter','latex');
%sgtitle('Q4a. Time evolution');
%savefig('Q4_Time_evolution');

figure
subplot(2,2,1);
plot(t(t1:t2),pC(t1:t2));
xlabel('Time (ms)');
ylabel('pC ($\frac{nW}{cm^2}$)','Interpreter','latex');
title('Membrane capacitor');  

subplot(2,2,2);
plot(t(t1:t2),pNa(t1:t2));
xlabel('Time (ms)');
ylabel('pNa ($\frac{nW}{cm^2}$)','Interpreter','latex');
title('Na ion channel');

subplot(2,2,3);
plot(t(t1:t2),pK(t1:t2));
xlabel('Time (ms)');
ylabel('pK ($\frac{nW}{cm^2}$)','Interpreter','latex');
title('K ion channel');

subplot(2,2,4);
plot(t(t1:t2),pL(t1:t2));
xlabel('Time (ms)');
ylabel('pL ($\frac{nW}{cm^2}$)','Interpreter','latex');
title('leakage channel');
%savefig('Q4_Instantaneous_power_dissipation');
%sgtitle('Q4b. Instantaneous power dissipation');
