`timescale 1ns/100ps

`include "./datapath.sv"

module tb_datapath;

  // Inputs
  logic clk;
  logic reset;
  logic regDst;
  logic regWrite;
  logic branch;
  logic memWrite;
  logic memToReg;
  logic jump;
  logic aluSrc;
  //logic branchMuxSelect;
  logic [3:0] aluControl;
  logic [31:0] instruction;
  logic [31:0] readData;
  wire [31:0] writeData;

  // Outputs
  wire zero;
  wire [31:0] pc;
  wire [31:0] aluOut;

  // Instantiate the datapath module
  datapath dut (
    .clk(clk),
    .reset(reset),
    .regDst(regDst),
    .regWrite(regWrite),
    .branch(branch),
    .memWrite(memWrite),
    .memToReg(memToReg),
    .jump(jump),
    .aluSrc(aluSrc),
    .branchMuxSelect(1'b0), // You need to provide the correct value
    .aluControl(aluControl),
    .instruction(instruction),
    .readData(readData),
    .zero(zero),
    .pc(pc),
    .aluOut(aluOut),
    .writeData(writeData)
  );

  // Clock generation
  always #5 clk = ~clk;
	
initial begin
		$dumpfile("datapath.vcd");
		$dumpvars(0, dut);
		$monitor("clk%b\treset%b\tredDst%b\tregWrite%b\tbranch%b\tmemWrite%b\tmemToReg%b\tjump%b\taluSrc%b\taluControl%b\tinstruction%b\treadDate%b\t%zerob\tpc%b\taluOut%b\twriteData%b", clk,reset,regDst,regWrite,branch,memWrite,memToReg,jump,aluSrc,aluControl,instruction,readData,zero, pc,aluOut, writeData);
	end
  // Test stimulus
  initial begin
    clk = 0;
    reset = 1;
    regDst = 0;
    regWrite = 0;
    branch = 0;
    memWrite = 0;
    memToReg = 0;
    jump = 0;
    aluSrc = 0;
    aluControl = 0;
    instruction = 0;
    readData = 0;

    // Release reset after 10 clock cycles
    #50 reset = 0;

    // Provide input values and wait for a few clock cycles
    // Here you can specify different instructions and their corresponding inputs
    // You can add multiple test cases to cover different scenarios
    // Make sure to include appropriate delays between input changes to observe the output
    // Example test case:
    #10 regDst = 1;
    #10 regWrite = 1;
    #10 branch = 0;
    #10 memWrite = 0;
    #10 memToReg = 0;
    #10 jump = 0;
    #10 aluSrc = 0;
    #10 aluControl = 4'b0000; // Provide the appropriate ALU control signal for your instruction
    #10 instruction = 32'b11000000000000111010000000000001; // Provide the instruction
    #10 readData = 32'h00000001;

    // Add more test cases as needed

    // End the simulation
    #10 $finish;
  end

  // Add any necessary assertions or checks here

endmodule
