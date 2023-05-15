//////////////////////////////////////////////////////////////////////////
//                                                                      //
// EXAMPLE module                                                       //
//                                                                      //
// An example module for your Computer Architecture Elements Catalog    //
//                                                                      //
// module: example                                                      //
// hdl: Verilog                                                         //
//                                                                      //
// author: Ridwan Hussain <ridwan.hussain@cooper.edu>                   //
//                                                                      //
//////////////////////////////////////////////////////////////////////////

`ifndef DATAPATH
`define DATAPATH
`timescale 1ns/100ps
`include "../Clock/clock.sv"
`include "../RegFile/regFile.sv"
`include "../Alu/alu.sv"
`include "../DFF/dff.sv"
`include "../Adder32Bit/adder32Bit.sv"
`include "../Sl5/sl5.sv"
`include "../Mux2to1/mux2to1.sv"
`include "../SignExtender/signExtender.sv"

module datapath
	#(parameter n = 32, parameter r = 7)
	(input clk, reset,                    //clock inputs
	memToReg, pcSrc, aluSrc, regDst,      //mux select pints
	writeEnable,                          //writeEnable pin for writing to Regs
	jump,                                 //(?)
	input [3:0] aluControl,               //(?)
	input [(n-1):0] instruction,          //Instruction we gave
	readData,                             //Data read from registers
	output zero,                          //Constant zero (also reg 0)
	output [(n-1):0] pc,                  //Program count (reads 32 lines right now)
	aluOut,                               //Output from the ALU
	writeData);                           //Data to be written onto a register

	reg [6:0] iRegS, iRegT, iRegD;
	reg [12:0] iImm;
	assign iRegS = instruction[26:10];    //Register Source from Instruction
	assign iRegT = instruction[19:13];    //Register Target from Insturction
	assign iRegD = instruction[12:6];     //Register Destination from Instruction
	assign iImm = instruction[12:0];      //Immediate from Instruction

	// ---- MODULE DESIGN IMPLEMENTATION ---- //
	reg Cout1, Cout2;                                       //
	reg [(r-1):0] writeReg;                                     //
	reg [(n-1):0] pcNext, pcNextBranch, pcPlus32, pcBranch, 
		signExtImm, signExtImmSh, 
		srcA, srcB, 
		result;                                               //
			
	//Determines what the next PC logic is
	dff #(n) pcreg(.clk(clk), .reset({32{reset}}), .enable(1), .D(pcNext), .Q(pc));
	  //DFF that stores all of the instructions that will be used for PC
	adder32Bit pcAdd32(.A(pc), .B(32), .Cin(1'b0), .Cout(Cout1), .Sum(pcPlus32));
	  //Adds 32 to the PC, since memory is word addressable for us, for Register instruction type
	sl5 signShift(.num(signExtImm), .num32(signExtImmSh));
	  //Shifts the signExtended number by 5
	adder32Bit pcAdd32again(.A(pcPlus32), .B(signExtImmSh), .Cin(1'b0), .Cout(Cout2), .Sum(pcBranch));
	  //Adds 32 to the PC if for Immediate instruction type
	mux2to1 #(n) pcBranchMux(.select(pcSrc), .data0(pcPlus32), .data1(pcBranch), .dataOut(pcNextBranch));
	  //This is a mux for pc Branch, decides which branch the PC works on
	mux2to1 #(n) pcMux(.select(jump), .data0(pcNextBranch), .data1(pcPlus32), .dataOut(pcNext));
	  //This is the mux that decides what the next cycle will be for the PC

	//Register File Logic
	regFile rf(.clk(clk), .writeEnable(writeEnable), .readReg1(iRegS), .readReg2(iRegT), .writeReg(writeReg), .writeData(result), .readData1(srcA), .readData2(writeData));
	  //The registerFile for the Single-Cycle Implementation
	mux2to1 #(7) wrMux(.select(regDst), .data0(iRegT), .data1(iRegD), .dataOut(writeReg));
	  //The mux that depends on what to write
	mux2to1 #(n) resMux(.select(memToReg), .data0(aluOut), .data1(readData), .dataOut(result));
	  //Mux that does stuff
	signExtender signExt(.numIn(iImm), .numOut(signExtImm));
	  //sign Extends Immediate Value

	// ALU logic
	mux2to1 #(n) srcBMux (.select(aluSrc), .data0(writeData), .data1(signExtImm), .dataOut(srcB));
	  //Another mux that does stuff, chooses between srcA and srcB
	alu alu(.clk(clk), .a(srcA), .b(srcB), .alucontrol(aluControl), .result(aluOut), .pc(pc), .zero(zero));
	  //Alu is the ALU

endmodule

`endif // EXAMPLE
