function [a,b,c,x,y_f,y_b] = func(InitPower,PumpWavelength,PumpPower,FiberLength,N,coe)
signal = InitPower*0.001;
C = Raman_C(coe,PumpWavelength);
lossdb = [0.218 0.182 0.182 0.182 0.182 0.182 zeros(1,length(signal))+0.154]/1000;
loss = 1-power(10,-lossdb/10);
l = 15;
while l == 15
    a = 3;
    b = 4;
    c = 5;
    pump_forward = zeros(1,6);
    pump_backward = zeros(1,6);
    for i=1:6
        if i==a||i==b||i==c
            pump_forward(i) = PumpPower(i);
        else
            pump_backward(i) = PumpPower(i);
        end
    end
    x = linspace(0,FiberLength,N);
    y_forward = zeros(length(x),length(PumpPower)+length(signal));
    y_backward = zeros(length(x),length(PumpPower)+length(signal));
    eps = 5 * 10^-5;
    for l=1:15
        y_forward1 = rk4(x,[pump_forward signal],y_backward,0,C,loss);
        y_forward = 0.5*y_forward1+0.5*y_forward;
        
        y_backward1 = rk4(x,[pump_backward zeros(1,length(signal))],y_forward,1,C,loss);
        y_backward = 0.5*y_backward1+0.5*y_backward;
        
        flag11 = y_forward(end,10);
        flag12 = y_backward(1,1);
        y_forward1 = rk4(x,[pump_forward signal],y_backward,0,C,loss);
        y_forward = 0.5*y_forward1+0.5*y_forward;
        
        y_backward1 = rk4(x,[pump_backward zeros(1,length(signal))],y_forward,1,C,loss);
        y_backward = 0.5*y_backward1+0.5*y_backward;
        
        flag21 = y_forward(end,10);
        flag22 = y_backward(1,1);
        
        
        flag_1 = abs(flag11-flag21)/flag11;
        flag_2 = abs(flag12-flag22)/flag12;
        if flag_1<=eps
            if flag_2<=eps
                disp(l);
                disp(flag_1);
                disp(flag_2);
                break;
            end
        end
    end
end
y_f = 10*log10(y_forward*1000);
y_b = 10*log10(y_backward*1000);
end