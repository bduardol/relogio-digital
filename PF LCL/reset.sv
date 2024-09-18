module reset(
    input wire clk,             // Clock com pulso de 1 segundo
    input wire reset,    // Botão de reset
          
    output reg reset_relogio,   // Reset para o módulo do relógio
    output reg reset_cronometro,// Reset para o módulo do cronômetro
    output reg reset_timer      // Reset para o módulo do timer
);

reg [1:0] count = 0;  // Contador para monitorar o número de segundos com reset pressionado

initial begin
    reset_relogio = 0;
    reset_cronometro = 0;
    reset_timer = 0;
end


always @(posedge clk) begin
    if (reset) begin
        if (count < 2) begin
            count <= count + 1;  // Incrementa o contador se menor que 2
        end
    end else begin
        count <= 0;  // Reseta o contador se o reset for desativado
    end
    
    // Atualiza os sinais de reset com base no valor do contador
    if (count >= 2) begin
        reset_relogio <= 1;
        reset_cronometro <= 1;
        reset_timer <= 1;
    end else begin
        reset_relogio <= 0;
        reset_cronometro <= 0;
        reset_timer <= 0;
    end
end

endmodule
