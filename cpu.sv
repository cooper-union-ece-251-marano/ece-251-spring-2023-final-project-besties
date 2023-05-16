//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union                                                             //
// ECE 251 Spring 2023                                                          //
// Engineers: Ridwan Hussain and Ilona Lameka                                   //
//                                                                              //
//     Create Date: 2023-05-14                                                  //
//     Module Name: cpu                                                         //
//     Description: CPU                                                         //
//                                                                              //
// Revision: 1.0                                                                //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////
`ifndef CPU
`define CPU

`timescale 1ns/100ps

`include "./controller.sv"
`include "./datapath.sv"

module cpu
    	(input  logic clk, reset,
    	output logic [31:0] pc,
    	input logic [31:0] instr,
    	output logic memWrite,
    	output logic [31:0] aluOut, writeData,
    	input  logic [31:0] readData);
			
    	logic memToReg, aluSrc, regDst, regWrite, jump, branch, zero, jalSelect, jalSelect2, jrSelect;
    	logic [3:0] aluControl;
    
    	controller c(instr[31:27], zero, regDst, regWrite, branch, memWrite, memToReg, jump, jalSelect, jalSelect2, jrSelect, aluSrc, aluControl);

    	datapath #(32) dp(clk, reset, regDst, regWrite, branch, memWrite, memToReg, jump, jalSelect, jalSelect2, jrSelect, aluSrc, branch, aluControl, instr, readData, zero, pc, aluOut, writeData);

endmodule

`endif // CPU
