clear all;
%%  Question 1 a-part
Fanout = {[] [1 5] [1 5] [5 1] []};
Weight = {[3000 3000 3000] [] [] [] [3000 3000 3000]};
Delay = {[10 50 90] [] [] [] [80 50 10]};

%% Question 1 b-part case 1

I_o = 1e-12;
tao = 0.015;
tao_s = tao/4;
M = 5000;
I_app = zeros(5,M+1);
I_synaptic = zeros(5,M+1);
for i=1:1:10
    I_app(2,i) = 50e-9;
end
for i=41:1:50
    I_app(3,i) = 50e-9;
end
for i=81:1:90
    I_app(4,i) = 50e-9;
end
disp(size(I_app(2,:)));
pre_1 = spiked(I_app(2,:));
pre_2 = spiked(I_app(3,:));
pre_3 = spiked(I_app(4,:));

for i=1:5
    spike_time{i} = [];
    arrival_time{i} = [];
    strength{i} = [];
    pre_neuron{i} = [];
end

j1=1;j2=1;j3=1;
for i=1:1:M+1
    if(pre_1(1,i)==1)
        spike_time{1,2}(1,j1)=i;
        arrival_time{1,1}(1,j1+j2+j3-2) = i+10;
        strength{1,1}(1,j1+j2+j3-2)=3000;
        pre_neuron{1,1}(1,j1+j2+j3-2) = 2;
        arrival_time{1,5}(1,j1+j2+j3-2) = i+80;
        strength{1,5}(1,j1+j2+j3-2)=3000;
        pre_neuron{1,5}(1,j1+j2+j3-2) = 2;
        j1=j1+1;
    end
    if(pre_2(1,i)==1)
        spike_time{1,3}(1,j2)=i;
        arrival_time{1,1}(1,j1+j2+j3-2) = i+50;
        strength{1,1}(1,j1+j2+j3-2)=3000;
        pre_neuron{1,1}(1,j1+j2+j3-2) = 3;
        arrival_time{1,5}(1,j1+j2+j3-2) = i+50;
        strength{1,5}(1,j1+j2+j3-2)=3000;
        pre_neuron{1,5}(1,j1+j2+j3-2) = 3;
        j2=j2+1;
    end
    if(pre_3(1,i)==1)
        spike_time{1,4}(1,j3)=i;
        arrival_time{1,1}(1,j1+j2+j3-2) = i+90;
        strength{1,1}(1,j1+j2+j3-2)=3000;
        pre_neuron{1,1}(1,j1+j2+j3-2) = 4;
        arrival_time{1,5}(1,j1+j2+j3-2) = i+10;
        strength{1,5}(1,j1+j2+j3-2)=3000;
        pre_neuron{1,5}(1,j1+j2+j3-2) = 4;
        j3=j3+1;
    end
end

%display(spike_time{1,3}(1,5)); cell type syntax
for t=1:1:5001
    for q=1:1:size(arrival_time{1,1},2)
        if t>arrival_time{1,1}(1,q)
            I_synaptic(1,t) = I_synaptic(1,t) + I_o*3000*(exp(-0.0001*(t-arrival_time{1,1}(1,q))/tao) - exp(-0.0001*(t-arrival_time{1,1}(1,q))/tao_s));
        end
    end
    for q=1:1:size(arrival_time{1,5},2)
        if t>arrival_time{1,5}(1,q)
            I_synaptic(5,t) = I_synaptic(5,t) + I_o*3000*(exp(-0.0001*(t-arrival_time{1,5}(1,q))/tao) - exp(-0.0001*(t-arrival_time{1,5}(1,q))/tao_s));
        end
    end
end

post_1=spiked(I_synaptic(1,:));
post_2=spiked(I_synaptic(5,:));

figure,plot(pre_1(2,:));
xlim([0 120]);
xlabel("Time*10 ms");
ylabel("Potential Voltage");
title("Pre-Neuron Spiking Case 1");
hold on
plot(pre_2(2,:));
plot(pre_3(2,:));
legend("0 ms delay","4 ms delay","8 ms delay");
hold off;

figure,plot(I_synaptic(1,:));
xlim([0 5000]);
xlabel("Time*10 ms");
ylabel("Synaptic Current");
hold on
plot(I_synaptic(5,:));
legend("Neuron a","Neuron e");
hold off;

figure,plot(post_1(2,:));
xlim([0 5000]);
xlabel("Time*10 ms");
ylabel("Potential Voltage");
title("Post-Neuron Spiking Case 1");
hold on
plot(post_2(2,:));
legend("Neuron a","Neuron e");
hold off;

%% Question 1 b-part case 2

I_o = 1e-12;
tao = 0.015;
tao_s = tao/4;
M = 5000;
I2_app = zeros(5,M+1);
I2_synaptic = zeros(5,M+1);
for i=71:1:80
    I2_app(2,i) = 50e-9;
end
for i=31:1:40
    I2_app(3,i) = 50e-9;
end
for i=1:1:10
    I2_app(4,i) = 50e-9;
end
disp(size(I2_app(2,:)));
pre2_1 = spiked(I2_app(2,:));
pre2_2 = spiked(I2_app(3,:));
pre2_3 = spiked(I2_app(4,:));

for i=1:5
    spike_time2{i} = [];
    arrival_time2{i} = [];
    strength2{i} = [];
    pre_neuron2{i} = [];
end

j1=1;j2=1;j3=1;
for i=1:1:M+1
    if(pre2_1(1,i)==1)
        spike_time2{1,2}(1,j1)=i;
        arrival_time2{1,1}(1,j1+j2+j3-2) = i+10;
        strength2{1,1}(1,j1+j2+j3-2)=3000;
        pre_neuron2{1,1}(1,j1+j2+j3-2) = 2;
        arrival_time2{1,5}(1,j1+j2+j3-2) = i+80;
        strength2{1,5}(1,j1+j2+j3-2)=3000;
        pre_neuron2{1,5}(1,j1+j2+j3-2) = 2;
        j1=j1+1;
    end
    if(pre2_2(1,i)==1)
        spike_time2{1,3}(1,j2)=i;
        arrival_time2{1,1}(1,j1+j2+j3-2) = i+50;
        strength2{1,1}(1,j1+j2+j3-2)=3000;
        pre_neuron2{1,1}(1,j1+j2+j3-2) = 3;
        arrival_time2{1,5}(1,j1+j2+j3-2) = i+50;
        strength2{1,5}(1,j1+j2+j3-2)=3000;
        pre_neuron2{1,5}(1,j1+j2+j3-2) = 3;
        j2=j2+1;
    end
    if(pre2_3(1,i)==1)
        spike_time2{1,4}(1,j3)=i;
        arrival_time2{1,1}(1,j1+j2+j3-2) = i+90;
        strength2{1,1}(1,j1+j2+j3-2)=3000;
        pre_neuron2{1,1}(1,j1+j2+j3-2) = 4;
        arrival_time2{1,5}(1,j1+j2+j3-2) = i+10;
        strength2{1,5}(1,j1+j2+j3-2)=3000;
        pre_neuron2{1,5}(1,j1+j2+j3-2) = 4;
        j3=j3+1;
    end
end

%display(spike_time2{1,3}(1,5)); cell type syntax
for t=1:1:5001
    for q=1:1:size(arrival_time2{1,1},2)
        if t>arrival_time2{1,1}(1,q)
            I2_synaptic(1,t) = I2_synaptic(1,t) + I_o*3000*(exp(-0.0001*(t-arrival_time2{1,1}(1,q))/tao) - exp(-0.0001*(t-arrival_time2{1,1}(1,q))/tao_s));
        end
    end
    for q=1:1:size(arrival_time2{1,5},2)
        if t>arrival_time2{1,5}(1,q)
            I2_synaptic(5,t) = I2_synaptic(5,t) + I_o*3000*(exp(-0.0001*(t-arrival_time2{1,5}(1,q))/tao) - exp(-0.0001*(t-arrival_time2{1,5}(1,q))/tao_s));
        end
    end
end

post2_1=spiked(I2_synaptic(1,:));
post2_2=spiked(I2_synaptic(5,:));

figure,plot(pre2_1(2,:));
xlim([0 220]);
xlabel("Time*10 ms");
ylabel("Potential Voltage");
title("Pre-Neuron Spiking Case 2");
hold on
plot(pre2_2(2,:));
plot(pre2_3(2,:));
legend("7 ms delay","3 ms delay","0 ms delay");
hold off;

figure,plot(I2_synaptic(1,:));
xlim([0 5000]);
xlabel("Time*10 ms");
ylabel("Synaptic Current");
hold on
plot(I2_synaptic(5,:));
legend("Neuron a","Neuron e");
hold off;

figure,plot(post2_1(2,:));
xlim([0 5000]);
xlabel("Time*10 ms");
ylabel("Potential Voltage");
title("Post-Neuron Spiking Case 2");
hold on
plot(post2_2(2,:));
legend("Neuron a","Neuron e");
hold off;

    
    