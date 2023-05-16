//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union                                                             //
// ECE 251 Spring 2023                                                          //
// Engineers: Ridwan Hussain and Ilona Lameka                                   //
//                                                                              //
//     Create Date: 2023-05-06                                                  //
//     Module Name: tb_dff                                                      //
//     Description: Testbench to see if dff module works.                       //
//                                                                              //
// Revision: 1.0                                                                //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/100ps
`include "./dff.sv"

module tb_dff;
	// ---- Defining variables to be used ---- //
	parameter n = 32;
	reg clk;          //inputs are reg for test bench
	reg [(n-1):0] enable, reset, D;
	wire [(n-1):0] Q;     //outputs are wire for test bench 
	wire nclk, C;

	// ---- INSTANTIATE UNIT UNDER TEST (UUT) ---- //
	dff uut(.enable(enable), .reset(reset), .clk(clk), .D(D), .Q(Q));	
	
	// ---- INITIALIZE TEST BENCH ---- //
	initial begin
		$dumpfile("dff.vcd"); // for Makefile, make dump file same as module name
		$dumpvars(0, uut);
	end

	//apply input vectors
	initial begin: apply_stimulus
		reg[4:0] tVect; //tVect[3] terminates the for loop
		clk = 0;
		enable = 32'hFFFFFFFF;
		reset = 32'h00000000;
		for (tVect = 0; tVect < 16; tVect = tVect + 1) begin
			D = tVect * 32 * 255 * 102;
			clk = 1; #1;
			if (tVect == 4) begin
				reset = 32'h0000FFFF;
			end
			if (tVect == 6) begin
				enable = 32'hFFF00FFF;	
			end
			if (tVect == 8) begin
				reset = 32'hFFFF0000;
			end
			if (tVect == 10) begin
				reset = 32'h00000000;
			end
			if (tVect == 12) begin
				enable = 32'hFFFFFFFF;
			end
			if (tVect == 13) begin
				reset = 32'h000FF00;
			end
			if (tVect == 14) begin
				reset = 32'h00F0000;
			end
			clk = 0; #1;
			$display("HEX: C=%b, E=%x, R=%x, D=%x, Q=%x", clk, enable, reset, D, Q);
		end
		$finish;
	end

endmodule
// `endif // tb_dff
