close all;

w = 250 + randn(100,1)*25;

i_0 = 10^-12; % A
w_e = 500;
tao = 15*10^-3; % s
tao_s = tao/4; % s
gamma = 1;

fr = 1; % Hz
dt = 1/10000; % s
nBins = 5000; % 10 ms spike train
iter = 100;
N = 0;
t = linspace(1,5000,5000);

for k = 1:iter
N = N+1;    
spiketrain = rand(100, nBins) < fr*dt;
sum_current = zeros(1,5000);
check = double(spiketrain); 

for j = 1:100
	time = [];
	for i = 1:5000
		if spiketrain(j,i) == 1
			time = [time; i*0.1];
            check(j,i) = i;
		end
	end	
	sum_current = sum_current + current(time, i_0, w(j), tao, tao_s);
end

% plot(t, sum_current)

v_plot = aef(1,1,sum_current);

[peak_val, t_max] = max(v_plot(1,:));
check = t_max*ones(100, 5000) - check;

for j = 1:100
    for i = 1:5000
        if(check(j,i)<0)
           check(j,i) = inf;
        end
    end
end

delta_w = w;
delta_t = delta_w;

for j = 1:100
    [val, id] = min(check(j,:));
    delta_t(j) = val;
end    
delta_t = delta_t*dt;

for p = 1:size(delta_w)
    delta_w(p) = w(p)*gamma*(exp(-delta_t(p)/tao) - exp(-delta_t(p)/tao_s))*heaviside(delta_t(p));
end

w = w - delta_w;
for j = 1:100
    if(w(j) < 10)
        w(j) = 10;
    end
end
if(peak_val<-0.035)
    break;
end

end
fprintf('Number of iteration: %i \n', N);
disp(w);