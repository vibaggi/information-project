%% simulacaoRatos: Simula distribuições, valor de criterio e calcula informação
% A proposta é verificar de forma teorica se o calculo faz sentindo
% 

function [I] = simulacaoRatos(numeros)	

%11/01/2016
%Programa de simulacao de calculo de informação, retorna uma matriz com dados de informação

sigma = 0.2;
ITI = 1; %fixando ITI como 1s
%IMPORTANTE:

%dados é a  matriz com todos os dados, veja:
%coluna 1: Informação
%coluna 2: Numero de Tentativas
%coluna 3: critério(tempo para receber comida)


for n = 1:numeros %numero do rato	

  
		clear T; %zerar as tentativas
		clear USUS	;		
    clear E;
    
    try
        I(n,2) = (rand*2000); %Gerando numero de tentativas para o aprendizado
        tries = randn(I(n,2),1)*0.5 + 1.2; %Gerando uma distribuição randomica para um rato
        I(n,3) = 1; %Gerando um criterio 
        USUS = tries+ITI; %Gerando US-US
        T = tries(tries>=I(n,3));
        E = tries(tries<I(n,3));
        I(n, 1) = CEH_VBA_v4(T, E, USUS, 0.1, I(n,3),sigma);	%Calculando Informação do rato
    catch
        T
        E
        USUS      
    end    
	end
	