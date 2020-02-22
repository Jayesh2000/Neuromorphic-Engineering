w1 = 50 + randn(100,1)*5;
w = 250 + randn(100,1)*25;

i_0 = 10^-12;
w_e = 500;
tao = 15*10^-3;
tao_s = tao/4;

fr = 1; % Hz
dt = 1/10000; % s
nBins = 5000; % 10 ms spike train
spiketrain = rand(100, nBins) < fr*dt;

sum_current = zeros(1,5000);

for j = 1:100

	time = [];
	for i = 1:5000
		if spiketrain(j,i) == 1
			time = [time; i*0.1];
		end
	end	
	sum_current = sum_current + current(time, i_0, w(j), tao, tao_s);
end

t = linspace(1,5000,5000);
figure,plot(t, sum_current);
xlabel("Time*10");
ylabel("Spike for Poisson Stimulus");
title("Total Current due to various stimulus");
aef(1,1,sum_current);


