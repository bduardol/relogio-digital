module relogio(
    input wire clk,
    input wire reset,
    input wire adjust,

    output logic [3:0] hour_tens, 
    output logic [3:0] hour_units, 
    output logic [3:0] min_tens,     
    output logic [3:0] min_units,     
    output logic [3:0] sec_tens,      
    output logic [3:0] sec_units,

    input wire [5:0] adjust_hour,
    input wire [5:0] adjust_min,   
    input wire [5:0] adjust_sec
);

logic [4:0] hours = 0;  // Contador de horas (0-23)

// Bloco de reset e ajuste
always @(posedge clk or posedge reset) begin
    if (reset) begin
        // Reset logic
		  hours <= 0;
		  hour_tens <= 0;
        hour_units <= 0;
		  min_tens <= 0;
        min_units <= 0;
        sec_tens <= 0;
        sec_units <= 0;
    end else if (adjust) begin
			hours <= adjust_hour;
			hour_tens <= adjust_hour / 10;
			hour_units <= adjust_hour % 10;
			min_tens <= adjust_min / 10;
			min_units <= adjust_min % 10;
			sec_tens <= adjust_sec / 10;
			sec_units <= adjust_sec % 10;

	 end else begin
        // Clock increment logic
        sec_units <= sec_units + 1;
        if (sec_units == 9) begin
            sec_units <= 0;
            sec_tens <= sec_tens + 1;
            if (sec_tens == 5) begin
                sec_tens <= 0;
                min_units <= min_units + 1;
                if (min_units == 9) begin
                    min_units <= 0;
                    min_tens <= min_tens + 1;
                    if (min_tens == 5) begin
                        min_tens <= 0;
                        hours <= hours + 1;
                        if (hours == 23) begin
                            hours <= 0;
                        end
                    end
                end
            end
        end
        // Update digital display for hours
        hour_units <= hours % 10;
        hour_tens <= hours / 10;
    end
end
endmodule