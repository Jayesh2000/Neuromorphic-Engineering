%  Question 1 a-part
Fanout = {[2 3 4] [] [] [] [2 3 4]};
Weight = {[3000 3000 3000] [] [] [] [3000 3000 3000]};
Delay = {[1 5 9] [] [] [] [8 5 1]};

% Question 1 b-part case 1

I_o = 1e-12;
tao = 0.015;
tao_s = tao/4;
M = 5000;
v = zeros(5,M+1);
I_app = zeros(5,M+1);
I_synaptic = zeros(5,M+1);
for i=1:1:1000
    I_app(2,i) = 50e-9;
end
for i=5:1:1004
    I_app(3,i) = 50e-9;
end
for i=9:1:1008
    I_app(4,i) = 50e-9;
end
display(I_app(2,:));
dummy_1 = spike_time(I_app(2,:));
dummy_2 = spike_time(I_app(3,:));
dummy_3 = spike_time(I_app(4,:));

for i=1:5
    spike_time{i} = [];
    arrival_time{i} = [];
    strength{i} = [];
    pre_neuron{i} = [];
end
int j1=1;int j2=1;int j3=1;
for i=1:1:M+1
    if(dummy_1(1,i)==1)
        spike_time(2,j1)=i;
        arrival_time(1,j1+j2+j3-2) = i+1;
        strength(1,j1+j2+j3-2)=3000;
        pre_neuron(1,j1+j2+j3-2) = 2;
        arrival_time(5,j1+j2+j3-2) = i+8;
        strength(5,j1+j2+j3-2)=3000;
        pre_neuron(5,j1+j2+j3-2) = 2;
        j1=j1+1;
    end
    if(dummy_2(1,i)==1)
        spike_time(3,j2)=i;
        arrival_time(1,j1+j2+j3-2) = i+5;
        strength(1,j1+j2+j3-2)=3000;
        pre_neuron(1,j1+j2+j3-2) = 3;
        arrival_time(5,j1+j2+j3-2) = i+5;
        strength(5,j1+j2+j3-2)=3000;
        pre_neuron(5,j1+j2+j3-2) = 3;
        j2=j2+1;
    end
    if(dummy_3(1,i)==1)
        spike_time(4,j3)=i;
        arrival_time(1,j1+j2+j3-2) = i+9;
        strength(1,j1+j2+j3-2)=3000;
        pre_neuron(1,j1+j2+j3-2) = 4;
        arrival_time(5,j1+j2+j3-2) = i+1;
        strength(5,j1+j2+j3-2)=3000;
        pre_neuron(5,j1+j2+j3-2) = 4;
        j3=j3+1;
    end
end






    
    