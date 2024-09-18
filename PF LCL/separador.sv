module separador(
    input wire clk,
	 input wire modo_relogio,
    input wire modo_cronometro,
    input wire modo_timer,
	 input wire modo_ajuste_relogio,
    input wire modo_ajuste_timer,

    input wire [3:0] modo_relogio_hour_tens,
    input wire [3:0] modo_relogio_hour_units,
    input wire [3:0] modo_relogio_min_tens,
    input wire [3:0] modo_relogio_min_units,
    input wire [3:0] modo_relogio_sec_tens,
    input wire [3:0] modo_relogio_sec_units,

    input wire [3:0] modo_cronometro_hour_tens,
    input wire [3:0] modo_cronometro_hour_units,
    input wire [3:0] modo_cronometro_min_tens,
    input wire [3:0] modo_cronometro_min_units,
    input wire [3:0] modo_cronometro_sec_tens,
    input wire [3:0] modo_cronometro_sec_units,

    input wire [3:0] modo_timer_hour_tens,
    input wire [3:0] modo_timer_hour_units,
    input wire [3:0] modo_timer_min_tens,
    input wire [3:0] modo_timer_min_units,
    input wire [3:0] modo_timer_sec_tens,
    input wire [3:0] modo_timer_sec_units,

    input wire [3:0] ajuste_relogio_hour_tens,
    input wire [3:0] ajuste_relogio_hour_units,
    input wire [3:0] ajuste_relogio_min_tens,
    input wire [3:0] ajuste_relogio_min_units,
    input wire [3:0] ajuste_relogio_sec_tens,
    input wire [3:0] ajuste_relogio_sec_units,

    input wire [3:0] ajuste_timer_hour_tens,
    input wire [3:0] ajuste_timer_hour_units,
    input wire [3:0] ajuste_timer_min_tens,
    input wire [3:0] ajuste_timer_min_units,
    input wire [3:0] ajuste_timer_sec_tens,
    input wire [3:0] ajuste_timer_sec_units,

    output reg [3:0] hour_tens,
    output reg [3:0] hour_units,
    output reg [3:0] min_tens,
    output reg [3:0] min_units,
    output reg [3:0] sec_tens,
    output reg [3:0] sec_units
);


always @(*) begin
    case (1'b1) // Escolhe sempre o caso que corresponde ao valor verdadeiro das condições abaixo
        modo_relogio: begin
            hour_tens <= modo_relogio_hour_tens;
            hour_units <= modo_relogio_hour_units;
            min_tens <= modo_relogio_min_tens;
            min_units <= modo_relogio_min_units;
            sec_tens <= modo_relogio_sec_tens;
            sec_units <= modo_relogio_sec_units;
        end
        modo_cronometro: begin
            hour_tens <= modo_cronometro_hour_tens;
            hour_units <= modo_cronometro_hour_units;
            min_tens <= modo_cronometro_min_tens;
            min_units <= modo_cronometro_min_units;
            sec_tens <= modo_cronometro_sec_tens;
            sec_units <= modo_cronometro_sec_units;
        end
        // Caso desejado: Remova comentários e corrija conforme necessário
       
        modo_timer: begin
            hour_tens <= modo_timer_hour_tens;
            hour_units <= modo_timer_hour_units;
            min_tens <= modo_timer_min_tens;
            min_units <= modo_timer_min_units;
            sec_tens <= modo_timer_sec_tens;
            sec_units <= modo_timer_sec_units;
        end
        modo_ajuste_relogio: begin
            hour_tens <= ajuste_relogio_hour_tens;
            hour_units <= ajuste_relogio_hour_units;
            min_tens <= ajuste_relogio_min_tens;
            min_units <= ajuste_relogio_min_units;
            sec_tens <= ajuste_relogio_sec_tens;
            sec_units <= ajuste_relogio_sec_units;
        end
        modo_ajuste_timer: begin
            hour_tens <= ajuste_timer_hour_tens;
            hour_units <= ajuste_timer_hour_units;
            min_tens <= ajuste_timer_min_tens;
            min_units <= ajuste_timer_min_units;
            sec_tens <= ajuste_timer_sec_tens;
            sec_units <= ajuste_timer_sec_units;
        end
        
        default: begin
            hour_tens <= 4'd9;
            hour_units <= 4'd9;
            min_tens <= 4'd9;
            min_units <= 4'd9;
            sec_tens <= 4'd9;
            sec_units <= 4'd9;
        end
    endcase
end

endmodule
