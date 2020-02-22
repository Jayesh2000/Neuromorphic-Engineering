function i = current(x, i_0,w_e,tao,tao_s)
		i = zeros(1,5000);
		m = length(x);
		tao = tao*10000;
		tao_s = tao_s*10000;
	for r = 1:m	
		current_r = zeros(1,5000);
		for t = 1:5000
			if(t < x(r)*10)
				current_r(t) = 0;
			elseif( t == x(r)*10)
				current_r(t) = 0;
			else
				current_r(t) = i_0*w_e*(exp(-1*(t-x(r)*10)/tao) - exp(-1*(t-x(r)*10)/tao_s));
			end
		end
		i = i + current_r;				 
	end
end	