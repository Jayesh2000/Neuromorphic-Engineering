function result1 = runge_kutta(mode, V_init, U_init, I, h)
U=U_init;
V=V_init;
m=0.5/h;
result1=zeros(size(mode,1),m);
result2=zeros(size(mode,1),m);

result1(:,1)=V;
result2(:,1)=U;
for j=2:1:m
    result1(:,j)=V;
    result2(:,j)=U;
    der_1=getderivative(mode, U, V, I);
    k1=h.*der_1;
    der_2=getderivative(mode, U+(k1(:,2)/2), V+(k1(:,1)/2), I);
    k2=h.*der_2;
    der_3=getderivative(mode, U+(k2(:,2)/2), V+(k2(:,1)/2), I);
    k3=h.*der_3;
    der_4=getderivative(mode, U+(k3(:,2)), V+(k3(:,1)), I);
    k4=h.*der_4;
    result1(:,j)=result1(:,j) + ((k1(:,1) + 2*k2(:,1) + 2*k3(:,1) +k4(:,1))./6);
    result2(:,j)=result2(:,j) + ((k1(:,2) + 2*k2(:,2) + 2*k3(:,2) +k4(:,2))./6);
    for k=1:1:size(mode,1)
        if (mode(k,1)==1)
            v_peak=35e-3;
            if result1(k,j)>v_peak
                result1(k,j)=-50e-3;
                result1(k,j-1)=v_peak;
                result2(k,j)=result2(k,j)+100e-12;
            end
        end
        if (mode(k,1)==2)
            v_peak=50e-3;
            if result1(k,j)>v_peak
                result1(k,j)=-56e-3;
                result1(k,j-1)=v_peak;
                result2(k,j)=result2(k,j)+130e-12;
            end
        end
        if (mode(k,1)==3)
            v_peak=25e-3;
            if result1(k,j)>v_peak
                result1(k,j)=-40e-3;
                result1(k,j-1)=v_peak;
                result2(k,j)=result2(k,j)+150e-12;
            end
        end
    end
    U=result2(:,j);
    V=result1(:,j);
end
    
    