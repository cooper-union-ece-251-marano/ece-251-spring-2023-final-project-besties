///////////////////////////////////////////////////i//////////////////////////////
// The Cooper Union                                                             //
// ECE 251 Spring 2023                                                          //
// Engineers: Ridwan Hussain and Ilona Lameka                                   //
//                                                                              //
//     Create Date: 2023-05-07                                                  //
//     Module Name: controller                                                  //
//     Description: Controller Unit                                             //
//                                                                              //
// Revision: 1.2                                                                //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////

`ifndef CONTROLLER
`define CONTROLLER

`timescale 1ns/100ps

`include "./MainDec/mainDec.sv"
//`include "../AluDec/aluDec.sv"

module controller
	(input logic [4:0] opCode,
	input logic zero,
	output logic regDst, regWrite, branch, memWrite, memToReg, jump, jalSelect, jalSelect2, jrSelect, aluSrc,
	output logic [3:0] aluControl);
 
	// CPU main decoder
	mainDec md(opCode, zero, regDst, regWrite, branch, memWrite, memToReg, jump, jalSelect, jalSelect2, jrSelect, aluSrc, aluControl);
	
	// AND Gate that is part of Control
	assign branchMuxSelect = branch & zero;

endmodule //controller

`endif 
