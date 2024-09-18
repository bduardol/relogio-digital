module ajuste_timer(
    input wire clk,
    input wire reset,
    input wire sw5,  // Bit 5 de SW
    input wire sw4,  // Bit 4 de SW
    input wire sw3,  // Bit 3 de SW
    input wire sw2,  // Bit 2 de SW
    input wire sw1,  // Bit 1 de SW
    input wire sw0,  // Bit 0 de SW
    input wire set,  // Botão para alternar os modos de ajuste
    input wire ajMod, // Sinal para habilitar o modo de ajuste
    output reg [3:0] hou_tens,
    output reg [3:0] hou_units,
    output reg [3:0] min_tens,
    output reg [3:0] min_units,
    output reg [3:0] sec_tens,
    output reg [3:0] sec_units
);

    reg [1:0] ajuste_mode;
    reg set_prev;
    reg set_edge;
    reg [23:0] blink_counter;
    reg blink_state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Prioridade para o reset
            set_prev <= 0;
            ajuste_mode <= 0;
            blink_counter <= 0;
            blink_state <= 0;
            hou_tens <= 2;  // Ajustar para hora inicial, se necessário
            hou_units <= 3;
            min_tens <= 5;
            min_units <= 9;
            sec_tens <= 5;
            sec_units <= 9;
        end else if (ajMod) begin  // Modo ajuste é ativado
            // Lógica de ajuste e transição entre horas, minutos e segundos
            set_prev <= set;
            set_edge <= set && !set_prev;

            if (set_edge) begin
                ajuste_mode <= ajuste_mode + 1;
                if (ajuste_mode > 2) begin
                    ajuste_mode <= 0;
                end
            end

            // Controla o pisca-pisca
            if (blink_counter >= 50000000) begin
                blink_counter <= 0;
                blink_state <= !blink_state;
            end else begin
                blink_counter <= blink_counter + 1;
            end

            // Alterna entre ajustar horas, minutos e segundos
            case (ajuste_mode)
                0: begin  // Ajuste de horas
                    hou_tens <= blink_state ? {sw5, sw4} : 4'hF;  // Combina sw5 e sw4 para dezenas
                    hou_units <= blink_state ? {sw3, sw2, sw1, sw0} : 4'hF; // Combina sw3..sw0 para unidades
                end
                1: begin  // Ajuste de minutos
                    min_tens <= blink_state ? {sw5, sw4} : 4'hF;
                    min_units <= blink_state ? {sw3, sw2, sw1, sw0} : 4'hF;
                end
                2: begin  // Ajuste de segundos
                    sec_tens <= blink_state ? {sw5, sw4} : 4'hF;
                    sec_units <= blink_state ? {sw3, sw2, sw1, sw0} : 4'hF;
                end
            endcase
        end
    end
endmodule
