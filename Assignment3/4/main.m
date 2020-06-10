clear all;
tic
%% Defining constants

N = 200; % no. of neurons
Rp = 3e-3; % refractory period in s
w = 3e3;
lambda = 100; % spike_times/s
I0 = 1e-12; % in A
dt = 1e-3; % time step in s
T = 1; % total simulation time in s
VT = 20e-3; % threshold voltage in V
EL = -70e-3; % resting potential in V
tm = 15e-3; % time constant of membrane in s
tl = 20e-3;
ts = tm/4; % synaptic time constant in s
A_up = 0.01;
A_down = -0.02;

%% Creating the network

Fanout = cell(N,1);
Weights = cell(N,1);
Delay = cell(N,1);
Fanin = cell(N,1);
Fanin_index = cell(N,1);
Fanin_delay = cell(N,1);
 
 for excitatory_neuron_i = 1:0.8*N
     Fanout{excitatory_neuron_i} = randperm(N, N/10);
     Weights{excitatory_neuron_i} = w*ones(1, N/10);
     Delay{excitatory_neuron_i} = randi(20,1, N/10)*1e-3;
 end
 
 for inhibitory_neuron_i = 0.8*N+1:N
     Fanout{inhibitory_neuron_i} = randperm(0.8*N, N/10);
     Weights{inhibitory_neuron_i} = -w*ones(1, N/10);
     Delay{inhibitory_neuron_i} = ones(1, N/10)*1e-3;
 end

 for neuron = 1:0.8*N  
    for post_neuron = 1:N/10
        Fanin{Fanout{neuron}(post_neuron)} = [Fanin{Fanout{neuron}(post_neuron)},neuron];
        Fanin_index{Fanout{neuron}(post_neuron)} = [Fanin_index{Fanout{neuron}(post_neuron)}, post_neuron];
        Fanin_delay{Fanout{neuron}(post_neuron)} = [Fanin_delay{Fanout{neuron}(post_neuron)},Delay{neuron}(post_neuron)];
    end
 end   

%% Giving the stimulus

 incoming_spike_times = cell(N,1); % time when each neuron receives spike_times, a N x T matrix 
 outgoing_spike_times = cell(N,1); % time when a neuron spikes
 incoming_spike_weights = cell(N,1); % weights corresponding to the synapses carrying the above incoming spike_times 
 
 distribution = makedist('Poisson', 'lambda', dt*lambda);
 t = (dt:dt:T);

 for input_neuron = 1:25

    % Input stimulus to first 25 excitatory neurons

     spikeTrain = zeros(1,T);
     for time = 1:T/dt
         sample = random(distribution, 1);
         if(sample<1) 
             spikeTrain(1,time)=0;
         else
             spikeTrain(1,time)=1;
         end
     end

     spikeTimes=0;
     for time = 1:T/dt
         if((spikeTrain(1,time)==1)&&(spikeTimes(1)==0)) 
             spikeTimes = time*dt; 
         end
         if(spikeTrain(1,time)==1) 
             spikeTimes = [spikeTimes,time*dt]; 
         end
     end

     incoming_spike_times{input_neuron} = spikeTimes;
     incoming_spike_weights{input_neuron} = w*ones(1,size(incoming_spike_times{input_neuron},2));
 end
 
%% Solving the network

Iapp = zeros(N, T/dt); % Applied current array
spike_times = zeros(N,1);  % time when the neuron spike_times

for time = 1:T/dt
    
    % Iterating over time to calculate the incoming post-synaptic currents due to spike_times:
     
     for neuron = 1:N
        
        % Adding current in time

        I = 0; 
        for incoming_neuron = 1:size(incoming_spike_times{neuron},2)
            if((incoming_spike_times{neuron}(1, incoming_neuron)) <= (time*dt))
                I = I + I0*incoming_spike_weights{neuron}(incoming_neuron)*(exp(-((time*dt)-incoming_spike_times{neuron}(incoming_neuron))/tm) - exp(-((time*dt)-incoming_spike_times{neuron}(incoming_neuron))/ts));
            end
        end 
        Iapp(neuron, time) = Iapp(neuron, time) + I;
     end
    
    if(time==1) 
        % update membrane potential at the first time step
        V(:,time) = EL*ones(N,1);
    else
        % update membrane potential
        [V(:,time),spike_times(:,time)] = voltage(V_final(:,time-1),Iapp(:,time), N, EL, VT, dt);
        
    end  
     
    for neuron = 1:N
        if(spike_times(neuron, time)==1)
           for post_neuron = 1:20 

                % Fanout to each of 20 post-synaptic neurons       
                post_neuron_time = 0;
                if((size(outgoing_spike_times{Fanout{neuron}(post_neuron)},2) > 0)&&(neuron < 0.8*N))
                     post_neuron_time = outgoing_spike_times{Fanout{neuron}(post_neuron)}(end);
                     Weights{neuron}(post_neuron) = Weights{neuron}(post_neuron)*(1+A_down*exp(-1*(time*dt + Delay{neuron}(post_neuron) - post_neuron_time)/tl));
                end

                incoming_spike_times{Fanout{neuron}(post_neuron)} = [incoming_spike_times{Fanout{neuron}(post_neuron)}, time*dt + Delay{neuron}(post_neuron)];
                incoming_spike_weights{Fanout{neuron}(post_neuron)} = [incoming_spike_weights{Fanout{neuron}(post_neuron)}, Weights{neuron}(post_neuron)];
                
      
                


           end
           outgoing_spike_times{neuron} =[outgoing_spike_times{neuron}, dt*time];     
           for pre_neuron = 1:size(Fanin{neuron},2)
                pre_neuron_time = 0;
                if(size(outgoing_spike_times{Fanin{neuron}(pre_neuron)},2) > 0)
                    for i = 1:size(outgoing_spike_times{Fanin{neuron}(pre_neuron)},2)
                        if((outgoing_spike_times{Fanin{neuron}(pre_neuron)}(i) + Fanin_delay{neuron}(pre_neuron)) <= time*dt)
                            
                            pre_neuron_time = outgoing_spike_times{Fanin{neuron}(pre_neuron)}(i) + Fanin_delay{neuron}(pre_neuron);
                        end
                    end 

                         
                        Weights{Fanin{neuron}(pre_neuron)}(Fanin_index{neuron}(pre_neuron)) = Weights{Fanin{neuron}(pre_neuron)}(Fanin_index{neuron}(pre_neuron))*(1+A_up*exp(-1*(time*dt - pre_neuron_time)/tl));
                                        
               end
           end 


        end
    end
         
     if(time~=T/dt) 
        spike_times = [spike_times, zeros(N,1)]; 
     end
     V_final(:,time) = V(:,time);
end



%% Scatter plot of firing pattern
x = cell(N,1);
 
 for i = 1:N
    for j = 1:T/dt
        if(spike_times(i,j)==1) 
            x{i} = [x{i},j]; 
        end
    end
 end
 
 figure;
 xlabel('Time in ms'); 
 ylabel('Neuron ID'); 
 for i = 1:N
    scatter(x{i},i*ones(size(x{i})),3,'blue','fill');
    hold on;
 end
 
 
%% Plotting Re(t) and Ri(t)

 Re = zeros(1,T/dt-10);
 Ri = zeros(1,T/dt-10);
 
 for i = 1:T/dt-10
    for j = 1:(0.8*N)
        for k = 1:11
            if(spike_times(j,i+k-1)==1) Re(1,i) = Re(1,i) + 1; end
        end
    end
    
    for j = ((0.8*N)+1):N
        for k = 1:11
            if(spike_times(j,i+k-1)==1) Ri(1,i) = Ri(1,i) + 1; end
        end
    end
 end
 
 figure(2);
 plot(1:T/dt-10,Re,1:T/dt-10,Ri);
 legend({'Re(t)','Ri(t)'});
 xlabel('Time in ms'); 
 ylabel('Re(t) and Ri(t)'); 
 hold on;
 
 toc