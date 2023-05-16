//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union                                                             //
// ECE 251 Spring 2023                                                          //
// Engineers: Ridwan Hussain and Ilona Lameka                                   //
//                                                                              //
//     Create Date: 2023-05-06                                                  //
//     Module Name: adder                                                       //
//     Description: 32 bit adder                                                //
//                                                                              //
// Revision: 1.0                                                                //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////

`ifndef ADDER
`define ADDER

`include "./FullAdder/fullAdder.sv"
`timescale 1ns/100ps

module adder
	#(parameter n = 32)(	
	input [(n-1):0]A, B,
	input Cin,
	output Cout,
	output [(n-1):0] Sum);
	wire [(n-1):0] carries;
	assign carries[0] = Cin;
	
	genvar i;
	generate for(i = 0; i < (n-1); i = i + 1)
		begin
			fullAdder bits(.In1(A[i]), .In2(B[i]), .Cin(carries[i]), .Sum(Sum[i]), .Cout(carries[i+1]));
		end
	endgenerate
	fullAdder bit31(.In1(A[(n-1)]), .In2(B[(n-1)]), .Cin(carries[(n-1)]), .Sum(Sum[(n-1)]), .Cout(Cout));

endmodule // Adder
`endif
