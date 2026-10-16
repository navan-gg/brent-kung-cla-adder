module d_ff (
    input [4:0] D,
    input clk,
    input rst_n,      // Changed from 'rst' to match the active-low usage below
    output reg [4:0] Q
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            Q <= 5'b0;
        end else begin
            Q <= D;
        end
    end
endmodule

module graycell(input P_curr, input G_curr, input G_prev, output G_out);
    assign G_out = G_curr | (P_curr & G_prev);
endmodule

module blackcell(input P_curr, input G_curr, input P_prev, input G_prev, output P_out, output G_out);
    assign P_out = P_curr & P_prev;
    assign G_out = G_curr | (P_curr & G_prev);
endmodule

module bka(input [4:0] A, input [4:0] B, output [4:0] Sum, output Cout);

    wire p0, g0, p1, g1, p2, g2, p3, g3, p4, g4;
    wire S0, S1, S2, S3, S4;
    wire C0, C1, C2, C3;
    wire w1, w2;

    assign p0 = A[0] ^ B[0];
    assign g0 = A[0] & B[0];
    assign p1 = A[1] ^ B[1];
    assign g1 = A[1] & B[1];
    assign p2 = A[2] ^ B[2];
    assign g2 = A[2] & B[2];
    assign p3 = A[3] ^ B[3];
    assign g3 = A[3] & B[3];
    assign p4 = A[4] ^ B[4];
    assign g4 = A[4] & B[4];
    
    assign S0 = p0;
    assign C0 = g0;
    assign S1 = p1 ^ C0;

    graycell idk1(p1, g1, g0, C1);
    assign S2 = p2 ^ C1;

    graycell idk2(p2, g2, C1, C2);
    assign S3 = p3 ^ C2;

    blackcell idk3(p3, g3, p2, g2, w1, w2);
    graycell idk4(w1, w2, C1, C3);
    assign S4 = p4 ^ C3;

    graycell idk5(p4, g4, C3, Cout);

    assign Sum = {S4, S3, S2, S1, S0};

endmodule

module final_circuit(
    input clk,
    input rst_n,
    input [4:0] A,
    input [4:0] B,
    output reg [4:0] Sum_out,
    output reg Cout_out
);

    wire [4:0] A_reg, B_reg; 
    wire [4:0] Sum_wire;     
    wire Cout_wire;          

    d_ff ff_a (
        .D(A), 
        .clk(clk), 
        .rst_n(rst_n), 
        .Q(A_reg)
    );

    d_ff ff_b (
        .D(B), 
        .clk(clk), 
        .rst_n(rst_n), 
        .Q(B_reg)
    );

    bka adder_inst (
        .A(A_reg), 
        .B(B_reg), 
        .Sum(Sum_wire), 
        .Cout(Cout_wire)
    );

    always @(posedge clk) begin
        begin
            Sum_out <= Sum_wire;
            Cout_out <= Cout_wire;
        end
    end

endmodule