function time = spike_time(i)

c = 3*10^(-10);
g_l = 3*10^(-8);
e_l = -0.07;
v_th = 0.02;
N = 1;
M = 5001;
alpha = 0.1;
time = 0;
count = 0;
h = 0.0001;
mem_pot = zeros(N,M+1);
mem_pot(:,1) = ones(N,1)*e_l;
current = ones(N,M+1)*i;


for t = 2:M+1
k1 = h*mem_der(mem_pot(:,t-1), current(:,t-1));
k2 = h*mem_der(mem_pot(:,t-1)+k1, current(:,t));
mem_pot(:,t) = mem_pot(:,t-1) +(k1 +k2)/2;
for n = 1:N
	if (mem_pot(n,t)> v_th) 
		mem_pot(n,t) = e_l;
		time = time+ t*h;
		count = count + 1;
		
		end
end

end
time = M*0.0001/count;
end