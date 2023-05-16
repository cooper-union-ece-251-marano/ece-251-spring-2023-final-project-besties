//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union                                                             //
// ECE 251 Spring 2023                                                          //
// Engineers: Ridwan Hussain and Ilona Lameka                                   //
//                                                                              //
//     Create Date: 2023-05-13                                                  //
//     Module Name: tb_sl2                                                      //
//     Description: Testbench for sl2. Makes sure the bits are shifted to left  //
//     left by 2 and overflow is handled for the 2 MSB get dropped.             //
//                                                                              //
// Revision: 1.2                                                                //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/100ps
`include "./sl2.sv"

module tb_sl2 
  // ---- Defining variables to be used ---- //
	#(parameter n = 32);
	reg [(n-1):0] num;   //inputs are reg for test bench
	wire [(n-1):0] num4;     //outputs are wire for test bench
   
	// ---- INSTANTIATE UNIT UNDER TEST (UUT) ---- //
	sl2 uut(.num(num), .num4(num4));
	
	// ---- INITIALIZE TEST BENCH ---- //
	initial begin
		$dumpfile("sl2.vcd"); // for Makefile, make dump file same as module name
		$dumpvars(0, uut);
		$monitor("num=%b=%d, num4=%b=%d", num, num, num4, num4);
	end

	//apply input vectors
	initial begin: apply_stimulus
		#1 num = 32'h00000000;
		#1 num = 32'h00000001;
		#1 num = 32'h00001111;
		#1 num = 32'h0000BEEF;
		#1 num = 32'h11111111;
		#1 num = 32'h13579BDF;
		#1 num = 32'hF0000000;
		#1 num = 32'hFFFFFFFF;
		$finish;
	end

endmodule

// `endif // tb_sl5
