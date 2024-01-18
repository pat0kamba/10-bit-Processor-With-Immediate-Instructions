## 10-bit Processor with Immediate Instructions

# Problem
Design and build a 10-bit processor using System Verilog (SV) and demonstrate it on a DE10-Lite board based on the following requirements:
- The Data bus is 10-bits wide and is used to pass data between different elements of the processor.
- The 10-bit processor takes in data and instructions via an external source. Depending on the current instruction and the current timestep (saved in a 2-bit counter), the controller drives the control signals of the multi-stage processor circuit.
- All data is saved in one of four 10-bit registers (R0–R3) within the register file.
- To perform arithmetic and logic operations on the stored data, a multi-stage arithmetic logic unit (ALU) is used

# Solution
- Each of the 4 10-bit registers has 2 operations: Write-operation and Read-operation.
- Based on the processor’s instruction received on the data bus; data can be moved from one register to another or manipulated in other ways.
- The multi-stage ALU performs useful arithmetic operations on data held in the registers, and the ALU takes one common operand through the OP input.

# Electronic Devices
Multi-stage ALU, Processor controller, 4 10-bit Registers, Counter, 4 Seven-Segment decoders, Switches, LEDs, 2 Debouncers, all implemented on a DE10-Lite board
