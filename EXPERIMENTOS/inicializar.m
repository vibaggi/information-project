
%Executa os arquivos funções criado
%Primeiro precisamos obter a informação dos ratos

I = calculadoraDeInformacao('AB1',74,5);
%Precisamos passar os parametros: prefixo, numero de ratos e numero de tentativas 
%consecutivas que consideramos que ocorroeu o aprendizado 

%Note que a função acima pode facilmente ser manipulada caso exista outras séries de ratos a se analisar

%A função retorna uma matriz com trez colunas:
%coluna 1: Informação
%coluna 2: Numero de Tentativas
%coluna 3: critério(tempo para receber comida)

%%IMPORTANTE: O arquivo CEH_VBA_v2 deve estar junto com o arquivo a cima
%Também é necessário que os arquivos.mat estejam na mesma pasta

geraGraficos(I);
%É necessário apenas enviar a matriz contendo duas colunas: A primeira informação a segunda numero de tentativas