//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union                                                             //
// ECE 251 Spring 2023                                                          //
// Engineers: Ridwan Hussain and Ilona Lameka                                   //
//                                                                              //
//     Create Date: 2023-05-12                                                  //
//     Module Name: regFile                                                     //
//     Description: 128-bit register file; this is where the registers are      //
//     defined for the CPU. The registers are written on rising edge and are    //
//     read on falling edge.                                                    //
//		                                                                          //
// Revision: 1.0                                                                //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////

`ifndef regFile
`define regFile
`timescale 1ns/100ps

module regFile
	// ---- PORT DEFINITIONS ---- //
	#(parameter n = 32, parameter r = 7)
	(input clk, regWrite,
	input [(r-1):0] readReg1, readReg2, writeReg, 
	input [(n-1):0] writeData,
	output [(n-1):0] readData1, readData2);

	reg [(n-1):0] registers[(2**r-1):0];
	reg [(n-1):0] rD1, rD2;

	// ---- MODULE DESIGN IMPLEMENTATION ---- //
	initial begin
		registers[0] = 0;
		registers[1] = 1;
		registers[2] = 2;
	end

	always @(posedge clk) begin		
		if (regWrite) begin
			registers[writeReg] = writeData;
		end
	end

	always @(negedge clk) begin
		rD1 = registers[readReg1];
	  rD2 = registers[readReg2];
	end

	assign readData1 = rD1;
	assign readData2 = rD2;

endmodule

`endif // regFile
