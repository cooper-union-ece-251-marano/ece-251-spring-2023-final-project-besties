//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union                                                             //
// ECE 251 Spring 2023                                                          //
// Engineers: Ridwan Hussain and Ilona Lameka                                   //
//                                                                              //
//     Create Date: 2023-05-06                                                  //
//     Module Name: adder                                                       //
//     Description: Test bench for 32 bit adder.                                //
//                                                                              //
// Revision: 1.0                                                                //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////
`ifndef TB_ADDER
`define TB_ADDER

`timescale 1ns/100ps
`include "./adder.sv"

module tb_adder
	#(parameter n = 32);
	reg [(n-1):0]x, y;
	reg cin;
  wire [(n-1):0] s;
	wire cout;

        adder uut (.A(x), .B(y), .Cin(cin), .Cout(cout), .Sum(s));

        initial
        begin
          $dumpfile("adder32Bit.vcd");
					$dumpvars(0, uut);
					$display("A\t\t\t\t\tB\t\t\t\t\tCin\tSum\t\t\t\t\tCout");
          $monitor("%b\t%b\t%b\t%b\t%b", x, y, cin, s, cout);
        end

        initial
        begin

                x = #(n)'b11111111111111111111111111111111;
                y = #(n)'b00000000000000000000000000000000;
		cin = 1'b0;
		
		#10
		x = #(n)'b00000000000000000000000000000000;
		y = #(n)'b00000000000000000000000000000000;
		cin = 1'b1;

		#10
		x = #(n)'b00000000000000000000000000000001;
		y = #(n)'b00000000000000000000000000000011;
		cin = 1'b1;
        end
endmodule // tb_adder
`endif
