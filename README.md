# 32-bit RISC-V Single-Cycle CPU | Logisim & SystemVerilog

A 32-bit single-cycle CPU implementing a subset of the RISC-V RV32I instruction set, designed from scratch at the datapath level in Logisim and subsequently implemented in SystemVerilog RTL using Intel Quartus Prime.

The project demonstrates processor architecture, digital logic design, RTL implementation, and functional verification through directed tests and SystemVerilog testbenches.

**Project Highlights**
- 32-bit single-cycle processor architecture
- 9 supported RV32I instructions
- Logisim schematic implementation
- Modular SystemVerilog RTL implementation
- Integrated CPU top-level module
- Directed functional testing and module-level testbenches

**Project Files**
- [Logisim CPU Design](rv32i_single_cycle_cpu.circ)
- [SystemVerilog RTL and Testbenches](CPU-RTL/)

## 1. Architecture

![CPU Top-Level Datapath](image.png)

The processor uses a **single-cycle architecture**, where each supported instruction completes within one clock cycle without pipelining.

### Main Components

| Component | Description |
|---|---|
| Program Counter | Maintains the current instruction address and determines the next PC |
| Instruction Memory | Supplies the instruction addressed by the PC |
| Instruction Decoder | Extracts opcode, register addresses, and function fields |
| Register File | 32 × 32-bit registers with two read ports and one write port; x0 is fixed at zero |
| Immediate Generator | Generates 32-bit sign-extended immediate values |
| Main Control Unit | Generates datapath control signals from the instruction opcode |
| ALU Control Unit | Selects the required ALU operation |
| 32-bit ALU | Performs arithmetic, logical, and comparison operations |
| Data Memory | Handles word load and store operations |
| Datapath Multiplexers | Select ALU operands and register write-back data |

Branch and jump decisions are integrated into the Program Counter's next-address selection logic.

## 2. Supported Instructions

The processor implements nine instructions from the RV32I instruction set.

| Instruction | Format | Operation |
|---|---|---|
| ADD | R | rd = rs1 + rs2 |
| SUB | R | rd = rs1 - rs2 |
| AND | R | rd = rs1 & rs2 |
| OR | R | rd = rs1 \| rs2 |
| ADDI | I | rd = rs1 + immediate |
| LW | I | Load 32-bit word from memory |
| SW | S | Store 32-bit word to memory |
| BEQ | B | Branch if rs1 == rs2 |
| JAL | J | Jump and write PC + 4 to rd |

The implementation supports this subset rather than the complete RV32I instruction set.

## 3. Instruction Execution

For sequential execution:

`next_pc = pc + 4`

For a taken BEQ or JAL:

`next_pc = pc + sign_extended_immediate`

A BEQ instruction updates the PC to the branch target only when the two source registers compare equal.

A JAL instruction changes the PC to the jump target and writes the return address (PC + 4) into the destination register.

## 4. SystemVerilog RTL Implementation

After completing the Logisim design, the processor was implemented at the RTL level using SystemVerilog.

The implementation follows a modular design approach, with separate components for the ALU, Register File, Program Counter, Instruction Memory, Immediate Generator, Main Control Unit, ALU Control Unit, and Data Memory.

A top-level CPU module integrates the datapath and control logic.

The SystemVerilog implementation and associated testbenches are available in the [CPU-RTL directory](CPU-RTL/).

## 5. Functional Verification

### Logisim Testing

Directed instruction sequences were used to verify processor functionality.

| Test Category | Instructions / Behavior | Reported Result |
|---|---|---|
| Arithmetic | ADD, SUB, ADDI | Passed |
| Logic | AND, OR | Passed |
| Memory | LW, SW | Passed |
| Control Flow | BEQ, JAL | Passed |
| PC Sequencing | Sequential, branch, jump | Passed |

**Example: Arithmetic Test**

```assembly
ADDI x7, x0, 10
ADDI x9, x0, 20
ADD  x2, x7, x9
```

Expected and observed Logisim register values:

```text
x7 = 10
x9 = 20
x2 = 30
```

An additional memory test stored and loaded the value 42 using SW and LW.

### SystemVerilog Testbenches

Module-level SystemVerilog testbenches were developed to exercise individual RTL components.

These tests are separate from the directed instruction sequences executed in Logisim.

The testbench source files are included in the [CPU-RTL directory](CPU-RTL/).

Simulation pass counts, coverage metrics, and end-to-end RTL verification results are not claimed without supporting evidence.

### Verification Roadmap

Potential extensions include:

- SystemVerilog Assertions (SVA) for architectural invariants
- Verification of the zero register (x0)
- Program Counter reset and sequencing properties
- Branch and jump correctness properties
- Formal verification of selected RTL components

These are potential future extensions, not completed formal verification results.

## 6. Running the Logisim Design

1. Download `rv32i_single_cycle_cpu.circ`.
2. Open the file using Logisim 2.7.1.
3. Navigate to `CPU_Top`.
4. Load a test program into the Instruction Memory.
5. Reset the simulation.
6. Toggle the clock to execute instructions.
7. Inspect the Program Counter, Register File, and Data Memory.

For RTL simulation, use a SystemVerilog-compatible simulator with the RTL and testbench files.

Intel Quartus Prime was used for RTL development. No FPGA deployment is claimed.

## 7. Repository Structure

```text
README.md
image.png
rv32i_single_cycle_cpu.circ
CPU-RTL/
    SystemVerilog RTL source files
    SystemVerilog testbenches
```

## 8. Current Limitations

- Implements nine RV32I instructions rather than the complete ISA.
- Single-cycle architecture without pipelining.
- No cache, interrupt, or exception handling.
- No FPGA deployment or timing-performance claims.
- No formal verification results or coverage metrics are currently reported.

## 9. Author

**Abed Alrahman Yosef**

B.Sc. Electrical Engineering Student  
Tel Aviv University

[LinkedIn](https://www.linkedin.com/in/abed-yosef-907527209)
