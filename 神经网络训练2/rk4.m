function y = rk4(x,y0,y_d,dir,C,loss)
h = x(2)-x(1);
n = length(x);
if dir == 0%forward
    y(1,:) = y0;
    for i=1:(n-1)
        k1=dydx(x(i),y(i,:),y_d(i,:),C,loss);
        k2=dydx(x(i)+h/2,y(i,:)+h*k1/2,y_d(i,:),C,loss);
        k3=dydx(x(i)+h/2,y(i,:)+h*k2/2,y_d(i,:),C,loss);
        k4=dydx(x(i)+h,y(i,:)+h*k3,y_d(i,:),C,loss);
        y(i+1,:)=y(i,:)+h*(k1+2*k2+2*k3+k4)/6;
    end
else
    y(n,:) = y0;
    for i=1:(n-1)
        k1=dydx(x(n+1-i),y(n+1-i,:),y_d(n+1-i,:),C,loss);
        k2=dydx(x(n+1-i)+h/2,y(n+1-i,:)+h*k1/2,y_d(n+1-i,:),C,loss);
        k3=dydx(x(n+1-i)+h/2,y(n+1-i,:)+h*k2/2,y_d(n+1-i,:),C,loss);
        k4=dydx(x(n+1-i)+h,y(n+1-i,:)+h*k3,y_d(n+1-i,:),C,loss);
        y(n-i,:)=y(n+1-i,:)+h*(k1+2*k2+2*k3+k4)/6;
    end
end