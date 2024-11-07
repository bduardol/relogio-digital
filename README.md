
Projeto de um relógio digital feito na matéria de Laboratório de circuito digitais do semestre 2024.1.

---

Todas as postas que ultilizava as chavez KEY[n] foram trocadas para chaves SW[n]. O motivo dessa troca é alguns bugs que estava ocorrendo ao usar os botões KEY.

As chaves são respectivamente:

SW[17:15] = Controlador dos modos do sistema:


MODOS:

Modo relógio:
SW[17], SW[16], SW[15] = {0, 0, 0}
Modo cronometro:
SW[17], SW[16], SW[15] = {0, 0, 1}
Modo timer:
SW[17], SW[16], SW[15] = {0, 1, 0}
Modo ajuste do relógio:
SW[17], SW[16], SW[15] = {1, 0, 0}
Modo ajuste do timer:
SW[17], SW[16], SW[15] = {1, 1, 0}

---

Controles:

Reset:
SW[6] = {1} // Se SW6 = 1 no modo cronometro, ele é reiniciado. Se SW6 = 1 durante 2s todo o sistema é reiniciado.

Set:
SW[8] = {1} // Se SW8 = 1, quando da borda de subida, o valor é setado.

Stop/Start(running):
SW[7] = {1} // Se SW7 = 1, o sistema esta em start, o sistema esta em stop.

Configuração das horas:
{SW[5],SW[4],SW[3],SW[2],SW[1],SW[0]} definição da hora do relógio e da hora do timer

---

Instruções para rodas o sistema:

Os códigos são dividido em módulos, escritos em verilog. Para rodas o sistema completo, deve ser compilado e carregado na placa o arquivo Teste.bdf. Esse arquivo é o editor gráfico onde todos os componentes foram interligado, para funcionamento do sistema. As funcionalidades podem ser rodadas usando as chaves, como especificado a cima.

