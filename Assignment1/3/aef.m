function aef(neuron_param,n,current,name)

M = 5000;
h = 0.0001;
v_pot = zeros(n,M+1);
u_pot = zeros(n,M+1);
function volt = volt_der(c,g_l,e_l,v_t,delta,a,tao,b, v_r,v,u,i)
		volt = -g_l/c*(v-e_l) + (g_l/c)*delta*exp((v-v_t)/delta) - u/c +i/c;
	end
	function pot = u_der(c,g_l,e_l,v_t,delta,a,tao,b, v_r,v,u)
		pot = (a/tao)*(v-e_l) - u/tao;
	end
for i = 1:n
	if(neuron_param(i)==1)
		c=200*10^-12;
		g_l = 10*10^-9;
		e_l = -70*10^-3;
		v_t = -50*10^-3;
		delta = 2*10^-3;
		a = 2*10^-9;
		tao = 30*10^-3;
		b = 0*10^-12;
		v_r = -58*10^-3;
		elseif(neuron_param(i)==2)
		c=130*10^-12;
		g_l = 18*10^-9;
		e_l = -58*10^-3;
		v_t = -50*10^-3;
		delta = 2*10^-3;
		a = 4*10^-9;
		tao = 150*10^-3;
		b = 120*10^-12;
		v_r = -50*10^-3;
		else
			c=200*10^-12;
		g_l = 10*10^-9;
		e_l = -58*10^-3;
		v_t = -50*10^-3;
		delta = 2*10^-3;
		a = 2*10^-9;
		tao = 120*10^-3;
		b = 100*10^-12;
		v_r = -46*10^-3;
	end	

v_pot(i,1) = v_r;
u_pot(i,1) = 0;
	

for t =2:M+1
	v_pot(i,t) = v_pot(i,t-1)+ h*volt_der(c,g_l,e_l,v_t,delta,a,tao,b, v_r,v_pot(i,t-1),u_pot(i,t-1),current(i,t-1));
	u_pot(i,t) = u_pot(i,t-1)+ h*u_der(c,g_l,e_l,v_t,delta,a,tao,b, v_r,v_pot(i,t-1),u_pot(i,t-1));
	if(v_pot(i,t)>0)
		v_pot(i,t) = v_r;
		u_pot(i,t) = u_pot(i,t) +b;
	end
end
time = linspace(1,M+1,M+1);

end

figure,subplot(3,1,1)
plot (time,v_pot(1,:));
xlim([0 5000]);
xlabel('10*Time (ms)');
ylabel('Voltage');
title("RS mode");
subplot(3,1,2)
plot (time,v_pot(2,:))
xlim([0 5000]);
xlabel('10*Time (ms)');
ylabel('Voltage');
title("IB Mode");
subplot(3,1,3)
plot (time,v_pot(3,:))
xlim([0 5000]);
xlabel('10*Time (ms)');
ylabel('Voltage');
title("CH Mode");
%savefig(sprintf('Q3_plot_for_current_%d.fig', name));
end