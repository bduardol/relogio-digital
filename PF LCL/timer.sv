module timer (
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


always @(posedge clk) begin
    if (reset) begin
        // Inicia a contagem de 23:59:59
        hour_tens <= 2;
        hour_units <= 3;
        min_tens <= 5;
        min_units <= 9;
        sec_tens <= 5;
        sec_units <= 9;
        hours <= 23;
    end else if (adjust) begin
		  // Define os valores do relógio com os ajustes fornecidos
			hours <= adjust_hour;
			hour_tens <= adjust_hour / 10;
			hour_units <= adjust_hour % 10;
			min_tens <= adjust_min / 10;
			min_units <= adjust_min % 10;
			sec_tens <= adjust_sec / 10;
			sec_units <= adjust_sec % 10;	 
	 end else begin
        sec_units <= sec_units - 1;
        if (sec_units == 0) begin
            sec_units <= 9;
            sec_tens <= sec_tens - 1;
            if (sec_tens == 0) begin
                sec_tens <= 5;
                min_units <= min_units - 1;
                if (min_units == 0) begin
                    min_units <= 9;
                    min_tens <= min_tens - 1;
                    if (min_tens == 0) begin
                        min_tens <= 5;
                        hours <= hours - 1;
                        if (hours == 0) begin
                            hours <= 23;
                        end
                    end
                end
            end
        end
        hour_units <= hours % 10;
        hour_tens <= hours / 10;
    end
end
endmodule