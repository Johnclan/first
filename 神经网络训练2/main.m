coe = readmatrix('coefficients');
SignalWavelength = linspace(1535,1605,30);
PumpWavelength = [1364 1425 1439 1452 1465 1495];
times = 10000;
SPV = zeros(1,times);
trainDataIn = zeros(times,60);
trainDataOut = zeros(times,5);
FiberLength=102880;
N = 100;
fidin=fopen('trainDataIn.txt','wt+');
fidout=fopen('trainDataOut.txt','wt');
parfor i = 1:times
    InitPower = rand(1,30);
    PumpPower = rand(1,6)./ 2;
    PumpPower(1) = 0.8;
    for k = 1:5
        PumpPower(k+1) = PumpPower(k+1)/2.5 + 0.05;
    end
    [a,b,c,x,y_f,y_b] = func(InitPower,PumpWavelength,PumpPower,FiberLength,N,coe);
    SPV(i) = max(max(y_f(:,7:end))-min(y_f(:,7:end)));
    %     for m = 1:30
    %         fprintf(fidin,'%7.3f ',InitPower(m));
    %     end
    %     for l = 1:29
    %         fprintf(fidin,'%7.3f ',gain(l));
    %     end
    %     fprintf(fidin,'%7.3f\n',gain(30));
    %     for j = 1:5
    %         fprintf(fidout,'%4.2f ',PumpPower(j+1));
    %     end
    %     fprintf(fidout,'\n');
    trainDataIn(i,:) = [InitPower(1:30) y_f(end,7:end)];
    trainDataOut(i,:) = PumpPower(2:6);
    disp(i);
end
for i=1:times
    for j=1:60
        if j==60
        fprintf(fidin,'%7.3f\n',trainDataIn(i,j));
        else
            fprintf(fidin,'%7.3f ',trainDataIn(i,j));
        end
    end
    for j=1:5
        if j==5
            fprintf(fidout,'%4.2f\n',trainDataOut(i,j));
        else
            fprintf(fidout,'%4.2f ',trainDataOut(i,j));
        end
    end
end
fclose('all');