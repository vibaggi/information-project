function [I] = CEH_VBA_v4(T, Tn, ITI, dt, valCriterio,sigma)
% código readaptado em 02/07/2015	
% Gets a series of bins with zeros and ones and calculates its entropy
% Marcelo Bussotti Reyes - 10/2014
% Vitor Baggi de Almeida - 03/2015 - 07/2015
% Universidade Federal do ABC
% Calculates the entropy of a random variable based on samples (x).
% dt is the bin size for the histogram calculation

%T são as tentativas: intervalo CS-US
%ITI é o intervalo US-US
%valCriterio é o valor do tempo para a tentativa ser reforçada

T = T(T>0);
Tn = Tn(Tn>0);
ITI = ITI(ITI>0); 

rng = 0:dt:max(T);	
         
gaussT = dt/sqrt(2*pi())/sigma*exp(-0.5*((rng-mean(rng))/sigma).^2);
gaussTn = dt/sqrt(2*pi())/sigma*exp(-0.5*((rng-mean(rng))/sigma).^2);

%Rng para ITI

%colocar 10% da mediana no sigma da gaussiana que alisa a distribuição dos DTs.
dtITI = (dt*median(ITI));
rngITI = 0:dtITI:max(ITI);	
sigmaITI = sigma*median(ITI);
gaussITI = dtITI/sqrt(2*pi())/sigmaITI*exp(-0.5*((rngITI-mean(rngITI))/sigmaITI).^2);

% Calculates the bins for histogram calculation

countT   = histc(T,rng);		% counting the frequency for each bin
countTn  = histc(Tn,rng);		% counting the frequency for each bin
countITI = histc(ITI, rngITI);


% fazendo a convolução das funcões
d = conv(countT,gaussT,'same');   % convolves the histogram counts with a gaussian for smoothig
dn = conv(countTn,gaussTn,'same');
d2 = conv(countITI,gaussITI,'same');   % convolves the histogram counts with a gaussian for smoothig

d = d/length(T)/dt;				% normalizing
dn = dn/length(Tn)/dt;		
d2 = d2/length(ITI)/dtITI;


%valores iguais a zero resultaram em erro no calculo da entropia se nao
%forem tratatos e excluidos!!!
d   = d(d>0);	
dn   = dn(dn>0);	
d2 = d2(d2>0);

entropyT = -dt*sum(d.*log2(d));
entropyTn = -dt*sum(dn.*log2(dn));
entropyITI = -dtITI*sum(d2.*log2(d2));

I = entropyITI - (entropyT + entropyTn);

