fr = 10; % Hz
dt = 1/10000; % s
nBins = 5000; % 10 ms spike train
spiketrain = rand(1, nBins) < fr*dt;
time = [];
for i = 1:5000
	if (spiketrain(i) == 1)
		time = [time; i*0.1];
	end
end	
figure,plot(spiketrain);
xlabel("Time*10");
ylabel("Spike");