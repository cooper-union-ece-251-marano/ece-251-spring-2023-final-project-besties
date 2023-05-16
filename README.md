# Computer-Architecture
Created a CPU in Verilog for ECE251 Final Project created by Ilona Lameka and Ridwan Hussain.

# ISA for Besties CPU
![image](https://github.com/Ridwan-Hussain/Computer-Architecture/assets/114603278/b86b4ca5-3611-4f51-b5e2-3201a9b521e0)
<sup>Datapath for our CPU.</sup>

![image](https://github.com/cooper-union-ece-251-marano/ece-251-spring-2023-final-project-besties/assets/114603278/b3b5e5cf-3976-456e-8043-a9025855ca68)
<sup>Format for the registers based on their values are defined.</sup>

![image](https://github.com/Ridwan-Hussain/Computer-Architecture/assets/114603278/d3ffbb4a-12b0-439f-a2ce-7703e0aa9b65)
<sup>Register, Immediate, and Address Instruction Types Formating</sup>

![image](https://github.com/Ridwan-Hussain/Computer-Architecture/assets/114603278/df0eed54-47c4-412b-90be-76972f3918a8)
<sup>The instructions we defined for R-type and how their bit values are defined.</sup>

![image](https://github.com/Ridwan-Hussain/Computer-Architecture/assets/114603278/ebdd376d-3438-4d3c-a71f-5a3a8e21f683)
<sup>The instructions we defined for I-type and how their bit values are defined.</sup>

![image](https://github.com/Ridwan-Hussain/Computer-Architecture/assets/114603278/c13264f9-f2df-4e49-99b9-e8aac4e7815c)
<sup>The instructions we defined for J-type and how their bit values are defined.</sup>

1. The ALU Operand Size is 32 bits.
2. We'd support 12 ALU operations: add, subtract, shift left, shift right, and, or, xor, nor, nand, nor, jr, set less than, and set greater than.
3. The Operational Code (OpCode) will be 5 bits.
4. We'll provide 128 registers for the programs (7 bits for register addressing).
5. We will have a return address to receive the results of the ALU ($ra, reg #127)
6. We'll have 3 types of instruction format: Register (R), Immediate (I), & Jump (J)
7. Our instruction width will be a fixed value of 32 bits.
8. We'll design our datapath and Control Unit similar to MIPs but make any changes we want/need to make.
9. The datapath and control unit will be implemented using a single-cycle instruction execution since will plan on using RISC.
10. The single-cycle implementation won't be converted to a pipelined design.
11. Our Verilog Components include: Adder, Alu, AluDecoder, Clock, Computer, Controller, Cpu, D-Flip Flops, Datapath, Dmem, FullAdder, Imem, MainDecoder, Mux (2:1), RegisterFile, SignExtender, and Sl2 (Shift left 2)

# Other Decisions Made
- First two bits for OpCode determine instruction type (01 or 10 for Register, 11 for Immediate, 00 for Jump)
- We'll be storing our numbers using Little Endianness
- Registers are written on rising edge
- For our code, n=32 bits and r=7 bits. n is for the operand bit size and r represents the number of bits we have for our registers.

