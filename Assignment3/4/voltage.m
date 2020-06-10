function [v_final, spike_times] = voltage(v_initial, i, N, e_l, v_th, h)

spike_times = zeros(N,1);
k1 = h*mem_der(v_initial,i, e_l);
k2 = h*mem_der(v_initial+k1, i, e_l);
v_final = v_initial +(k1 +k2)/2;
for n = 1:N
    if(v_final(n,1) > v_th)
        v_final(n,1) = e_l;
        spike_times(n,1) = 1;
    end
end
