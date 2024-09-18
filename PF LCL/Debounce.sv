module Debounce (
    input wire clk,           // Clock do sistema, 1 Hz
    input wire reset,         // Sinal de reset externo
    input wire noisy_signal,  // Sinal de entrada "barulhento" (ex.: botão)
    output reg stable_signal  // Sinal de saída "estável"
);

// Parâmetros configuráveis
parameter DEBOUNCE_SEC = 2;  // Tempo em segundos para estabilizar o sinal

// Variáveis internas
reg [1:0] counter;           // Contador para segundos, assume-se que 2 segundos são suficientes
reg prev_signal;             // Armazena o estado anterior do sinal para detectar mudanças

always @(posedge clk or posedge reset) begin
    if (reset) begin
        stable_signal <= 0;
        counter <= 0;
        prev_signal <= noisy_signal;
    end else begin
        if (noisy_signal != prev_signal) begin
            // Reinicia o contador se o sinal mudar
            counter <= 0;
            prev_signal <= noisy_signal;
        end else if (counter < DEBOUNCE_SEC) begin
            // Incrementa o contador se o sinal for constante
            counter <= counter + 1;
        end else begin
            // Atualiza o sinal estável quando o contador atinge o tempo definido
            stable_signal <= prev_signal;
        end
    end
end

endmodule
