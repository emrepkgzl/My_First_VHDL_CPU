# My_First_VHDL_CPU

A simple 4-bit CPU designed from scratch in VHDL. This repo documents my learning process, including all modules (ALU, FSM, Counter) and their verification testbenches.

## 🏁 About This Project

This project is a hands-on journey into the fundamentals of digital logic design and computer architecture. The goal is to build a simple processor from the ground up, starting with basic logic units and assembling them into a more complex system.

Each module is designed, verified in simulation (using ModelSim), and then assembled into the next piece of the puzzle.

## 🛠️ Tools Used

* **Synthesis & PDR:** Intel Quartus Prime Lite Edition
* **Simulation & Verification:** ModelSim - Intel FPGA Edition

---

## 🚀 Project Modules & Progression

This project is built modularly. Each directory contains the VHDL source, its corresponding testbench, and a waveform proof of its successful simulation.

| Module | Name | Description | Status |
| :--- | :--- | :--- | :--- |
| **01** | `Full_Adder` | A 1-bit combinational adder. The most basic "math" unit. | **✅ Completed** |
| **02** | `4_Bit_Adder` | A structural 4-bit adder built by chaining 4 `Full_Adder` modules. | **✅ Completed** |
| **03** | `Counter` | A basic 4-bit counter. (Practice for sequential logic). | **✅ Completed** |
| **04** | `FSM_Detector` | A "101" sequence detector. (Practice for FSM "controller" logic). | **✅ Completed** |
| **05** | `ALU` | The Arithmetic Logic Unit (Datapath) of the CPU. | **✅ Completed** |
| **06** | `Control_Unit` | The FSM "brain" that manages the Fetch-Decode-Execute cycle. | **✅ Completed** |
| **07** | `Instruction_ROM`| The synchronous Read-Only Memory that stores the CPU's program. | **✅ Completed** |
| **08** | `Program_Counter`| An "enabled" counter that acts as the CPU's Program Counter (PC). | **✅ Completed** |
| **09** | `Register_File` | The multi-port short-term memory (registers) for the CPU. | **✅ Completed** |
| **10** | `CPU_Top` | The final "v1.0" integration, proving the F-D-E cycle works. | **✅ Completed** |
| **11** | `CPU_v2_Upgrade` | *(Planned)* Upgrading the CPU to support dynamic addressing and new commands. | **🕒 Planned** |

---

## 📖 Module Details

*(Note: Waveform proof images for completed modules will be added to their respective directories.)*

### 01_Full_Adder
* **Purpose:** To add three 1-bit inputs (A, B, Cin) and produce a 2-bit output (S, Cout).
* **Files:** `full_adder.vhd`, `tb_full_adder.vhd`

### 02_4_Bit_Adder
* **Purpose:** A structural design to add two 4-bit numbers using four `Full_Adder` components.
* **Files:** `four_bit_adder.vhd`, `tb_four_bit_adder.vhd`

### 03_Counter
* **Purpose:** A 4-bit sequential counter that increments on every clock edge. Introduces sequential logic (`rising_edge(clk)`) and asynchronous reset (`rst`).
* **Files:** `counter_4bit.vhd`, `tb_counter_4bit.vhd`

### 04_FSM_Detector
* **Purpose:** A Finite State Machine (FSM) that detects the "101" sequence. This is the first "intelligent" controller in the project, built using the standard two-process model (combinational "brain" and sequential "memory").
* **Files:** `sequence_detector.vhd`, `tb_sequence_detector.vhd`

### 05_ALU
* **Purpose:** The Arithmetic Logic Unit (ALU), the primary "datapath" (calculator) of the CPU. It performs four operations (ADD, SUB, AND, OR) based on a 2-bit `OpCode`.
* **Key Concept:** This module demonstrates professional **hardware reuse**. The single `four_bit_adder` component is used intelligently for *both* ADD (`A + B + 0`) and SUB (`A + (not B) + 1`) operations, saving significant hardware resources.
* **Files:** `alu.vhd`, `tb_alu.vhd`, `alu_waveform.png`

### 06_Control_Unit
* **Purpose:** The "brain" (Controller) of the CPU. This is a Finite State Machine (FSM) that manages the core `FETCH-DECODE-EXECUTE` cycle.
* **Key Concept:** This design applies the two-process FSM model (learned in module 04) to act as a system controller. It generates the correct output signals (like `PC_Enable`, `ROM_Enable`, `ALU_OpCode_Out`) depending on its current state (`FETCH`, `DECODE`, or `EXECUTE`).
* **Files:** `control_unit.vhd`, `tb_control_unit.vhd`, `control_unit_waveform.png`

### 07_Instruction_ROM
* **Purpose:** The Read-Only Memory (ROM) that stores the CPU's program. It acts as a "look-up table," providing the correct 2-bit instruction (`OpCode`) based on the 4-bit `Address` it receives.
* **Key Concept:** This module implements a **synchronous ROM** (`if rising_edge(clk)`). The program itself is defined as a `constant` array (Look-Up Table), which is the standard method for creating hardware-based ROMs in an FPGA.
* **Files:** `instruction_rom.vhd`, `tb_instruction_rom.vhd`, `instruction_rom_waveform.png`

### 08_Program_Counter
* **Purpose:** A 4-bit "smart" counter that acts as the CPU's Program Counter (PC). This module is an upgrade to `03_Counter`.
* **Key Concept:** This module introduces a **synchronous 'Enable' pin**. This is the critical link that allows the `06_Control_Unit` (brain) to control the PC (kas). The counter now only increments (`+1`) on a clock edge *if* the `Enable` pin is active ('1'). This allows the "brain" to pause the counter during the `DECODE` and `EXECUTE` states.
* **Files:** `program_counter.vhd`, `tb_program_counter.vhd`, `program_counter_waveform.png`

### 09_Register_File
* **Purpose:** The CPU's short-term memory "workbench" (R0-R15). This module holds the data that the ALU operates on and stores the results.
* **Key Concept:** This design demonstrates a professional **multi-port memory** architecture:
    1.  **Synchronous Write:** Data is written *only* on the `rising_edge(clk)` *if* `Write_Enable = '1'`.
    2.  **Asynchronous Read:** The two read ports (`Data_Out_A`, `Data_Out_B`) are combinational, providing data *immediately* when the read addresses change.
* **v1.0 Test Note:** For the `10_CPU_Top` integration test, the `rst` logic of this module was modified to pre-load `R1` with `5` and `R2` with `7`. This "test-hack" allowed for verification of the ALU's computation (`5+7`, `5-7`, etc.) before the CPU had a dedicated `LDI` (Load Immediate) instruction.
* **Files:** `register_file.vhd`, `tb_register_file.vhd`, `register_file_waveform.png`

### 10_CPU_Top
* **Purpose:** The final "v1.0" design. This is the "mainboard" module that structurally integrates all other verified components (`Control_Unit`, `Program_Counter`, `Instruction_ROM`, `ALU`, `Register_File`) into a single, working processor.
* **Key Concept:** This module is a pure **structural VHDL** design. It contains no logic, only `component` definitions, `signal` declarations (the "nervous system"), and `port map` blocks to connect all the "organs" of the CPU together.
* **v1.0 Limitation:** This initial CPU version uses **hardwired register addressing**. The `Control_Unit` does not yet know how to tell the `Register_File` *which* registers to read/write. We "hacked" this by wiring the `Register_File` to *always* read from `R1` and `R2`, and *always* write to `R3`.
* **Files:** `cpu_top.vhd`, `tb_cpu_top.vhd`, `cpu_top_waveform.png`

---

## 💡 Instruction Set Architecture (ISA) - v1.0

This is the official "language" that the v1.0 CPU understands.

The "v1.0" architecture uses a 2-bit `OpCode` (`1 downto 0`) provided by the `Instruction_ROM`. The register addresses are not part of the instruction and are **hardwired** in the `cpu_top` module.

**All v1.0 operations are implicitly:** `R3 = R1 [Operation] R2`

| OpCode (`w_rom_opcode`) | Mnemonic | Operation | Description |
| :---: | :---: | :--- | :--- |
| `"00"` | `ADD` | `R3 = R1 + R2` | Adds the contents of R1 and R2, stores in R3. |
| `"01"` | `SUB` | `R3 = R1 - R2` | Subtracts R2 from R1, stores in R3. |
| `"10"` | `AND` | `R3 = R1 and R2`| Bitwise ANDs R1 and R2, stores in R3. |
| `"11"` | `OR` | `R3 = R1 or R2` | Bitwise ORs R1 and R2, stores in R3. |