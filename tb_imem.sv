//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union                                                             //
// ECE 251 Spring 2023                                                          //
// Engineers: Ridwan Hussain and Ilona Lameka                                   //
//                                                                              //
//     Create Date: 2023-05-12                                                  //
//     Module Name: tb_imem                                                     //
//     Description: Testbench for imem, read input from program_exe and prints  //
//     selected 1st, 3rd, 9th, 15th, 31st, 63rd, and last line from the file.   //
//                                                                              //
// Revision: 1.0                                                                //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/100ps
`include "./imem.sv"

module tb_imem
	// ---- Defining variables to be used ---- //
	#(parameter n = 32, parameter r = 7);
	reg [(r-1):0] readAddr;   //inputs are reg for test bench
	wire [(n-1):0] instruction;     //outputs are wire for test bench
   
	// ---- INSTANTIATE UNIT UNDER TEST (UUT) ---- //
	imem uut(.readAddr(readAddr), .instr(instruction));
	
	// ---- INITIALIZE TEST BENCH ---- //
	initial begin
		$dumpfile("imem.vcd"); // for Makefile, make dump file same as module name
		$dumpvars(0, uut);
		$monitor("addr=%x, readData=%x", readAddr, instruction);
	end

	initial begin: apply_stimulus
		#10 readAddr <= #(r)'b0000001; //First line of the file
		#10 readAddr <= #(r)'b0000011; //3rd line
		#10 readAddr <= #(r)'b0000111; //9th line
		#10 readAddr <= #(r)'b0001111; //15th line
		#10 readAddr <= #(r)'b0011111; //31st line
		#10 readAddr <= #(r)'b0111111; //63rd line
		#10 readAddr <= #(r)'b1000000; //Last line of the file
		$finish;
	end

endmodule

// `endif // tb_imem
