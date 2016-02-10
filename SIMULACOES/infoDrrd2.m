N = 1000;
t = randn(N,1)*0.2+0.5;			% random var. mimicing the rat responses
t = t+abs(min(t))*1.1; 			% just a trick to avoid negatives
i = 1;							% ITI, simulated as a fixed value
crit = 0.1:0.01:max(t) ; 					% simulating the criterion for receiving food
USUS = t+1;

for z = 1:length(crit) 

  US = t(t>=crit(z));		% find index for trials longer than criterion
  E = t(t<crit(z));
  informacao(z) = CEH_VBA_v4(US,E, USUS,0.1,crit(z),0.2);
  
end

plot(crit, informacao,'.');
xlabel('Tempo de criterio')
ylabel('Informacao')
title('Variacao da Informacao em funcao da variacao do criterio')