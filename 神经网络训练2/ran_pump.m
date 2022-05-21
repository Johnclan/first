function [a,b,c] = ran_pump()
zero = 10^-10;
a = rand(1,1) * 6 - zero;
a = fix(a) + 1;
b = a;
c = a;
while b==a
    b = rand(1,1) * 6 - zero;
    b = fix(b) + 1;
end
while c==a||c==b
    c = rand(1,1) * 6 - zero;
    c = fix(c) + 1;
end
end

