//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union                                                             //
// ECE 251 Spring 2023                                                          //
// Engineers: Ridwan Hussain and Ilona Lameka                                   //
//                                                                              //
//     Create Date: 2023-05-07                                                  //
//     Module Name: aluDec                                                      //
//     Description: ALU Decoder                                                 //
//                                                                              //
// Revision: 1.0                                                                //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////

`ifndef ALUDEC
`define ALUDEC

`timescale 1ns/100ps

module aluDec(op, alucontrol);
	input logic [4:0] op;
	output logic [3:0] alucontrol;

	always @* begin
		case(op)
			5'b01000: alucontrol <= 4'b0000; //add
      5'b01001: alucontrol <= 4'b0001; //sub
      5'b01010: alucontrol <= 4'b0010; //sl
      5'b01011: alucontrol <= 4'b0011; //sr
      5'b01100: alucontrol <= 4'b0100; //and
			5'b01101: alucontrol <= 4'b0101; //or
			5'b01110: alucontrol <= 4'b0110; //xor
			5'b01111: alucontrol <= 4'b0111; //nor
			5'b10000: alucontrol <= 4'b1000; //nand
			5'b10001: alucontrol <= 4'b1001; //nor
			5'b10010: alucontrol <= 4'b1010; //jr
			5'b10011: alucontrol <= 4'b1011; //slt
			5'b10100: alucontrol <= 4'b1100; //sgt
			
			5'b11000: alucontrol <= 4'b0000; //addi
			5'b11001: alucontrol <= 4'b0001; //subi
			5'b11010: alucontrol <= 4'b0000; //lw
			5'b11011: alucontrol <= 4'b0000; //sw
			5'b11100: alucontrol <= 4'b0001; //beq
			5'b11101: alucontrol <= 4'b0001; //bne
			
			5'b00000: alucontrol <= 4'b0000; //j
			5'b00111: alucontrol <= 4'b0000; //jal
			default : alucontrol <= 4'bXXXX: //ERROR
     endcase
  end

endmodule //aluDec

`endif 
