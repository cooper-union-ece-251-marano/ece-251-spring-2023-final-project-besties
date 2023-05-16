//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union                                                             //
// ECE 251 Spring 2023                                                          //
// Engineers: Ridwan Hussain and Ilona Lameka                                   //
//                                                                              //
//     Create Date: 2023-05-09                                                  //
//     Module Name: tb_mainDec                                                  //
//     Description: Test bench for main decoder                                 //
//                                                                              //
// Revision: 1.0                                                                //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////
`ifndef TB_MAINDEC
`define TB_MAINDEC

`timescale 1ns/100ps

module tb_mainDec();
	reg [4:0] opCode;
	reg zero;
	wire regDst, regWrite, branch, memWrite, memToReg, jump, aluSrc;
	wire [3:0] aluControl;
	int i;

	mainDec uut(.opCode(opCode), .zero(zero), .regDst(regDst), .regWrite(regWrite), .branch(branch), .memWrite(memWrite), .memToReg(memToReg), .jump(jump), .aluSrc(aluSrc), .aluControl(aluControl));

	initial
	begin
		$display("op\tmemtoreg\tbranch\talusrc\tregdst\tregwrite\tjump\taluop");
		$monitor("%b\t%b\t\t%b\t%b\t%b\t%b\t%b\t%b\t", op, memtoreg, memwrite, branch, alusrc, regdst, regwrite, jump, aluop);
	end

	initial
	begin	
		opCode <= 5'b00000;
		for (i = 0; i < 32; i = i + 1)
		begin
			opCode = opCode + 5'b00001;
			#1;
		end
	
	end

endmodule // tb_mainDec

`endif
