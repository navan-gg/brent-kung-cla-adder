`timescale 1ns / 1ps
`include "cla_adder.v"

module tb_final_circuit;
    reg clk;
    reg rst_n;
    reg [4:0] A, B;
    wire [4:0] Sum_out;
    wire Cout_out;
    
    integer i, j;
    integer errors;
    reg [5:0] expected;

    final_circuit uut (
        .clk(clk),
        .rst_n(rst_n),
        .A(A),
        .B(B),
        .Sum_out(Sum_out),
        .Cout_out(Cout_out)
    );
    
    always #10 clk = ~clk;

    initial begin
        $dumpfile("bka.vcd");
        $dumpvars(0, tb_final_circuit);

        clk = 0;
        rst_n = 0;
        A = 0; B = 0;
        errors = 0;

        #15 rst_n = 1;
        
        for (i = 0; i < 32; i = i + 1) begin
            for (j = 0; j < 32; j = j + 1) begin
                
                A = i;
                B = j;
                
                @(posedge clk);
                
                @(posedge clk); 
                
                #1; 

                expected = i + j;
                if ({Cout_out, Sum_out} !== expected) begin
                    $display("FAIL: %d + %d = %d (Expected %d)", i, j, {Cout_out, Sum_out}, expected);
                    errors = errors + 1;
                end
            end
        end

        if (errors == 0) begin
            $display("SUCCESS: All 1024 tests passed.");
        end else begin
            $display("FAILURE: Found %d errors.", errors);
        end

        $finish;
    end
endmodule