%Specify the number of neurons
n=3;
%Initializing all neurons to be of type 1
mode=ones(n,1);

%change the modes of neuron from here
%Mode 1 corresponds to RS, 2 to IB and 3 to CH
mode(1,1)=1; 
mode(2,1)=2;
mode(3,1)=3;

%Different current value
I_1=400e-12;
I_2=500e-12;
I_3=600e-12;

U_init=zeros(n,1);
V_init=zeros(n,1);

%Initialization of V and U which could be changed if necessary
for k=1:1:size(mode,1)
        if (mode(k,1)==1)
                V_init(k,1)=-50e-3;
        end
        if (mode(k,1)==2)
                V_init(k,1)=-56e-3;
        end
        if (mode(k,1)==3)
                V_init(k,1)=-40e-3;
        end
end

%For current=400pA
result_1=runge_kutta(mode,V_init, U_init, I_1, 0.0001);
figure,subplot(3,1,1)
plot(result_1(1,:));
title("RS mode: Neuron Spiking for I = 400 pA and t = 0.1 ms");
subplot(3,1,2)
plot(result_1(2,:));
title("IB mode: Neuron Spiking for I = 400 pA and t = 0.1 ms");
subplot(3,1,3)
plot(result_1(3,:));
title("CH mode: Neuron Spiking for I = 400 pA and t = 0.1 ms");
savefig('400pA.fig');

%For current=500pA
result_2=runge_kutta(mode,V_init, U_init, I_2, 0.0001);
figure,subplot(3,1,1)
plot(result_2(1,:));
title("RS mode: Neuron Spiking for I = 500 pA and t = 0.1 ms");
subplot(3,1,2)
plot(result_2(2,:));
title("IB mode: Neuron Spiking for I = 500 pA and t = 0.1 ms");
subplot(3,1,3)
plot(result_2(3,:));
title("CH mode: Neuron Spiking for I = 500 pA and t = 0.1 ms");
savefig('500pA.fig');

%For current=600pA
result_3=runge_kutta(mode,V_init, U_init, I_3, 0.0001);
figure,subplot(3,1,1)
plot(result_3(1,:));
title("RS mode: Neuron Spiking for I = 600 pA and t = 0.1 ms");
subplot(3,1,2)
plot(result_3(2,:));
title("IB mode: Neuron Spiking for I = 600 pA and t = 0.1 ms");
subplot(3,1,3)
plot(result_3(3,:));
title("CH mode: Neuron Spiking for I = 600 pA and t = 0.1 ms");
savefig('600pA.fig');

%For current=400pA and increased t
result_4=runge_kutta(mode,V_init, U_init, I_1, 0.0005);
figure,subplot(3,1,1)
plot(result_4(1,:));
title("RS mode: Neuron Spiking for I = 400 pA and t = 0.5 ms");
subplot(3,1,2)
plot(result_4(2,:));
title("IB mode: Neuron Spiking for I = 400 pA and t = 0.5 ms");
subplot(3,1,3)
plot(result_4(3,:));
title("CH mode: Neuron Spiking for I = 400 pA and t = 0.5 ms");
savefig('400pA_increased_T.fig');


% 
% result=runge_kutta(mode,V_init, U_init, I_1, 0.0002);
% figure,subplot(3,1,1)
% plot(result(1,:));
% subplot(3,1,2)
% plot(result(2,:));
% subplot(3,1,3)
% plot(result(3,:));