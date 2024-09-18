module segment_output(in_segments, out_a, out_b, out_c, out_d, out_e, out_f, out_g);
    input [6:0] in_segments;
    output out_a, out_b, out_c, out_d, out_e, out_f, out_g;

    assign out_a = in_segments[6];
    assign out_b = in_segments[5];
    assign out_c = in_segments[4];
    assign out_d = in_segments[3];
    assign out_e = in_segments[2];
    assign out_f = in_segments[1];
    assign out_g = in_segments[0];
endmodule