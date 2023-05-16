/////////////////////////////////////////////////////////////////////////////////
// The Cooper Union                                                             //
// ECE 251 Spring 2023                                                          //
// Engineers: Ridwan Hussain and Ilona Lameka                                   //
//                                                                              //
//     Create Date: 2023-05-06                                                  //
//     Module Name: dff                                                         //
//     Description: A 32bit D-Flip Flop with a enable, clock and reset pin.     //
//                                                                              //
// Revision: 1.0                                                                //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////

`ifndef dff
`define dff
`timescale 100ps/10ps

module singledff(enable, reset, clk, D, Q);  
	input enable, reset, clk, D;
	output Q;
	wire nE, nclk, C, G1, G2, nQ;

	not #1 (nclk, clk);       //propagation so rising edge trigerred clk
	and (C, clk, nclk);       //when C is high, then D is read      
	
	and (G1, D, C, enable);   //Gate 1
	not (nD, D); 
	and (G2, nD, C, enable);  //Gate 2
	
	nor (Q, G2, nQ, reset);   //Output Q before async reset
	nor (nQ, G1, Q);          //Output nQ, also G4

endmodule

module dff 
    #(parameter n = 32)(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input  logic clk, reset, enable,
    input  logic [(n-1):0] D,
    output logic [(n-1):0] Q
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    always @(posedge clk, posedge reset)
    begin
        if (reset)
        begin
            Q <= 0;
        end
        else
        begin
            Q <= D;
        end
    end	


	/*// ---- PORT DEFINITIONS ---- //
	#(parameter n = 32)
	(input clk, reset,
	input [(n-1):0] enable, D,
	output [(n-1):0] Q,
	output nclk, C);

	// ---- MODULE DESIGN IMPLEMENTATION ---- //
	    #(parameter n = 32)(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input  logic CLOCK, RESET,
    input  logic [(n-1):0] D,
    output logic [(n-1):0] Q
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    always @(posedge CLOCK, posedge RESET)
    begin
        if (RESET)
        begin
            Q <= 0;
        end
        else
        begin
            Q <= D;
        end
    end


	genvar i;
	generate
		for (i = 0; i < n; i = i + 1'd1) begin
			singledff sff0(.enable(enable[i]), .reset(reset[i]), .clk(clk), .D(D[i]), .Q(Q[i]));
		end
	endgenerate

	always @(posedge clk, posedge reset)
    begin
        if (reset)
        begin
            Q <= 0;
        end
        else
        begin
            Q <= D;
        end
    end*/

endmodule

`endif //dff
