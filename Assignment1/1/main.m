n=3;
I=2800e-12;
V_init=zeros(n,1);
V_init(1,1)=-30e-3;
V_init(2,1)=-70e-3;
V_init(3,1)=10e-3;
result=runge_kutta(n,V_init,I,0.0001);
plot(result(1,:));