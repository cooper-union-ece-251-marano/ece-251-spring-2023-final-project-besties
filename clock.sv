//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union                                                             //
// ECE 251 Spring 2023                                                          //
// Engineers: Ridwan Hussain and Ilona Lameka                                   //
//                                                                              //
//     Create Date: 2023-05-06                                                  //
//     Module Name: clock                                                       //
//     Description: PWM clock signal, with a 50% duty cycle and an enable pin.  //
//                  The clock has a period of 1ns.                              //
//                                                                              //
// Revision: 1.0                                                                //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////

`ifndef CLOCK
`define CLOCK

`timescale 1ns/100ps

module clock
	// ---- PORT DEFINITIONS ---- //
	#(parameter ticks = 2) //Can be more if want to do pipelining, MUST BE EVEN #
	(input enable, output reg clk);

	// ---- MODULE DESIGN IMPLEMENTATION ---- //
	int clock_on = ticks/2; //50% on
	int clock_off = ticks/2; //50% off

	//initialize variables
	initial begin 
		clk = 0;
	end

	always @(posedge enable) begin //Clock only runs when ENABLE = 1 
		clk = 0;                //Clock starts off low, then oscillates b/w high and low
		while (enable) begin    
			#(clock_on) clk = 1;  //Delays by clock_on and clock_on in case
			#(clock_off) clk = 0; //Duty cycle =/= 50%
		end
	end

	always @(negedge enable) begin
		clk = 0;
	end

	//always (@negedge ENABLE) begin
	//
	//end

endmodule

`endif // CLOCK
