module ent_separador(
    input wire clk,
    input wire [4:0] in,

    output reg out00,
    output reg out01,
    output reg out02,
    output reg out03,
    output reg out04
);

always @(posedge clk) begin
    out00 = in[4];
    out01 = in[3];
    out02 = in[2];
    out03 = in[1];
    out04 = in[0];
end

endmodule


