//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union                                                             //
// ECE 251 Spring 2023                                                          //
// Engineers: Ridwan Hussain and Ilona Lameka                                   //
//                                                                              //
//     Create Date: 2023-05-13                                                  //
//     Module Name: Mux2to1                                                     //
//     Description: A 2 to 1 Multiplexer to decide which data signal to send in  //
//     for different parts of the datapath.                                     //
//                                                                              //
// Revision: 1.0                                                                //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////

`ifndef mux2to1
`define mux2to1

module mux2to1
	#(parameter n = 32)
	// ---- PORT DEFINITIONS ---- //
	(input select,
	input  [(n-1):0] data0, data1,
	output [(n-1):0] dataOut);

	// ---- MODULE DESIGN IMPLEMENTATION ---- //
	wire nSelect;
	wire [(n-1):0] selectD0, selectD1;

	not(nSelect, select);
	genvar i;
	generate for (i = 0; i < n; i = i + 1) begin
		and(selectD0[i], nSelect, data0[i]);
		and(selectD1[i], select, data1[i]);
		or(dataOut[i], selectD0[i], selectD1[i]);
	end
	endgenerate 

endmodule

`endif // mux2to1
