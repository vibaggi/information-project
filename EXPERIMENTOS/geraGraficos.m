function [] = geraGraficos(I)
%Informe uma matriz  I com as seguintes colunas
%coluna 1: Informação
%coluna 2: Numero de Tentativas
%coluna 3: critério(tempo para receber comida)

iAux = I(I(:,3)<=1.19,:)
iAux = iAux(iAux(:,3)>=1.09,:);

	figure; 
	plot(iAux(:,2), iAux(:,1), 'g.');hold on;
	plot( I(I(:,3)>1.19,2), I(I(:,3)>1.19,1), 'r.');	hold on;
	plot(I(I(:,3)<1.09,2), I(I(:,3)<1.09,1), 'b.');	
	

	xlabel('Tentativas','FontSize',22);
	ylabel('Informacao','FontSize',22);
	sigLabel = 'Informacao em funcao do numero de tentativas';
	title(sigLabel, 'FontSize', 20);
 	legenda1 = legend ('Criterio 1.1~1.2s','Criterio > 1.2s', 'Criterio < 1.1s');
 	set(legenda1, 'fontsize',18)

	figure;
	loglog(iAux(:,2), iAux(:,1), 'g.');hold on;
	loglog(  I(I(:,3)>1.19,2), I(I(:,3)>1.19,1), 'r.');hold on;
	loglog( I(I(:,3)<1.09,2), I(I(:,3)<1.09,1), 'b.');
	xlabel('Tentativas','FontSize',22);
	ylabel('Informacao','FontSize',22);
	sigLabel = 'Informacao em funcao do numero de Tentativas Escala Log';
	title(sigLabel, 'FontSize', 20);
	legenda2 = legend('Criterio 1.1~1.2s','Criterio > 1.2s', 'Criterio < 1.1s');
  	set(legenda2, 'fontsize', 18)
