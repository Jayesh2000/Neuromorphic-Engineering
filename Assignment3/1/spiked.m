function y = spiked(i)

c = 3*10^(-10);
g_l = 3*10^(-8);
e_l = -0.07;
v_th = 0.02;
N = 1;
M = 5000;
y=zeros(2,M+1);
mem_pot = -0.07*ones(N,M+1);
%current = ones(N,M+1)*3e-9;
current = i;
spike = zeros(N,M+1);
flag = 0;
count = 20;
h=0.0001;

for t = 2:M
k1 = h*mem_der(mem_pot(:,t-1), current(:,t-1));
k2 = h*mem_der(mem_pot(:,t-1)+k1, current(:,t));
mem_pot(:,t) = mem_pot(:,t-1) +(k1 +k2)/2;
for n = 1:N
    if(flag == 1)
        mem_pot(n,t) = e_l;
        count = count-1;
    end
    if(count==0)
        flag = 0;
    end
    if (mem_pot(n,t)> v_th)
        spike(n,t) = 1;
        mem_pot(n,t) = v_th;
        flag = 1;
        count = 20;
    end
end
y(1,:) = spike(1,:);
y(2,:) = mem_pot(1,:);
end