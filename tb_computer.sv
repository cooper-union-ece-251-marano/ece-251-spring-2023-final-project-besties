//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union                                                             //
// ECE 251 Spring 2023                                                          //
// Engineers: Ridwan Hussain and Ilona Lameka                                   //
//                                                                              //
//     Create Date: 2023-05-14                                                  //
//     Module Name: tb_computer                                                 //
//     Description: Testbench for the computer. Reads instructions from         // 
//     prorgam_exe.                                                             //
//                                                                              //
// Revision: 1.0                                                                //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////
`ifndef TB_COMPUTER
`define TB_COMPUTER

`timescale 1ns/100ps

`include "./computer.sv"
`include "./clock.sv"

module tb_computer;
  parameter n = 32; // # bits to represent the instruction / ALU operand / general purpose register (GPR)
  parameter m = 6;  // # bits to represent the address of the 2**m=32 GPRs in the CPU
  logic clk;
  logic clk_enable;
  logic reset;
  logic memWrite;
	logic [31:0] writeData;
  logic [31:0] dataAddr;

  logic firstTest, secondTest;

  // instantiate the CPU as the device to be tested
  computer dut(clk, reset, writeData, dataAddr, memWrite);
  // generate clock to sequence tests
  // always
  //   begin
  //     clk <= 1; # 5; clk <= 0; # 5;
  //   end

  // instantiate the clock
  clock dut1(.enable(clk_enable), .clk(clk));


  initial begin
    firstTest = 1'b0;
    secondTest = 1'b0;
    $dumpfile("computer.vcd");
    $dumpvars(0, dut, dut1);
    $monitor("t=%t\t0x%7h\t%7d\t%8d",$realtime,writeData,dataAddr,memWrite);
    // $dumpvars(0,clk,a,b,ctrl,result,zero,negative,carryOut,overflow);
    // $display("Ctl Z  N  O  C  A                    B                    ALUresult");
    // $monitor("%3b %b  %b  %b  %b  %8b (0x%2h;%3d)  %8b (0x%2h;%3d)  %8b (0x%2h;%3d)",ctrl,zero,negative,overflow,carryOut,a,a,a,b,b,b,result,result,result);
  end

  // initialize test
  initial begin
		#0 clk_enable <= 0; #50 reset <= 1; # 50; reset <= 0; #50 clk_enable <= 1;
    #10 reset <= 1; #10 reset <= 0;
		#100 $finish;
  end

  // monitor what happens at posedge of clock transition
  always @(posedge clk)
  begin
      $display("+");
      $display("\t+instr = 0x%8h",dut.instr);
      $display("\t+op = 0b%5b",dut.mips.c.opCode);
      $display("\t+controls = 0b%9b",dut.mips.c.md.controls);      
      $display("\t+alu result = 0x%8h",dut.mips.dp.alu.result);
     // $display("\t+HiLo = 0x%8h",dut.mips.dp.alu.HiLo);
      $display("\t+$zero = 0x%4h",dut.mips.dp.regFile.registers[0]);
      $display("\t+$v0 = 0x%4h",dut.mips.dp.regFile.registers[3]);
      $display("\t+$v1 = 0x%4h",dut.mips.dp.regFile.registers[4]);
      $display("\t+$a0 = 0x%4h",dut.mips.dp.regFile.registers[19]);
      $display("\t+$a1 = 0x%4h",dut.mips.dp.regFile.registers[20]);
      $display("\t+$t0 = 0x%4h",dut.mips.dp.regFile.registers[29]);
      $display("\t+$t1 = 0x%4h",dut.mips.dp.regFile.registers[30]);
      $display("\t+$t2 = 0x%4h",dut.mips.dp.regFile.registers[31]);
      $display("\t+$t3 = 0x%4h",dut.mips.dp.regFile.registers[32]);
      $display("\t+$t4 = 0x%4h",dut.mips.dp.regFile.registers[33]);
      $display("\t+$t5 = 0x%4h",dut.mips.dp.regFile.registers[34]);
      $display("\t+$t6 = 0x%4h",dut.mips.dp.regFile.registers[35]);
      $display("\t+$t7 = 0x%4h",dut.mips.dp.regFile.registers[36]);
      $display("\t+$t8 = 0x%4h",dut.mips.dp.regFile.registers[37]);
      $display("\t+$t9 = 0x%4h",dut.mips.dp.regFile.registers[38]);
      $display("\t+$t10 = 0x%4h",dut.mips.dp.regFile.registers[39]);
      $display("\t+$t11 = 0x%4h",dut.mips.dp.regFile.registers[40]);
      $display("\t+$t12 = 0x%4h",dut.mips.dp.regFile.registers[41]);
      $display("\t+$t13 = 0x%4h",dut.mips.dp.regFile.registers[42]);
      $display("\t+$t14 = 0x%4h",dut.mips.dp.regFile.registers[43]);
      $display("\t+$t15 = 0x%4h",dut.mips.dp.regFile.registers[44]);
      $display("\t+regfile -- ra1 = %d",dut.mips.dp.regFile.readReg1);
      $display("\t+regfile -- ra2 = %d",dut.mips.dp.regFile.readReg2);
      $display("\t+regfile -- we3 = %d",dut.mips.dp.regFile.regWrite);
      $display("\t+regfile -- wa3 = %d",dut.mips.dp.regFile.writeReg);
      $display("\t+regfile -- wd3 = %d",dut.mips.dp.regFile.writeData);
      $display("\t+regfile -- rd1 = %d",dut.mips.dp.regFile.readData1);
      $display("\t+regfile -- rd2 = %d",dut.mips.dp.regFile.readData2);
      $display("\t+RAM[%4d] = %4d",dut.dmem.addr,dut.dmem.readData);
      $display("writeData\tdataAddr\tmemWrite");
  end

  // run program
  // monitor what happens at negedge of clock transition
  always @(negedge clk) begin
    $display("-");
    $display("\t-instr = 0x%8h",dut.instr);
    $display("\t-op = 0b%5b",dut.mips.c.opCode);
    $display("\t-controls = 0b%4b",dut.mips.c.md.controls);
    $display("\t-alu result = 0x%8h",dut.mips.dp.alu.result);
//    $display("\t-HiLo = 0x%8h",dut.mips.dp.alu.HiLo);
    $display("\t+$zero = 0x%4h",dut.mips.dp.regFile.registers[0]);
    $display("\t-$v0 = 0x%4h",dut.mips.dp.regFile.registers[3]);
    $display("\t-$v1 = 0x%4h",dut.mips.dp.regFile.registers[4]);
    $display("\t-$a0 = 0x%4h",dut.mips.dp.regFile.registers[19]);
    $display("\t-$a1 = 0x%4h",dut.mips.dp.regFile.registers[20]);
    $display("\t-$t0 = 0x%4h",dut.mips.dp.regFile.registers[29]);
    $display("\t-$t1 = 0x%4h",dut.mips.dp.regFile.registers[30]);
    $display("\t+$t2 = 0x%4h",dut.mips.dp.regFile.registers[31]);
    $display("\t+$t3 = 0x%4h",dut.mips.dp.regFile.registers[32]);
    $display("\t+$t4 = 0x%4h",dut.mips.dp.regFile.registers[33]);
    $display("\t+$t5 = 0x%4h",dut.mips.dp.regFile.registers[34]);
    $display("\t+$t6 = 0x%4h",dut.mips.dp.regFile.registers[35]);
    $display("\t+$t7 = 0x%4h",dut.mips.dp.regFile.registers[36]);
    $display("\t+$t8 = 0x%4h",dut.mips.dp.regFile.registers[37]);
    $display("\t+$t9 = 0x%4h",dut.mips.dp.regFile.registers[38]);
    $display("\t+$t10 = 0x%4h",dut.mips.dp.regFile.registers[39]);
    $display("\t+$t11 = 0x%4h",dut.mips.dp.regFile.registers[40]);
    $display("\t+$t12 = 0x%4h",dut.mips.dp.regFile.registers[41]);
    $display("\t+$t13 = 0x%4h",dut.mips.dp.regFile.registers[42]);
    $display("\t+$t14 = 0x%4h",dut.mips.dp.regFile.registers[43]);
    $display("\t+$t15 = 0x%4h",dut.mips.dp.regFile.registers[44]);
    $display("\t-regfile -- ra1 = %d",dut.mips.dp.regFile.readReg1);
    $display("\t-regfile -- ra2 = %d",dut.mips.dp.regFile.readReg2);
    $display("\t-regfile -- we3 = %d",dut.mips.dp.regFile.regWrite);
    $display("\t-regfile -- wa3 = %d",dut.mips.dp.regFile.writeReg);
    $display("\t-regfile -- wd3 = %d",dut.mips.dp.regFile.writeData);
    $display("\t-regfile -- rd1 = %d",dut.mips.dp.regFile.readData1);
    $display("\t-regfile -- rd2 = %d",dut.mips.dp.regFile.readData2);
    $display("\t+RAM[%4d] = %4d",dut.dmem.addr,dut.dmem.readData);
    $display("writeData\tdataAddr\tmemWrite");
  end

  always @(negedge clk, posedge clk) begin
    // check results
    // TODO: You need to update the checks below
    // if (dut.dmem.RAM[84] === 32'h9504)
    //   begin
    //     $display("Successfully wrote 0x%4h at RAM[%3d]",84,32'h9504);
    //     firstTest = 1'b1;
    //   end

    if (dut.dmem.RAM[84] === 32'h96)
      begin
        $display("Successfully wrote 0x%4h at RAM[%3d]",84,32'h0096);
        firstTest = 1'b1;
      end
    if(memWrite) begin
      if(dataAddr === 84 & writeData === 32'h96)
      begin
        $display("Successfully wrote 0x%4h at RAM[%3d]",writeData,dataAddr);
        firstTest = 1'b1;
      end
    end
    if (firstTest === 1'b1)
    begin
        $display("Program successfully completed");
        $finish;
    end
  end

endmodule

`endif // TB_COMPUTER
