%% simulacaoRatos: Simula distribuições, valor de criterio e calcula informação
% A proposta é verificar de forma teorica se o calculo faz sentindo
% Vitor Baggi - UFABC 2016

function [I] = simulacaoRatos(Nratos)	

%11/01/2016
%Programa de simulacao de calculo de informação, retorna uma matriz com dados de informação

% --- Constantes para simulação ---
N 		= 10000; 	 	% número de trials simuladas
Tm	 	= 1;			% valor médio da distribuição dos tempos de resposta dos ratos (ex. pressão na alavanca)

CV		= 0.15;			% coeficiente de variação - dp/med = lei de weber para tempo)
Tdp		= 1.2 * CV; 	% desvio padrão (dp) - não alterar, pois já é calculado em função da média

ITIm	= 2; 			% valor médio do ITI
ITIdp	= 4;			% desvio padrão do ITI

crit 	= 1.0; 			% critério de tempo para receber o reforço
Ncorrect = 5;			% número de tentativas corretas para detectar o aprendizado

% --- parametros para convlução ---
dt 		= 0.1;		% passo para gerar uma gaussiana e fazer a convolução
sigma 	= 0.2;		% desvio-padrão da gaussina para convolução


%ITI = 1; 		%fixando ITI como 1s
%IMPORTANTE:

%dados é a  matriz com todos os dados, veja:
%coluna 1: Informação
%coluna 2: Numero de Tentativas
%coluna 3: critério(tempo para receber comida)

I = NaN(Nratos,3);		% inicia o vertor para otimizar tempo 

for n = 1:Nratos %numero do rato	
	clear T; %zerar as tentativas
	clear USUS	;		
    clear E;
    
	I(n,3) = crit;    
    %I(n,2) = (rand*2000); %Gerando numero de tentativas para o aprendizado
    trials = abs(randn(N,1)*Tdp   + Tm); 	%Gerando uma distribuição randomica para trials de um rato
    ITI    = abs(randn(N,1)*ITIdp + ITIm); 	%Gerando uma distribuição randomica para os ITIs
    %I(n,3) = 1; %Gerando um criterio 
    %USUS = trials+ITI; %Gerando US-US
    ind = find(trials<crit);				% encontra trials onde não houve reforço
    indCorrect = find(diff(ind)>Ncorrect,1);	% encontra trials corretas consecutivas
    if isempty(indCorrect)
    	disp('Ponto de mudança não encontrado');
    else
    	I(n,2) = indCorrect+1+Ncorrect;		% encontra o último ponto das tentativas corretas consecutivas 
    	trials = trials(1:I(n,2));			% reduz trials até o ponto de mudança
    	T = trials(trials>=I(n,3));
    	E = trials(trials<I(n,3));
    	USUS = geraDistribuicaoUS(trials,ITI,crit);
    	if ~isnan(USUS)
    		I(n, 1) = CEH_VBA_v4(T, E, USUS, dt, I(n,3),sigma);	%Calculando Informação do rato
    	else
    		disp('Encontradas menos de duas tentativas reforçadas');
    	end
    end
end    


function USUS = geraDistribuicaoUS(t,iti,crit)

prims = find(t>crit,1);			% primeira tentativa reforçada
if isempty(prims) 
	USUS = NaN;
	return;
end

t 	= t(prims:end);				% elimina tentativas não reforçadas no inicio
iti = iti(prims:end);

prims = find(t>crit,2);
if(length(prims)<2)
	USUS = NaN;
	return;
end

k=1;
do
	prim = prims(1);
	seg  = prims(2);	
	USUS(k) = sum(t(prim+1:seg)) + sum(iti(prim:seg-1));
	t 	=   t(seg:end);
	iti = iti(seg:end);
	prims = find(t>crit,2);
	k = k+1;
until (length(prims)<2);

