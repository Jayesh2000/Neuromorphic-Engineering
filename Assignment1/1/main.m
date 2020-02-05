%%
%Part b
%write a code to model the equations
c = 3*10^(-10);
g_l = 3*10^(-8);
e_l = -0.07;
v_th = 0.02;
N = 1;
M = 5000;
mem_pot = zeros(N,M+1);
current = ones(N,M+1)*3e-9;
h=0.0001;

for t = 2:M
k1 = h*mem_der(mem_pot(:,t-1), current(:,t-1));
k2 = h*mem_der(mem_pot(:,t-1)+k1, current(:,t));
mem_pot(:,t) = mem_pot(:,t-1) +(k1 +k2)/2;
for n = 1:N
	if (mem_pot(n,t)> v_th) 
		mem_pot(n,t) = e_l;
	end
end
end

figure,plot(mem_pot(1,:));
ylabel('Voltage');
xlabel('10*Time (ms)');
title('LIF Model');
savefig('LIF_model.fig');

%%
%Part c

c = 3*10^(-10);
g_l = 3*10^(-8);
e_l = -0.07;
v_th = 0.02;
N = 10;
M = 5001;
alpha = 0.1;
i_c = 5*10^-9;
h = 0.0001;
mem_pot = zeros(N,M+1);
mem_pot(:,1) = ones(N,1)*e_l;
current = ones(N,M+1);
time = linspace(1,M+1,M+1);
for r = 1:10 
	current(r,:) = 1+ones(1,M+1)*r*alpha;
end
current = current*i_c;



for t = 2:M+1
k1 = h*mem_der(mem_pot(:,t-1), current(:,t-1));
k2 = h*mem_der(mem_pot(:,t-1)+k1, current(:,t));
mem_pot(:,t) = mem_pot(:,t-1) +(k1 +k2)/2;
for n = 1:N
	if (mem_pot(n,t)> v_th) 
		mem_pot(n,t) = e_l;
		end
end

end

figure,subplot(4,1,1)
plot (time,mem_pot(2,:));
xlabel('10*Time (ms)');
ylabel('Voltage');
title("Neuron Spiking for neuron 2");
subplot(4,1,2)
plot (time,mem_pot(4,:))
xlabel('10*Time (ms)');
ylabel('Voltage');
title("Neuron Spiking for neuron 4");
subplot(4,1,3)
plot (time,mem_pot(6,:))
xlabel('10*Time (ms)');
ylabel('Voltage');
title("Neuron Spiking for neuron 6");
subplot(4,1,4)
plot (time,mem_pot(8,:))
xlabel('10*Time (ms)');
ylabel('Voltage');
title("Neuron Spiking for neuron 8");
savefig('Variation_of_current_in_LIF.fig');

%%
%Part d

curr = zeros(1,40);
avg_time = zeros(1,40);
for i = 1:40
	curr(1,i) = i*10^-9;
	avg_time(1,i) = spike_time(i*0.5*10^-9);
end
figure,plot(curr, avg_time);
ylabel('Average time');
xlabel('Current');
title('Average time between spikes as a function of Current obtained in part c');
savefig('Time_vs_spike_in_LIF_model.fig');