function [I] = CEH_VBA_ITIFIXO(T, ITI, dt, valCriterio,sigma)
%This function calculates the Information when CS-US(T) is variable and
%ITI is fixed. It's necessarly give dt, time of critery and sigma for convolution

T = T(T>0);

rng = 0:dt:max(T);	
         
gaussT = dt/sqrt(2*pi())/sigma*exp(-0.5*((rng-mean(rng))/sigma).^2);

% Calculates the bins for histogram calculation

countT   = histc(T,rng);		% counting the frequency for each bin


% fazendo a convolução das funcões
d = conv(countT,gaussT,'same');   % convolves the histogram counts with a gaussian for smoothig

d = d/length(T)/dt;				% normalizing


%valores iguais a zero resultaram em erro no calculo da entropia se nao
%forem tratatos e excluidos!!!
d   = d(d>0);	

entropyT = -dt*sum(d.*log2(d));


I =  log(ITI) - entropyT ;

