//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union                                                             //
// ECE 251 Spring 2023                                                          //
// Engineers: Ridwan Hussain and Ilona Lameka                                   //
//                                                                              //
//     Create Date: 2023-05-07                                                  //
//     Module Name: mainDec                                                     //
//     Description: Main decoder for controller                                 //
//                                                                              //
// Revision: 1.0                                                                //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////
`ifndef MAINDEC
`define MAINDEC

`timescale 1ns/100ps

module mainDec(opCode, zero, regDst, regWrite, branch, memWrite, memToReg, jump, jalSelect, jalSelect2, jrSelect, aluSrc, aluControl);
	input logic [4:0] opCode;
	input logic zero;
	output logic regDst, regWrite, branch, memWrite, memToReg, jump, jalSelect, jalSelect2, jrSelect, aluSrc;
	output logic [3:0] aluControl;

	logic [13:0] controls;
	     //[1       2         3       4_        5         6     7          8-         9          10      11 12_ 13 14
	assign {regDst, regWrite, branch, memWrite, memToReg, jump, jalSelect, jalSelect2, jrSelect, aluSrc, aluControl} = controls;

	always @* begin
		// R type, set aluop to 
		case(opCode) //for alu decoder, 00 is add 11 is subtract
			//												1234_5678_9012_34
			5'b01000: controls <= 14'b1100_0000_0000_00; //add
			5'b01001: controls <= 14'b1100_0000_0000_01; //sub
			5'b01010: controls <= 14'b1100_0000_0000_10; //sl
			5'b01011: controls <= 14'b1100_0000_0000_11; //sr
			5'b01100: controls <= 14'b1100_0000_0001_00; //and
			5'b01101: controls <= 14'b1100_0000_0001_01; //or
			5'b01110: controls <= 14'b1100_0000_0001_10; //xor
			5'b01111: controls <= 14'b1100_0000_0001_11; //nor
			5'b10000: controls <= 14'b1100_0000_0010_00; //nand
			5'b10001: controls <= 14'b1100_0000_0010_01; //not
			5'b10010: controls <= 14'b0000_0000_1000_00; //jr
			5'b10011: controls <= 14'b1100_0000_0010_11; //slt
			5'b10100: controls <= 14'b1100_0000_0011_00; //sgt

			5'b11000: controls <= 14'b0100_0000_0100_00; //addi 
			5'b11001: controls <= 14'b0100_0000_0100_01; //subi
			5'b11010: controls <= 14'b0100_1000_0100_00; //lw
			5'b11011: controls <= 14'b0001_0000_0100_00; //sw
			5'b11100: controls <= 14'b0010_0000_0000_01; //beq
			5'b11101: controls <= 14'b0010_0000_0000_01; //bne

			5'b00000: controls <= 14'b0000_0100_0000_00; //j
			5'b00111: controls <= 14'b0100_0111_0000_00; //jal
			default:  controls <= 14'bxxxx_xxxx_xxx; //illegal
		endcase
	end

endmodule //mainDec

`endif 
