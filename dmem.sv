//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union                                                             //
// ECE 251 Spring 2023                                                          //
// Engineers: Ridwan Hussain and Ilona Lameka                                   //
//                                                                              //
//     Create Date: 2023-05-12                                                  //
//     Module Name: dmem                                                        //
//     Description: Data Memory for the computer; stores the output. It is 128- //
//     bits and we have 7 bits for our registers (for a total of 128 registers).//
//                                                                              //
// Revision: 1.2                                                                //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////

`ifndef dmem
`define dmem

module dmem
	// ---- PORT DEFINITIONS ---- //
	//n is the size of each register; r is the lenght of addr (limited by verilog emulator)
	#(parameter n = 32, parameter r = 7)
	(input clk, memWrite,
	input [(n-1):0] addr, writeData, 
	output [(n-1):0] readData);

	// ---- MODULE DESIGN IMPLEMENTATION ---- //
	reg [(n-1):0] RAM[0:(2**r-1)]; //memory fills up from the bottom up

	always @(posedge clk) begin //We write on rising clk edge
		if (memWrite) begin //Checks to see if the register is writable
			RAM[addr[(n-1):2]] = writeData; 
		end
	end
	
	assign readData = RAM[addr[(n-1):2]];

	/*reg intermediate;
	assign intermediate = RAM[addr[(n-1):2]];
	always @(negedge clk) begin //We read memory on falling edge trigger
		if (memRead) begin
			//assign readData = RAM[addr[(n-1):2]];
			//readData = intermediate;
		end
	end*/

endmodule

`endif // dmem
