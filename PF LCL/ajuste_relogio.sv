module ajuste_relogio(
    input wire clk,
    input wire reset,
    input wire sw5,  // Bit 5 de SW
    input wire sw4,  // Bit 4 de SW
    input wire sw3,  // Bit 3 de SW
    input wire sw2,  // Bit 2 de SW
    input wire sw1,  // Bit 1 de SW
    input wire sw0,  // Bit 0 de SW
    input wire set,  // Botão para alternar os modos de ajuste
    input wire modo_ajuste, // Sinal para habilitar o modo de ajuste
    
	 output reg adjust,
	 
    output reg [5:0] horas,
    output reg [5:0] minutos,
    output reg [5:0] segundos,
	 
	 output reg [3:0] hou_tens,
    output reg [3:0] hou_units,
    output reg [3:0] min_tens,
    output reg [3:0] min_units,
    output reg [3:0] sec_tens,
    output reg [3:0] sec_units
	 

	 
	 
);

wire [5:0] input_value = {sw5, sw4, sw3, sw2, sw1, sw0};
reg [1:0] count = 0;
reg set_prev = 0;
reg blink_state = 0;
reg [20:0] blink_counter = 0;
reg adjust_final = 0;  // Latch para manter o estado de 'adjust_done'



always @(*) begin
	if (modo_ajuste) begin
            case (count)
                0: begin // Configuração das horas
                    hou_tens <= ~clk ? 4'b0000 : 4'b1111; // Pisca
                    hou_units <= ~clk ? 4'b0000 : 4'b1111; // Pisca
                end
                1: begin // Configuração dos minutos
						  
                    min_tens <= ~clk ? 4'b0000 : 4'b1111;
                    min_units <= ~clk ? 4'b0000 : 4'b1111;
                end
                2: begin // Configuração dos segundos
                    sec_tens <= ~clk ? 4'b0000 : 4'b1111;
                    sec_units <= ~clk ? 4'b0000 : 4'b1111;
                end
            endcase
	end
end


always @( posedge clk or posedge reset) begin
    if (reset) begin
        count <= 0;
        horas <= 0;
        minutos <= 0;
        segundos <= 0;
        set_prev <= 0;
        adjust <= 0;
        adjust_final <= 0;
    end else begin
        if (modo_ajuste) begin
            if (set && !set_prev) begin // Detect edge
                count <= count + 1;
					 if (count == 1) begin
						horas <= input_value;
					 end
					 if (count == 2) begin
						minutos <= input_value;
					 end
					 
                if (count >= 3) begin
                    count <= 0;
						  segundos <= input_value;
                    adjust_final <= 1;  // Ajuste concluído, sinaliza para o sistema
                end
            end
            //set_prev <= set;
			end
        if (adjust_final) begin
            adjust <= 1;
            adjust_final <= 0;  // Reset do latch após sinalização
        end else begin
            adjust <= 0;
        end

        
    end
end

endmodule
