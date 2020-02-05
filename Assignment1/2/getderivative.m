function y = getderivative(mode, U, V, I)
y=zeros(size(mode,1),2);
for i=1:1:size(mode,1)
    if (mode(i,1)==1) 
        C=100e-12;
        k_z=0.7e-6;
        E_r=-60e-3;
        E_t=-40e-3;
        a=0.03e3;
        b=-2e-9;
        %c=-50;
        %d=100;
        %v_peak=35;
    elseif (mode(i,1)==2) 
        C=150e-12;
        k_z=1.2e-6;
        E_r=-75e-3;
        E_t=-45e-3;
        a=0.01e3;
        b=5e-9;
        %c=-56;
        %d=130;
        %v_peak=50;
    elseif (mode(i,1)==3) 
        C=50e-12;
        k_z=1.5e-6;
        E_r=-60e-3;
        E_t=-40e-3;
        a=0.03e3;
        b=1e-9;
        %c=-40;
        %d=150;
        %v_peak=25;
    end
    y(i,1)=(k_z/C)*(V(i,1)-E_r)*(V(i,1)-E_t)-U(i,1)/C+(I/C);
    y(i,2)=a*(b*(V(i,1)-E_r)-U(i,1));
end
end
    

    