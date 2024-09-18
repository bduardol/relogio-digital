module ajuste(
    input wire clk,
    input wire reset,
    input wire [3:0] dz,
    input wire [3:0] un,
    input wire ajMod,
    output reg [3:0] hou_tens,      // Dezenas das horas
    output reg [3:0] hou_units,     // Unidades das horas
    output reg [3:0] min_tens,      // Dezenas dos minutos
    output reg [3:0] min_units,     // Unidades dos minutos
    output reg [3:0] sec_tens,      // Dezenas dos segundos
    output reg [3:0] sec_units      // Unidades dos segundos
);

    reg [1:0] ajuste_mode;
    reg ajMod_prev;
    reg ajMod_edge;  // Declarado como 'reg' para uso dentro do bloco 'always'
    reg [23:0] blink_counter;  // Contador para o pisca-pisca
    reg blink_state;           // Estado do pisca-pisca (visível ou não)

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Resetar todos os estados e contadores
            ajMod_prev <= 0;
            ajuste_mode <= 0;
            ajMod_edge <= 0;
            blink_counter <= 0;
            blink_state <= 0;
            hou_tens <= 0;
            hou_units <= 0;
            min_tens <= 0;
            min_units <= 0;
            sec_tens <= 0;
            sec_units <= 0;
        end else begin
            ajMod_prev <= ajMod;
            ajMod_edge <= ajMod && !ajMod_prev;

            if (ajMod_edge) begin
                ajuste_mode <= ajuste_mode + 1;
            end

            // Atualizar o contador de pisca-pisca
            if (blink_counter >= 50000000) begin  // Ajustar para a frequência do clock
                blink_counter <= 0;
                blink_state <= !blink_state;  // Alternar o estado
            end else begin
                blink_counter <= blink_counter + 1;
            end

            case (ajuste_mode)
                2'b00: begin
                    if (dz < 4'd10) hou_tens <= blink_state ? dz : 4'hF;  // 4'hF para "apagar"
                    if (un < 4'd10) hou_units <= blink_state ? un : 4'hF;
                end
                2'b01: begin
                    if (dz < 4'd6) min_tens <= blink_state ? dz : 4'hF;
                    if (un < 4'd10) min_units <= blink_state ? un : 4'hF;
                end
                2'b10: begin
                    if (dz < 4'd6) sec_tens <= blink_state ? dz : 4'hF;
                    if (un < 4'd10) sec_units <= blink_state ? un : 4'hF;
                end
                default: begin
                    // Opcionalmente adicione um caso padrão para tratar valores inesperados
                end
            endcase
        end
    end
endmodule
