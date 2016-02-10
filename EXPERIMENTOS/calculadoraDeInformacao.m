%% calculadoraDeInformacao: Informe um prefixo da nomenclatura dos animais estudados
% e o numero de animais estudados
% Este é o formato que deve estar os arquivos.mat:
% 'AB0001.001' - AB0 é o prefixo, 001 é o numero do animal (pode-se numerar até 999)
% .001 é a sessão do animal
function [I] = calculadoraDeInformacao(prefixo, numeros, contagem)	

%contagem é o numero de repetições positivas que o animal deve fazer que voce
%considera que significa a aprendizagem. Tipicamente é 5.
%numeros é a quantidade de ratos!

%11/01/2016
%Programa para calculo de informação, retorna uma matriz com dados de informação
%Esse programa considera todos os estimulos (Reforço Positivo e Punição Negativa)
%  como sendo o mesmo reforço T
%Apenas essa consideração fez os dados serem mais próximos dos teóricos.

sigma = 0.5;
%IMPORTANTE:

%dados é a  matriz com todos os dados, veja:
%coluna 1: Informação
%coluna 2: Numero de Tentativas
%coluna 3: critério(tempo para receber comida)

%D é a matriz que é carregado automaticamente os dados dos ratos quando se faz load

%Análise:

for n = 1:numeros %numero do rato	

    matriz = [0 0 0 0 0 0]; %criando matriz 1x6 para pode-la concatenar sem erro
		clear T; %zerar as tentativas
    clear E;
    
    
		try
        for s = 1:5 %numero da sessao max 5 			
              filename = ['matfiles/' prefixo num2str(n, '%03.0f') '.' num2str(s, '%03.0f') '.mat'] ; 
              load (filename); %eventuais erros de dados necessitavam de tratamento
              
              %
              auxCont = 0;
              for i = 1:(length(D(:,3))-1)
                  
                  if (D(i,3)==1)
                    auxCont += 1;
                    if(auxCont == contagem)
                        break;
                    end 
                  else
                    auxCont = 0;
                  end    
              end 
              matriz = [matriz; D(1:i,:)]; %Adicionando o resto da matriz até o ponto de aprendizado
              if(auxCont == contagem)
                  break;
              end              
         end   
     catch
					disp(strcat( 'Nao foi possivel achar o rato: ', num2str(n)));
          disp('Pode estar faltando alguma sessao')
					continue;%Quebra laço de procura de dados							
		 end     
     
     try
         %matriz = matriz(find(matriz(:,5)==matriz(2,5)),:); %Aqui ele retira as tentativas após o ponto de aprendizado! 
         matriz = matriz(2:length(matriz(:,1)),:);
         %Inclusive a primeira linha de zeros usada para poder mesclar as matrizes some.
         I(n, 3) = matriz(1,5); %Gravando o critério do rato
         USUST = matriz( matriz(:,1) >= matriz(:,5),2 ) + matriz( matriz(:,1) >= matriz(:,5),1 ); %Calculando todo intervalo USUS
         USUSE = matriz( matriz(:,1) <  matriz(:,5),2 ) + matriz( matriz(:,1) <  matriz(:,5),1 );
         T = matriz(matriz(:,1)>=matriz(:,5)); %Separando reforço positivo
         E = matriz(matriz(:,1)<matriz(:,5));  %Separando reforço negativo
        
				%disp(USUST)
        %disp(USUSE)
      catch
				disp(strcat('Erro no calculo de informacao. Algum dado falta rato', num2str(n)));
			end	   
				 
       I(n, 1) = CEH_VBA_v4(T, E, USUST, USUSE, 0.1, I(n,3),sigma);	%Calculando Informação do rato
       I(n, 2) = length(matriz(:,1)); 
	end

