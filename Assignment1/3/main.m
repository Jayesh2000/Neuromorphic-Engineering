i_c1 = 250*10^-12;
i_c2 = 350*10^-12;
i_c3 = 450*10^-12;
current_1 = ones(3,5001)*i_c1;
current_2 = ones(3,5001)*i_c2;
current_3 = ones(3,5001)*i_c3;
n_p = [1;2;3];

aef(n_p,3,current_1,1);
aef(n_p,3,current_2,2);
aef(n_p,3,current_3,3);




















