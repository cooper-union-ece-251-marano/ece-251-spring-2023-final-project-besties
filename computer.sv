//////////////////////////////////////////////////i///////////////////////////////
// The Cooper Union                                                             //
// ECE 251 Spring 2023                                                          //
// Engineers: Ridwan Hussain and Ilona Lameka                                   //
//                                                                              //
//     Create Date: 2023-05-14                                                  //
//     Module Name: computer                                                    //
//     Description: Computer                                                    //
//                                                                              //
// Revision: 1.0                                                                //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////

`ifndef COMPUTER
`define COMPUTER

`timescale 1ns/100ps

`include "./Cpu/cpu.sv"
`include "./Imem/imem.sv"
`include "./Dmem/dmem.sv"

module computer(clk, reset, writeData, dataAddr, memWrite);
	input logic clk, reset;
	output logic [31:0] writeData, dataAddr;
	output logic memWrite;

	logic [31:0] pc, instr, readData;
	
  // computer internal components
  // the RISC CPU
  cpu mips(clk, reset, pc, instr, memWrite, dataAddr, writeData, readData);
  // the instruction memory ("text segment") in main memory
  imem imem(pc[8:2], instr);
  // the data memory ("data segment") in main memory
  dmem dmem(clk, memWrite, dataAddr, writeData, readData);

endmodule

`endif // COMPUTER
