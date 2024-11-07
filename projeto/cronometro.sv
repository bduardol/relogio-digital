module cronometro (
    input wire clk,
	 input wire reset,
	 /*Fiz a mudança da chave Key3 para SW7, pois estava dando problema na 
	 mudagem de sinal, na função de pause e stop. Para evitar bugs, 
	 preferir adicionar uma chave que ao ativar ela, ele faz a cronometragem, 
	 e desativando ele faz um stop. O bug estava dando por conta da placa mesmo. 
	 Algumas estão com os botoes defeituosos.*/
    /* mesmo assim ja criei o input para essa funcionalidade. Basta alterar*/
	 input wire running,

    output reg [3:0] hour_tens,
    output reg [3:0] hour_units,
    output reg [3:0] min_tens,
    output reg [3:0] min_units,
    output reg [3:0] sec_tens,
    output reg [3:0] sec_units,
    output reg [3:0] milli_sec_tens,
    output reg [3:0] milli_sec_units
);

reg [9:0] milliseconds = 0; // Contador de milissegundos até 999
reg [5:0] seconds = 0;       // Contador de segundos até 59
reg [5:0] minutes = 0;       // Contador de minutos até 59
reg [4:0] hours = 0;         // Contador de horas até 23
reg [16:0] count = 0;        // Contador de ciclos até 49999


always @(posedge clk or posedge reset) begin
    if (reset) begin
        // Reseta todos os contadores e os displays
        hour_tens <= 0; 
		  hour_units <= 0;
        min_tens <= 0; 
		  min_units <= 0;
        sec_tens <= 0; 
		  sec_units <= 0;
        milli_sec_tens <= 0; 
		  milli_sec_units <= 0;
        milliseconds <= 0; 
		  seconds <= 0;
        minutes <= 0; 
		  hours <= 0; 
		  count <= 0;
    end else if (running) begin
			  if (count == 49999) begin
					count <= 0;
					if (milliseconds == 999) begin
						 milliseconds <= 0;
						 if (seconds == 59) begin
							  seconds <= 0;
							  if (minutes == 59) begin
									minutes <= 0;
									if (hours == 23) begin
										 hours <= 0;
									end else begin
										 hours <= hours + 1;
									end
							  end else begin
									minutes <= minutes + 1;
							  end
						 end else begin
							  seconds <= seconds + 1;
						 end
					end else begin
						 milliseconds <= milliseconds + 1;
					end

					// Atualiza os displays
					sec_units <= seconds % 10;
					sec_tens <= seconds / 10;
					min_units <= minutes % 10;
					min_tens <= minutes / 10;
					hour_units <= hours % 10;
					hour_tens <= hours / 10;
					milli_sec_units <= (milliseconds / 10) % 10;
					milli_sec_tens <= milliseconds / 100;
			  end else begin
					count <= count + 1;
			  end
		 end
	end
endmodule

