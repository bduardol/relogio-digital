module cronometro_centesimos (
		input wire clk,
		input wire modo_cronometro,
		input wire [3:0] in_cent_sec_tens,
		input wire [3:0] in_cent_sec_units,
		
		
		output reg [3:0] out_cent_sec_tens,
		output reg [3:0] out_cent_sec_units
		);
		
		always @(posedge clk) begin
			if (modo_cronometro) begin
				out_cent_sec_tens <= in_cent_sec_tens;
				out_cent_sec_units <= in_cent_sec_units;
			end else begin
				out_cent_sec_tens <= 4'b0000;
				out_cent_sec_units <= 4'b0000;
			end
		end
endmodule