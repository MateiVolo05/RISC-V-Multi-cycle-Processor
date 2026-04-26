# RISC-V Multi-cycle Processor with Exception Handling
## Verilog HDL Implementation of the RV32I ISA Subset

## 📌 Project Overview
This project features a **multi-cycle RISC-V processor** designed in **Verilog HDL**, following the RV32I Base Integer Instruction Set architecture. Unlike a single-cycle design, this implementation breaks down instruction execution into distinct states, allowing for resource sharing and a more modular hardware structure.

A standout feature of this implementation is the **integrated exception handling mechanism**, which manages arithmetic overflows and unrecognized opcodes using dedicated **EPC (Exception Program Counter)** and **Cause** registers.

## ⚙️ Technical Highlights
* **Architecture:** Multi-cycle Data Path orchestrated by a centralized Finite State Machine (FSM) Control Unit.
* **Exception Handling:**
    * Detects **arithmetic overflows** during ALU operations.
    * Identifies **invalid opcodes** and transitions to a specialized exception state.
    * Stores the faulty instruction address in the **EPC register** for debugging/recovery.
* **Memory System:** 1024-byte unified memory with word-aligned read/write capabilities.
* **Register File:** 32-bit general-purpose registers with x0 hardwired to zero.

## 🚀 Supported Instructions
The processor implements several instruction formats from the RV32I set:
* **R-Type:** ADD, SUB, AND, OR, XOR, SLT (Set Less Than).
* **I-Type:** Load Word (LW) and various immediate operations.
* **S-Type:** Store Word (SW).
* **B-Type:** Branch if Equal (BEQ).
* **U/J-Type Support:** Immediate generation logic included for extended addressing.

## 🛠 Project Structure
* `top.v`: The top-level module connecting the DataPath and ControlPath.
* `DataPath.v`: Coordinates the ALU, Register File, ImmGen, and Memory units.
* `ControlPath.v`: Implements the main FSM to orchestrate the processor's stages (Fetch, Decode, Execute, etc.).
* `ALU.v` & `ALUcontrol.v`: Arithmetic logic and operation decoding with overflow detection.
* `tb.v`: Testbench for verifying instruction execution and initial register state.
* `memory_data.mem`: Memory initialization file containing instruction opcodes.

## 🔧 Tools used
* **Language:** Verilog HDL
* **Simulation & Synthesis:** Xilinx Vivado

## 📈 Future Improvements
* [ ] Implement a **Pipelined** version of the RV32I architecture to increase instruction throughput.
* [ ] Expand exception handling to include misaligned memory access detection.
