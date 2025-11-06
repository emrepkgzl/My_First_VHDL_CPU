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
| **03** | `Counter` | A 4-bit sequential counter with asynchronous reset (learns `clk` & `rst`). | **✅ Completed** |
| **04** | `FSM_Detector` | A "101" sequence detector. The first "brain" (FSM) of the project. | **✅ Completed** |
| **05** | `ALU` | **(In Progress)** The Arithmetic Logic Unit, the "calculator" of the CPU. | **🚧 In Progress** |
| **06** | `Control_Unit` | *(Planned)* The FSM "brain" that tells the ALU what to do. | **🕒 Planned** |
| **07** | `Register_File` | *(Planned)* The short-term memory (registers) for the CPU. | **🕒 Planned** |

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
* **Purpose:** (In Progress) The Arithmetic Logic Unit. This will be the "datapath" or "calculator" of the CPU, capable of performing multiple operations (e.g., ADD, SUB, AND, OR) based on an input command.
* **Files:** `alu.vhd`, `tb_alu.vhd`
