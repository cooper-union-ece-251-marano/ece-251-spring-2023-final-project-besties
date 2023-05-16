//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union                                                             //
// ECE 251 Spring 2023                                                          //
// Engineers: Ridwan Hussain and Ilona Lameka                                   //
//                                                                              //
//     Create Date: 2023-05-06                                                  //
//     Module Name: fullAdder                                                   //
//     Description: logic gate adder                                            //
//                                                                              //
// Revision: 1.0                                                                //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////
`ifndef FULLADDER
`define FULLADDER

`timescale 1ns/100ps


module fullAdder(In1, In2, Cin, Sum, Cout);
  
	input In1, In2, Cin;
  	output Sum, Cout;
	
 	assign Sum  = In1 ^ In2 ^ Cin;
  	assign Cout = (In1 & In2) | (In1 & Cin) | (In2 & Cin);
  
endmodule // fullAdder

`endif //fullAdder
