A = load('trainDataIn.txt');
A = A(:,31:end);
A = A' + 15.8435;
B = mean(A);
A = A';
WDG = zeros(1,numel(B));
for i = 1:numel(B)
    WDG(i) = max(A(i,:)) - min(A(i,:));
end