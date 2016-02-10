#information-project 
Data: 06/02/2016

Objetivo: Estudar e desenvolver algoritmos capazes de calcular a Informação absorvida por um animal aplicado determinado experimento. Se possivel desenvolver um preditor de aprendizagem.

Aqui, reunimos esforços para aplicar a Teoria da Informação de Claude Shannon em tarefas DRRD complexas.  

Estou trabalhando com duas linhas de cálculo:

A primeira, que está no master e a que dá um melhor resultado, considera a existencia de dois estimulos US, um quando vem comida US+ e um quando não vem US-. Os intervalos US-US nesse caso é entre um US e outro, independente do tipo.
 I = H(USUS) - (H(T) + H(E))

A segunda, tem as mesmas considerações, porém os intervalos US-US só consideram o (US+)

	I =H(US+US+)- (H(T) + H(E))
	