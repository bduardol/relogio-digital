module relogio_completo(
    input wire clk,
    input wire reset,
    input wire adjust,  // Sinal para ativar ajuste
    input wire set,  // Botão para alternar entre ajuste de horas, minutos e segundos
    input wire sw5,  // Bit 5 de SW
    input wire sw4,  // Bit 4 de SW
    input wire sw3,  // Bit 3 de SW
    input wire sw2,  // Bit 2 de SW
    input wire sw1,  // Bit 1 de SW
    input wire sw0,  // Bit 0 de SW

    output reg [3:0] hour_tens, 
    output reg [3:0] hour_units, 
    output reg [3:0] min_tens,     
    output reg [3:0] min_units,     
    output reg [3:0] sec_tens,      
    output reg [3:0] sec_units
);

reg [2:0] adjust_mode;  // Modo atual de ajuste: 0 = horas, 1 = minutos, 2 = segundos
reg set_prev;
reg set_edge;
reg [23:0] blink_counter;
reg blink_state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        // Reset de todas as variáveis
        set_prev <= 0;
        adjust_mode <= 0;
        blink_counter <= 0;
        blink_state <= 0;

        // Reset dos dígitos
        hour_tens <= 0;
        hour_units <= 0;
        min_tens <= 0;
        min_units <= 0;
        sec_tens <= 0;
        sec_units <= 0;
   end else if (!adjust) begin
        if (sec_units == 9) begin
            sec_units <= 0;
            if (sec_tens == 5) begin
                sec_tens <= 0;
                if (min_units == 9) begin
                    min_units <= 0;
                    if (min_tens == 5) begin
                        min_tens <= 0;
                        if (hour_units == 9 || (hour_tens == 2 && hour_units == 3)) begin
                            hour_units <= 0;
                            if (hour_tens == 2) begin
                                hour_tens <= 0;
                            end else begin
                                hour_tens <= hour_tens + 1;
                            end
                        end else begin
                            hour_units <= hour_units + 1;
                        end
                    end else begin
                        min_tens <= min_tens + 1;
                    end
                end else begin
                    min_units <= min_units + 1;
                end
            end else begin
                sec_tens <= sec_tens + 1;
            end
        end else begin
            sec_units <= sec_units + 1;
        end
    end
end
endmodule

