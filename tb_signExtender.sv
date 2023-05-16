//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union                                                             //
// ECE 251 Spring 2023                                                          //
// Engineers: Ridwan Hussain and Ilona Lameka                                   //
//                                                                              //
//     Create Date: 2023-05-DD                                                  //
//     Module Name: XXXXXXX                                                     //
//     Description: XXXXXXXXXX                                                  //
//                                                                              //
// Revision: 1.0                                                                //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/100ps
`include "./signExtender.sv"

module tb_signExtender;
  // ---- Defining variables to be used ---- //
	reg signed [12:0] num13bit;   //inputs are reg for test bench
	wire signed [31:0] num32bit;     //outputs are wire for test bench
   
	// ---- INSTANTIATE UNIT UNDER TEST (UUT) ---- //
	signExtender uut(.numIn(num13bit), .numOut(num32bit));
	
	// ---- INITIALIZE TEST BENCH ---- //
	initial begin
		$dumpfile("signExtender.vcd"); // for Makefile, make dump file same as module name
		$dumpvars(0, uut);
		$monitor("13bitNum=%b=%d, 32bitNum=%b=%d", num13bit, num13bit, num32bit, num32bit);
	end

	//apply input vectors
	initial begin: apply_stimulus
		#1 num13bit = 10;
		#1 num13bit = 2237;
		#1 num13bit = -24;
		#1 num13bit = -1234;
		#1 num13bit = 3267;
		#1 num13bit = -3268;
		$finish;
	end

endmodule
// `endif // tb_signExtender
