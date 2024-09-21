module inicial(
    input wire clk,
    input wire reset,
    input wire SW2,   // Bit 2 de SW
    input wire SW1,   // Bit 1 de SW
    input wire SW0,   // Bit 0 de SW

    output reg modo_relogio,
    output reg modo_cronometro,
    output reg modo_timer,
    output reg modo_ajuste_relogio,
    output reg modo_ajuste_timer

);

reg [2:0] last_state;  // Armazenar o último estado baseado em SW2, SW1, SW0

always @(posedge clk or posedge reset) begin
    if (reset) begin
        last_state <= 3'b000;  // Reset state
    end else begin
        last_state <= {SW2, SW1, SW0};
    end
end

always @(*) begin    
    // Define os modos com base nos switches
    modo_relogio = (SW2 == 0 && SW1 == 0 && SW0 == 0);
    modo_cronometro = (SW2 == 0 && SW1 == 0 && SW0 == 1);
    modo_timer = (SW2 == 0 && SW1 == 1 && SW0 == 0);
    modo_ajuste_relogio = (SW2 == 1 && SW1 == 0 && SW0 == 0);
    modo_ajuste_timer = (SW2 == 1 && SW1 == 1 && SW0 == 0);

end

endmodule

