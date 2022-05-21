function dy = dydx(~,y,y_d,C,loss)
BRS = [zeros(1,1) zeros(1,5)+4.5*10^(-8) zeros(1,30)]';
dy = ((C*(y+y_d)'-loss').*y'+ BRS.*y_d')';