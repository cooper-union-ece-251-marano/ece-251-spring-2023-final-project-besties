//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union                                                             //
// ECE 251 Spring 2023                                                          //
// Engineers: Ridwan Hussain and Ilona Lameka                                   //
//                                                                              //
//     Create Date: 2023-05-12                                                  //
//     Module Name: tb_regFile                                                  //
//     Description: Testbench to make sure the Register File works.             //
//                                                                              //
// Revision: 1.0                                                                //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/100ps
`include "../Clock/clock.sv"
`include "./regFile.sv"

module tb_regFile
	// ---- Defining variables to be used ---- //
	#(parameter n = 32, parameter r = 7);
	reg clk, clkEnable, regWrite;   //inputs are reg for test bench
	reg [(r-1):0] readReg1, readReg2, writeReg;
	reg [(n-1):0] writeData;
	wire [(n-1):0] readData1, readData2;     //outputs are wire for test bench
   
	// ---- INSTANTIATE UNIT UNDER TEST (UUT) ---- //
	regFile uut(.clk(clk), .regWrite(regWrite), .readReg1(readReg1), .readReg2(readReg2), .writeReg(writeReg), .writeData(writeData), .readData1(readData1), .readData2(readData2));
	clock uut1(.clk(clk), .enable(clkEnable));
	
	// ---- INITIALIZE TEST BENCH ---- //
	initial begin
		$dumpfile("regFile.vcd"); // for Makefile, make dump file same as module name
		$dumpvars(0, uut, uut1);
		$monitor("rR1=%x, rD1=%x, rR2=%x, rD2=%x", readReg1, readData1, readReg2, readData2);
		$monitor("clk=%b, wE=%x, wR=%x, wD=%x", clk, regWrite, writeReg, writeData);
	end

	//apply input vectors
	initial begin: apply_stimulus
		reg[6:0] tVect; //tVect[5] terminates the for loop
		reg[5:0] counter1 = 0;
		reg[5:0] counter2 = 0;
		regWrite = 1;
		clkEnable = 1;
		readReg1 = 102;
		//We expect that readData1 will return XXXXXXX until we reach clock cycle 32
		//We also expect there to be two cycles that readData1 returns XXXXXXXX
		//One because we turn off regWrite for one cycle, another because we
		//write to the register readData2 is looking at, not readData1
		//readData1 will update it's current timestamp every 8 cycles (so should
		//increment by 8).
		for (tVect = 0; tVect < 64; tVect = tVect + 1) begin
			writeData = tVect;
			writeReg = 64 - tVect;
			if (counter1 == 7) begin
				regWrite = 0;
			end
			if (counter1 == 8) begin
				regWrite = 1;
				counter1 = 0;
			end
			if (counter2 == 8) begin
				writeReg = 102;
				counter2 = 0;
			end 
			counter1 = counter1 + 1;
			counter2 = counter2 + 1;
			#1;
			readReg2 = tVect;
			#1;
		end
		$finish;
	end

endmodule

// `endif // tb_example
