n=3;
I=200e-12;
mode=zeros(n,1);
mode(1,1)=1;
mode(2,1)=1;
mode(3,1)=2;
U_init=zeros(n,1);
V_init=zeros(n,1);
for k=1:1:size(mode,1)
        if (mode(k,1)==1)
                V_init(k,1)=-50e-3;
                U_init(k,1)=-0.6e-12;
        end
        if (mode(k,1)==2)
                V_init(k,1)=-56e-3;
                U_init(k,1)=0.95e-12;
        end
        if (mode(k,1)==3)
                V_init(k,1)=-40e-3;
                U_init(k,1)=0.6e-12;
        end
end
result=runge_kutta(mode,V_init, U_init, I, 0.0001);
plot(result(1,:));
