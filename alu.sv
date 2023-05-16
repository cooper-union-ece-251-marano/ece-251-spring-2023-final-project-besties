//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union                                                             //
// ECE 251 Spring 2023                                                          //
// Engineers: Ridwan Hussain and Ilona Lameka                                   //
//                                                                              //
//     Create Date: 2023-05-13                                                  //
//     Module Name: alu                                                         //
//     Description: ALU                                                         //
//                                                                              //
// Revision: 1.0                                                                //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////

`ifndef ALU
`define ALU

`timescale 1ns/100ps

module alu
		#(parameter n = 32)(
    input logic clk,
    input logic [(n-1):0] A, B, 
		input logic [3:0] aluControl,
    output logic [(n-1):0] result,
    output logic zero);

    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    logic [31:0] invB, sum;
		assign invB = ~(A);
    assign zero = (result == {32{1'b0}}); // zero result control signal

    always @(A, B, aluControl) begin
        case (aluControl)
            	4'b0000: result = A + B;           //add
            	4'b0001: result = A - B; //sub
							4'b0010: result = A << B;          //sl
							4'b0011: result = A >> B;          //sr
							4'b0100: result = A & B;           //and
            	4'b0101: result = A | B;           //or
							4'b0110: result = A ^ B;           //xor
							4'b0111: result = ~(A | B);        //nor
							4'b1000: result = ~(A & B);        //nand
							4'b1001: result = ~(A);            //not
							4'b1010: result = A + B;           //jr

							4'b1011: begin                     //slt
								if (A[31] != B[31]) begin
									if (A[31] > B[31]) begin 
											result = 1;
									end else begin
											result = 0;
									end 
								end else begin 
										if (A < B) begin
											result = 1;
										end	else begin
											result = 0;
										end
								end
							end
				
							4'b1100: begin                     //sgt
								if (A[31] != B[31]) begin
									if (A[31] < B[31]) begin
										result = 1;
									end else begin
										result = 0;
									end
								end else begin
									if (A > B) begin
										result = 1;
									end else begin
									result = 0;
									end
								end
							end
							
				endcase
    end

endmodule  //alu

`endif 
