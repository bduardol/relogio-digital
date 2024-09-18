module play_pause (
    input wire clk,          // Clock do sistema
    input wire reset,        // Sinal de reset externo
    input wire key3,         // Sinal do botão para alternar play/pause
    output reg running    // Sinal de saída indicando se está em play (1) ou pause (0)
);

// Variável interna para armazenar o estado anterior do botão para detecção de borda
reg key3_prev;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        running <= 0;      // Começa no estado de pause
        key3_prev <= 0;       // Inicializa o estado anterior como 0
    end else begin
        if (key3 == 1 && key3_prev == 0) begin
            running <= ~running;  // Alterna o estado se uma borda de subida for detectada
        end
        key3_prev <= key3;    // Atualiza o estado anterior do botão
    end
end

endmodule