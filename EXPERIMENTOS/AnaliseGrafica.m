function[] = AnaliseGrafica (numRato, amplitude, numSec)
%gerador de gráficos de média móvel

amp = amplitude; %Amplitude da média movel, quanto maior menos variavel fica.
prefix = 'AB1';
corLinha =['r','b','g','y', 'black', 'cyan'];


for n= 1:numSec 
  filename = ['matfiles/' prefix num2str(numRato, '%03.0f') '.' num2str(n, '%03.0f') '.mat']; 
	load (filename); 
  
  figure;
  
  plot(D(:,1),'.');
  xlabel('Tentativas','FontSize',20);
  ylabel('Tempo','FontSize',20);
  title(['media movel sessao' num2str(n,'%03.0f')]);
  hold on;
  plot(xlim, [D(1,5) D(1,5)],'r--');
  
  %tirando a media movel
  for x = 1:size(D(:,1))
    sum = 0;
    for y = 1:amp
      try
        sum = sum + D(x+y,1);
      catch
      end
    end
      media(x,n) = (sum/amp);
  end
  hold on;
  plot(media(:,n),'r');
  
  legend('Acao','valor de criterio','media movel');
  
end

%Aqui exibimos todas as medias moveis juntas
figure;
for n=1:numSec
  hold on;
  plot(media(:,n),corLinha(n));
  legenda(n,:) = ['sessao ' num2str(n, '%03.0f')];
end
legend(legenda);

hold on;
plot(xlim, [D(1,5) D(1,5)],'r--');
title('Comparacao medias moveis','FontSize',14);

xlabel('tentativas','FontSize',14);
ylabel('tempo','FontSize',14);



