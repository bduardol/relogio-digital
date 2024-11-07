
Projeto de um relógio digital feito na matéria de Laboratório de circuito digitais do semestre 2024.1.

---

Todas as portas que utilizavam as chaves `KEY[n]` foram trocadas para chaves `SW[n]`. O motivo dessa troca são alguns bugs que estavam ocorrendo ao usar os botões `KEY`.

As chaves são respectivamente:

`SW[17:15]` = Controlador dos modos do sistema:

## MODOS:

- **Modo relógio:** `SW[17]`, `SW[16]`, `SW[15]` = `{0, 0, 0}`
- **Modo cronômetro:** `SW[17]`, `SW[16]`, `SW[15]` = `{0, 0, 1}`
- **Modo timer:** `SW[17]`, `SW[16]`, `SW[15]` = `{0, 1, 0}`
- **Modo ajuste do relógio:** `SW[17]`, `SW[16]`, `SW[15]` = `{1, 0, 0}`
- **Modo ajuste do timer:** `SW[17]`, `SW[16]`, `SW[15]` = `{1, 1, 0}`

---

## Controles:

- **Reset:** `SW[6] = {1}` // Se `SW6 = 1` no modo cronômetro, ele é reiniciado. Se `SW6 = 1` por 2s, todo o sistema é reiniciado.
  
- **Set:** `SW[8] = {1}` // Se `SW8 = 1`, na borda de subida, o valor é setado.

- **Stop/Start (running):** `SW[7] = {1}` // Se `SW7 = 1`, o sistema está em start; caso contrário, o sistema está em stop.

- **Configuração das horas:** `{SW[5], SW[4], SW[3], SW[2], SW[1], SW[0]}` definição da hora do relógio e da hora do timer.

---

## Instruções para rodar o sistema:

Os códigos são divididos em módulos, escritos em Verilog. Para rodar o sistema completo, deve-se compilar e carregar na placa o arquivo `Teste.bdf`. Esse arquivo é o editor gráfico onde todos os componentes foram interligados para o funcionamento do sistema. As funcionalidades podem ser rodadas usando as chaves, conforme especificado acima.
