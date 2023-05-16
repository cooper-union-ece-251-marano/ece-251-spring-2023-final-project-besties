//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union                                                             //
// ECE 251 Spring 2023                                                          //
// Engineers: Ridwan Hussain and Ilona Lameka                                   //
//                                                                              //
//     Create Date: 2023-05-13                                                  //
//     Module Name: tb_aluDec                                                   //
//     Description: Test bench for ALU decoder                                  //
//                                                                              //
// Revision: 1.0                                                                //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////
`ifndef TB_ALUDEC
`define TB_ALUDEC

`timescale 1ns/100ps

module tb_aluDec();
        reg [4:0] op;
				wire [3:0] alucontrol; 
        int i;

        aluDec uut(.op(op), .aluop(aluop), .alucontrol(alucontrol));

        initial
        begin
                $display("op\taluop\talucontrol");
                $monitor("%b\t%b\t%b", op, aluop, alucontrol);
        end

        initial
        begin

                op <= 5'b00000;
		aluop <= 2'b00;
                
		for (i = 0; i < 32; i = i + 1)
                begin
			op = op + 5'b00001;
			#1;
		end
		op <= 5'bxxxxx;
		for (i = 0; i < 4; i = i + 1)
		begin
			aluop = aluop + 2'b01;
			#1;
		end
	end


endmodule //tb_aluDec
`endif
