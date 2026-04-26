# RISC-V Multi-cycle Processor with Exception Handling
## Verilog HDL Implementation of the RV32I ISA Subset

## 📌 Project Overview
[cite_start]This project features a **multi-cycle RISC-V processor** designed in **Verilog HDL**, following the RV32I Base Integer Instruction Set architecture[cite: 35, 43, 49, 69, 79, 82]. [cite_start]Unlike a single-cycle design, this implementation breaks down instruction execution into distinct states, allowing for resource sharing and a more modular hardware structure [cite: 50, 58-67].

[cite_start]A standout feature of this implementation is the **integrated exception handling mechanism**, which manages arithmetic overflows and unrecognized opcodes using dedicated **EPC (Exception Program Counter)** and **Cause** registers [cite: 83, 89-92].

## ⚙️ Technical Highlights
* [cite_start]**Architecture:** Multi-cycle Data Path orchestrated by a centralized Finite State Machine (FSM) Control Unit[cite: 49, 50, 82].
* [cite_start]**Exception Handling:** [cite: 83, 89-92]
    * [cite_start]Detects **arithmetic overflows** during ALU operations[cite: 30, 33, 91].
    * [cite_start]Identifies **invalid opcodes** and transitions to a specialized exception state[cite: 50, 67, 92].
    * [cite_start]Stores the faulty instruction address in the **EPC register** for debugging/recovery[cite: 83, 89].
* [cite_start]**Memory System:** 1024-byte unified memory with word-aligned read/write capabilities [cite: 43-45, 47].
* [cite_start]**Register File:** 32-bit general-purpose registers with $x0$ hardwired to zero [cite: 69-71, 77, 96].

## 🚀 Supported Instructions
[cite_start]The processor implements several instruction formats from the RV32I set [cite: 24-28, 51-54]:
* [cite_start]**R-Type:** ADD, SUB, AND, OR, XOR, SLT (Set Less Than)[cite: 31, 32, 51, 81].
* [cite_start]**I-Type:** Load Word (LW) and various immediate operations[cite: 24, 25, 51, 53, 54].
* [cite_start]**S-Type:** Store Word (SW)[cite: 26, 51, 55].
* [cite_start]**B-Type:** Branch if Equal (BEQ)[cite: 28, 52, 66].
* [cite_start]**U/J-Type Support:** Immediate generation logic included for extended addressing[cite: 26, 27].

## 🛠 Project Structure
* [cite_start]`top.v`: The top-level module connecting the DataPath and ControlPath[cite: 35].
* [cite_start]`DataPath.v`: Coordinates the ALU, Register File, ImmGen, and Memory units [cite: 82-84].
* [cite_start]`ControlPath.v`: Implements the main FSM to orchestrate the processor's stages (Fetch, Decode, Execute, etc.) [cite: 49, 50, 58-67].
* [cite_start]`ALU.v` & `ALUcontrol.v`: Arithmetic logic and operation decoding with overflow detection [cite: 30, 31, 79-81].
* [cite_start]`tb.v`: Testbench for verifying instruction execution and initial register state [cite: 20-22].
* [cite_start]`memory_data.mem`: Memory initialization file containing instruction opcodes.

## 🔧 Tools used
* **Language:** Verilog HDL
* **Simulation & Synthesis:** Xilinx Vivado

## 📈 Future Improvements
* [ ] Implement a **Pipelined** version of the RV32I architecture to increase instruction throughput.
* [ ] Expand exception handling to include misaligned memory access detection.
