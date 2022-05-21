function C = Raman_C(coe,PumpWavelength)
c = 3*10^8;
wavelength = [PumpWavelength linspace(1535,1605,30)];
f = c./wavelength.*10^9/10^11;
C = zeros(length(wavelength));
Aeff = 119e-12;
for i = 1:length(wavelength)
    for j = 1:length(wavelength)
        if round(f(i)-f(j)) == 0
            C(i,j) = 0;
        elseif f(i)>f(j)
            if (f(i)-f(j))>421
                C(i,j) = 0;
            else
                C(i,j) = -f(i)/f(j)*coe(round(f(i)-f(j)))/2/Aeff;
            end
        elseif f(i)<f(j)
            if (f(j)-f(i))>421
                C(i,j) = 0;
            else
                C(i,j) = coe(round(f(j)-f(i)))/2/Aeff;
            end
        else
            C(i,j)=0;
        end
    end
end