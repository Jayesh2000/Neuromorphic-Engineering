i_0 = 10^-12;
w_e = 500;
tao = 15*10^-3;
tao_s = tao/4;

fr = 10; % Hz
dt = 1/10000; % s
nBins = 5000; % 10 ms spike train
spiketrain = rand(1, nBins) < fr*dt;

time = [];
for i = 1:5000
	if spiketrain(i) == 1
		time = [time; i*0.1];
	end
end	
figure,plot(spiketrain);
xlabel("Time*10");
ylabel("Stimulus");
title("Poisson Stimulus");
i = current(time, i_0, w_e, tao, tao_s);
t = linspace(1,5000,5000);
figure,plot(t, i);
xlabel("Time*10");
ylabel("Current ");
title("Current for Poisson Stimulus");
aef(1,1,i);