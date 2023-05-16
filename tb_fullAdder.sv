//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union                                                             //
// ECE 251 Spring 2023                                                          //
// Engineers: Ridwan Hussain and Ilona Lameka                                   //
//                                                                              //
//     Create Date: 2023-05-06                                                  //
//     Module Name: tb_fullAdder                                                //
//     Description: Test bench for logic gate adder                             //
//                                                                              //
// Revision: 1.0                                                                //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////

`ifndef TB_FULLADDER
`define TB_ADDER

`timescale 1ns/100ps
`include "fullAdder.sv"

module tb_fullAdder();

	reg x, y, cin;
	wire sum, cout;

	// unit undertest
	fullAdder uut(.In1(x), .In2(y), .Cin(cin), .Sum(sum), .Cout(cout));

	initial begin
		$display("X\tY\tCin\tSum\tCout");
		$monitor("%b\t%b\t%b\t%b\t%b", x, y, cin, sum, cout);
	end

	initial
	begin
		x = 0;
		y = 0;
		cin = 0;
		#1;
		x = 0;
		y = 0;
		cin = 1;
		#1;
		x = 1;
		y = 0;
		cin = 0;
		#1;
		x = 1;
		y = 0;
		cin = 1;
		#1;
		x = 0;
		y = 1;
		cin = 0;
		#1;
		x = 0;
		y = 1;
		cin = 1;
		#1
		x = 1;
		y = 1;
		cin = 0;
		#1
		x = 1;
		y = 1;
		cin = 1;
	end
endmodule // tb_fullAdder

`endif // tb_fullAdder
