//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union                                                             //
// ECE 251 Spring 2023                                                          //
// Engineers: Ridwan Hussain and Ilona Lameka                                   //
//                                                                              //
//     Create Date: 2023-05-13                                                  //
//     Module Name: sl2                                                         //
//     Description: Shift 2 bits to the left (the same as mulitply by 4). We   //
//     implemented so that the 2 MSB will get dropped instead of rolling over.  //
//                                                                              //
// Revision: 1.2                                                                //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////

`ifndef sl2
`define sl2

module sl2
	#(parameter n = 32, parameter m = 32)
	// ---- PORT DEFINITIONS ---- //
	(input [(n-1):0] num,
	output [(m-1):0] num4);

	// ---- MODULE DESIGN IMPLEMENTATION ---- //
	genvar i;
	generate for (i = 0; i < (m - 2); i = i + 1) begin
		or(num4[i+2], num[i], 0);
	end
	endgenerate
	and(num4[0], 0, 0);
	and(num4[1], 0, 0);

	//assign num4 = num * 4;

endmodule

`endif // sl2
