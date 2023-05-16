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
`include "./clock.sv"
`include "./regFile.sv"
`include "./alu.sv"
`include "./dff.sv"
`include "./adder.sv"
`include "./sl2.sv"
`include "./mux2to1.sv"
`include "./signExtender.sv"

module datapath
	#(parameter n = 32, parameter r = 7)
	(input clk, reset,                              //clock inputs
	regDst, regWrite, branch, memWrite,             //Control Signals
	memToReg, jump, jalSelect, jalSelect2,          //Control Signals
	jrSelect,aluSrc, branchMuxSelect,               //Control Signals
	input [3:0] aluControl,                         //Control signals
	input [(n-1):0] instruction,                    //Instruction we gave
	readData,                                       //Data read from registers
	output zero,                                    //constant zero
	output [(n-1):0] pc,                            //Program count (reads 32 lines right now)
	aluOut,                                         //Output from the ALU
	writeData);                                     //Data to be written onto a register

	//Defining instruction blocks for easier code readability
	reg [6:0] iRegS, iRegT, iRegD;
	reg [12:0] iImm;
	reg [26:0] jumpAddr;
	reg [28:0] jumpAddrSh;
	assign iRegS = instruction[26:20];    //Register Source from Instruction
	assign iRegT = instruction[19:13];    //Register Target from Insturction
	assign iRegD = instruction[12:6];     //Register Destination from Instruction
	assign iImm = instruction[12:0];      //Immediate from Instruction
	assign jumpAddr = instruction[26:0];  //Jump address from Instruction

	// ---- MODULE DESIGN IMPLEMENTATION ---- //
	reg Cout1, Cout2;                                           //Extra outputs
	reg [(r-1):0] writeReg, regMux0;                                     //
	reg [(n-1):0] pcNext, pcNextBranch, pc4, pcBranch, 
		signExtImm, signExtImmSh, 
		srcA, srcB, 
		pcMuxInput0, pcMuxInput1,
		result, jalMuxOut, jrMuxOut;
	
	//Determines what the next PC logic is
	dff #(n) PC(.clk(clk), .reset(reset), .enable(1'b1), .D(pcNext), .Q(pc));
	  //DFF that stores all of the instructions that will be used for PC
	adder Add4(.A(pc), .B(4), .Cin(1'b0), .Cout(Cout1), .Sum(pc4));
	  //Adds 32 to the PC, since memory is word addressable for us, for Register instruction type
	sl2 signShift(.num(signExtImm), .num4(signExtImmSh));
	  //Shifts the signExtended number by 5
	adder pcAdder(.A(pc4), .B(signExtImmSh), .Cin(1'b0), .Cout(Cout2), .Sum(pcBranch));
	  //Adds 32 to the PC if for Immediate instruction type
	mux2to1 #(n) branchMux(.select(branchMuxSelect), .data0(jrMuxOut), .data1(pcBranch), .dataOut(pcMuxInput0));
	  //This is a mux for pc Branch, decides which branch the PC works on
	sl2 #(27, 29) sl2j(.num(jumpAddr), .num4(jumpAddrSh));
		//Left shifted jump addr so it can be combined with PC4 to make pcMuxInput1 for pcMux
	assign pcMuxInput1 = {pc4, jumpAddrSh};
	mux2to1 #(n) pcMux(.select(jump), .data0(pcMuxInput0), .data1(pcMuxInput1), .dataOut(pcNext));
	  //This is the mux that decides what the next cycle will be for the PC

	//Register File Logic
	regFile regFile(.clk(clk), .regWrite(regWrite), .readReg1(iRegS), .readReg2(iRegT), .writeReg(writeReg), .writeData(jalMuxOut), .readData1(srcA), .readData2(writeData));
	  //The registerFile for the Single-Cycle Implementation
	mux2to1 #(7) regMux(.select(regDst), .data0(regMux0), .data1(iRegD), .dataOut(writeReg));
	  //The mux that depends on what to write
	mux2to1 #(n) writeMux(.select(memToReg), .data0(aluOut), .data1(readData), .dataOut(result));
	  //Mux that does stuff
	signExtender signExt(.numIn(iImm), .numOut(signExtImm));
	  //sign Extends Immediate Value

	// ALU logic
	mux2to1 #(n) aluMux (.select(aluSrc), .data0(writeData), .data1(signExtImm), .dataOut(srcB));
	  //Another mux that does stuff, chooses between srcA and srcB
	alu alu(.clk(clk), .A(srcA), .B(srcB), .aluControl(aluControl), .result(aluOut), .zero(zero));
	  //Alu is the ALU

	//Jump register & JAL implemetations
	mux2to1 #(n) jalMux(.select(jalSelect), .data0(result), .data1(pc4), .dataOut(jalMuxOut));
	  //Mux to decide whether write data takes the input from writeMux or pc4 for JAL.
	mux2to1 #(7) jalMux2(.select(jalSelect2), .data0(iRegT), .data1(7'd127), .dataOut(regMux0));
		//Second mux to hardcode the pc4 to writeData.
	mux2to1 #(n) jrMux(.select(jrSelect), .data0(pc4), .data1(srcA), .dataOut(jrMuxOut));
		//Mux to decide whether pc should take in input from pc4 or srcA (which is jump register source).

endmodule

`endif // datapath
