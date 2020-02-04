function result = runge_kutta(n, V_init, I, h)
V=V_init;
C=300e-12;
G_l=30e-9;
V_t=20e-3;
E_l=-70e-3;
result=zeros(n,5000);
result(:,1)=V;

for j=2:1:5000
    result(:,j)=V;
    der_1=(-G_l/C).*(V) + ((G_l*E_l)/C) + I/C;
    k1=h.*der_1;
    V=V+(k1./2);
    der_2=(-G_l/C).*(V) + ((G_l*E_l)/C) + I/C;
    k2=h.*der_2;
    result(:,j)=result(:,j)+k2;
    for k=1:1:n
        if result(k,j)>V_t
            result(k,j)=E_l;
        end
    end
    V=result(:,j);
end
