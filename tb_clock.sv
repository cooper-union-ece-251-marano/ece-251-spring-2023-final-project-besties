//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union                                                             //
// ECE 251 Spring 2023                                                          //
// Engineers: Ridwan Hussain and Ilona Lameka                                   //
//                                                                              //
//     Create Date: 2023-05-06                                                  //
//     Module Name: tb_clock                                                    //
//     Description: Testbench to see if clock module works.                     //
//                                                                              //
// Revision: 1.0                                                                //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/100ps
`include "./clock.sv"

module tb_clock;
	// ---- Defining variables to be used ---- //
	reg enable;   //inputs are reg for test bench
	wire clk;     //outputs are wire for test bench
	   
	// ---- INSTANTIATE UNIT UNDER TEST (UUT) ---- //
	clock uut(.enable(enable), .clk(clk));
	
	// ---- INITIALIZE TEST BENCH ---- //
	initial begin
		$dumpfile("clock.vcd"); // for Makefile, make dump file same as module name
		$dumpvars(0, uut);
		$dumpvars(0, i);
		$monitor("i: %b, enable: %b, clk: %b", i, enable, clk);
		//$monitor("A is %b, B is %b, C is %b", a, b, c);
		//#50 A = 4'b1100;
		//#50 $finish;
	end

	//apply input vectors
	reg [4:0] i;
	initial begin: apply_stimulus
		enable = 0; //tVect[3] terminates the for loop
		for (i = 0; i < 16; i = i + 1) begin
			if (i == 0) begin
				enable = 1;
			end
			if (i == 7) begin
				enable = 0;
			end
			if (i == 13) begin
				enable = 1;
			end
			#1;
		end
		$finish;
	end

endmodule

// `endif // example_tb
