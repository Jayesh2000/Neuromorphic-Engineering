%% Section 1 for part a

w0 = 200 + randn(100,1)*20;% initial weight
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
spiketrain_1 = rand(100, nBins) < fr*dt; %stimulus 1
spiketrain_2 = rand(100, nBins) < fr*dt; %stimulus 2
sum_current_1 = zeros(1,5000);
sum_current_2 = zeros(1,5000);
for j = 1:100

	time_1 = [];
    time_2 = [];
	for i = 1:5000
		if spiketrain_1(j,i) == 1
			time_1 = [time_1; i*0.1];
        end
        if spiketrain_2(j,i) == 1
			time_2 = [time_2; i*0.1];
		end
	end	
	sum_current_1 = sum_current_1 + current(time_1, i_0, w0(j), tao, tao_s);
    sum_current_2 = sum_current_2 + current(time_2, i_0, w0(j), tao, tao_s);
end

 figure,plot(t,sum_current_1);
 title("Current for first stimulus");
 %savefig('Part_a_I1');
 figure,plot(t,sum_current_2);
 title("Current for second stimulus");
 %savefig('Part_a_I2');
 v_out1 = aef(1,1,sum_current_1);
 figure,plot(v_out1);
 title("Spiking for first stimulus");
 %savefig('Part_a_Response_of_1st_stimulus');
 v_out2 = aef(1,1,sum_current_2);
 figure,plot(v_out2);
 title("Spiking for second stimulus");
 %savefig('Part_a_Response_of_2nd_stimulus');

%% Section 2 for parts b and c
flag = 0;
Count=0;
while(flag ==0)
    Count=Count+1;
    w1 = peakremoval(w0,spiketrain_2); %w1 after peak removal from 2nd stimulus
    sum_current_1 = zeros(1,5000);
    sum_current_2 = zeros(1,5000);
    for j = 1:100
        time_1 = [];
        time_2 = [];
        for i = 1:5000
    		if spiketrain_1(j,i) == 1
        		time_1 = [time_1; i*0.1];
            end
            if spiketrain_2(j,i) == 1
        		time_2 = [time_2; i*0.1];
            end
        end
        sum_current_1 = sum_current_1 + current(time_1, i_0, w1(j), tao, tao_s);
        sum_current_2 = sum_current_2 + current(time_2, i_0, w1(j), tao, tao_s);
    end
    figure,plot(t,sum_current_1);
    title("Current for first stimulus with w1");
    %savefig(sprintf('Part_c_I1_iteration_%d.fig', Count));
    figure,plot(t,sum_current_2);
    title("Current for second stimulus with w1");
    %savefig(sprintf('Part_c_I2_iteration_%d.fig', Count));
    v_output1 = aef(1,1,sum_current_1);
    v_output2 = aef(1,1,sum_current_2);
    
    for q=2:1:5001
        if (v_output1(1,q)> -0.035)
            flag = 1;
        end
    end
    if(flag == 0) %if no peak in first stimulus
         w2 = peakformer(w1,spiketrain_1); %w2 after peak formation from 1st stimulus
         sum_current_2 = zeros(1,5000);
         sum_current_1 = zeros(1,5000);
        for j = 1:100
            time_2 = [];
            time_1 = [];
            for i = 1:5000
                if spiketrain_2(j,i) == 1
                   time_2 = [time_2; i*0.1];
                end
                if spiketrain_1(j,i) == 1
                   time_1 = [time_1; i*0.1];
                end
            end
            sum_current_2 = sum_current_2 + current(time_2, i_0, w2(j), tao, tao_s);
            sum_current_1 = sum_current_1 + current(time_1, i_0, w2(j), tao, tao_s);
        end
        figure,plot(t,sum_current_2);
        title("Current in second stimulus after peak formation in 1st (w2)");
        %savefig(sprintf('Part_c_I2_iteration_%d_for_weight_2.fig', Count));
        figure,plot(t,sum_current_1);
        title("Current in first stimulus after peak formation in 1st (w2)");
        %savefig(sprintf('Part_c_I1_iteration_%d_for_weight_2.fig', Count));
        v_output22 = aef(1,1,sum_current_2);
        v_output11 = aef(1,1,sum_current_1);
        w0=w2; %updating w0 for the loop
    end
end
w_required_1 = w1;
figure,plot(v_output1);
title("Spiking for first stimulus with desired weights (Spikes)");
%savefig('Part_c_Response_of_1nd_stimulus_with_Spike');
figure,plot(v_output2);
title("Spiking for second stimulus with desired weights (No spikes)");
%savefig('Part_c_Response_of_2nd_stimulus_with_No_Spike');

  

%% Section 3 for part d
flag = 0;
Count = 0;
while(flag ==0)
    Count=Count+1;
    w1 = peakremoval(w0,spiketrain_1); %w1 after peak removal from 1nd stimulus
    sum_current_2 = zeros(1,5000);
    sum_current_1 = zeros(1,5000);
    for j = 1:100
        time_2 = [];
        time_1 = [];
        for i = 1:5000
    		if spiketrain_2(j,i) == 1
        		time_2 = [time_2; i*0.1];
            end
            if spiketrain_1(j,i) == 1
        		time_1 = [time_1; i*0.1];
            end
        end
        sum_current_2 = sum_current_2 + current(time_2, i_0, w1(j), tao, tao_s);
        sum_current_1 = sum_current_1 + current(time_1, i_0, w1(j), tao, tao_s);
    end
    figure,plot(t,sum_current_1);
    title("Current for first stimulus with w1");
    %savefig(sprintf('Part_d_I1_iteration_%d.fig', Count));
    figure,plot(t,sum_current_2);
    title("Current for second stimulus with w1");
    %savefig(sprintf('Part_d_I2_iteration_%d.fig', Count));
    v_output1 = aef(1,1,sum_current_1);
    v_output2 = aef(1,1,sum_current_2);
    
    for q=2:1:5001
        if (v_output2(1,q)> -0.035)
            flag = 1;
        end
    end
    if(flag == 0) %if no peak in second stimulus
         w2 = peakformer(w1,spiketrain_2);  %w2 after peak formation from 2st stimulus
         sum_current_1 = zeros(1,5000);
         sum_current_2 = zeros(1,5000);
        for j = 1:100
            time_1 = [];
            time_2 = [];
            for i = 1:5000
                if spiketrain_1(j,i) == 1
                   time_1 = [time_1; i*0.1];
                end
                if spiketrain_2(j,i) == 1
                   time_2 = [time_2; i*0.1];
                end
            end
            sum_current_1 = sum_current_1 + current(time_1, i_0, w2(j), tao, tao_s);
            sum_current_2 = sum_current_2 + current(time_2, i_0, w2(j), tao, tao_s);
        end
        figure,plot(t,sum_current_2);
        title("Current in second stimulus after peak formation in 1st (w2)");
        %savefig(sprintf('Part_d_I2_iteration_%d_for_weight_2.fig', Count));
        figure,plot(t,sum_current_1);
        title("Current in first stimulus after peak formation in 1st (w2)");
        %savefig(sprintf('Part_d_I1_iteration_%d_for_weight_2.fig', Count));
        v_output11 = aef(1,1,sum_current_1);
        v_output22 = aef(1,1,sum_current_2);
        w0=w2; %updating w0 for the loop
        
    end
end
w_required_2 = w1;
figure,plot(v_output1);
title("Spiking for first stimulus with desired weights ( No Spikes)");
%savefig('Part_d_Response_of_1nd_stimulus_with_No_Spike');
figure,plot(v_output2);
title("Spiking for second stimulus with desired weights (Spikes)");
%savefig('Part_d_Response_of_2nd_stimulus_with_Spike');

%%
display(w_required_1);
display(w_required_2);


