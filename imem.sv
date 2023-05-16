//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union                                                             //
// ECE 251 Spring 2023                                                          //
// Engineers: Ridwan Hussain and Ilona Lameka                                   //
//                                                                              //
//     Create Date: 2023-05-12                                                  //
//     Module Name: imem                                                        //
//     Description: A 32-bit instruction memory module, which is READ-only.     //
//     This is where the code for a program gets read and will be later sent to //
//     other parts of the CPU to be interpreted.                                //
//                                                                              //
// Revision: 1.0                                                                //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////

`ifndef imem
`define imem

module imem
	#(parameter n = 32, parameter r = 7)
	// ---- PORT DEFINITIONS ---- //
	(input [(r-1):0] readAddr, 
	output [(n-1):0] instr);
	
	// ---- MODULE DESIGN IMPLEMENTATION ---- //
	reg [(n-1):0] RAM[0:(2**r-1)];

	initial begin
		$readmemh("program_exe", RAM);
		//We're calling our output file program_exe instead of program.exe because
		//out .gitignore file.
	end

	assign instr = RAM[readAddr]; //word aligned

endmodule

`endif // imem
