# Assembly Project

A collection of algorithms, routines, and low-level programs written in **Assembly language**, developed to demonstrate direct processor register interaction, low-level memory management, and system calls.

---

## Table of Contents

1. [Overview](#overview)
2. [Key Concepts & Features](#key-concepts--features)
3. [Project Structure](#project-structure)
4. [Prerequisites](#prerequisites)
5. [Build & Execution](#build--execution)
   - [x86 / x86-64 using NASM & LD (Linux)](#x86--x86-64-using-nasm--ld-linux)
   - [x86-64 Linking with GCC (C Library Interop)](#x86-64-linking-with-gcc-c-library-interop)
   - [16-bit TASM / MASM (DOSBox / Windows)](#16-bit-tasm--masm-dosbox--windows)
6. [Debugging with GDB](#debugging-with-gdb)
7. [Author](#author)
8. [License](#license)

---

## Overview

This repository explores fundamental computer architecture principles and low-level programming concepts, including:

- Direct CPU register manipulation (`RAX`, `RBX`, `RCX`, `RDX`, `RSI`, `RDI`, `RSP`, `RBP`, etc.).
- Stack frame mechanics: local variable storage, base pointer tracking, and standard calling conventions.
- Flow control using conditional branching, test operations, and jumps (`cmp`, `test`, `jmp`, `je`, `jne`, `jg`, `jle`).
- Memory segmentation (`.data`, `.bss`, `.rodata`, `.text`) and pointer dereferencing.
- Kernel interactions via Linux system calls (`sys_read`, `sys_write`, `sys_exit`).

---

## Key Concepts & Features

- [x] **Arithmetic & Bitwise Operations**: Logical shifts, rotations, bit masking, and arithmetic manipulation.
- [x] **String Manipulation & I/O**: Custom string length calculation, byte-by-byte copying, and numeric ASCII conversions.
- [x] **Calling Conventions**: Passing arguments through registers/stack adhering to System V AMD64 ABI standards.
- [x] **Low-Level Optimization**: Writing compact and cycle-efficient instructions.

---

## Project Structure

```text
Assembly/
├── src/                # Assembly source files (.asm / .s)
│   ├── main.asm        # Program entry point (_start / main)
│   └── utils.asm       # Helper functions and routines
├── include/            # Common macros and header files (.inc)
├── bin/ / build/       # Compiled object files and binaries (.o, executables)
├── Makefile            # Build automation
└── README.md           # Project documentation
```

> *Note: Adjust paths and filenames to match the exact structure of your repository.*

---

## Prerequisites

Depending on your target architecture and assembler dialect:

- **Assembler:** [NASM](https://www.nasm.us/) (Netwide Assembler), [FASM](https://flatassembler.net/), or [MASM/TASM].
- **Linker:** `ld` (GNU Linker) or `gcc`.
- **Debugger:** `gdb`, `EDB Debugger`, or `x64dbg`.

### Installation on Ubuntu / Debian

```bash
sudo apt update
sudo apt install build-essential nasm gdb
```

---

## Build & Execution

### x86 / x86-64 using NASM & LD (Linux)

1. **Assemble the source file into an object file:**
   ```bash
   nasm -f elf64 src/main.asm -o build/main.o
   ```
   *(For 32-bit systems, use `-f elf32`)*

2. **Link the object file:**
   ```bash
   ld build/main.o -o bin/program
   ```

3. **Run the executable:**
   ```bash
   ./bin/program
   ```

---

### x86-64 Linking with GCC (C Library Interop)

If using external C standard library functions (e.g., `printf`, `scanf`):

```bash
nasm -f elf64 src/main.asm -o build/main.o
gcc -no-pie build/main.o -o bin/program
./bin/program
```

---

### 16-bit TASM / MASM (DOSBox / Windows)

If the project targets 16-bit real mode under DOS:

```bat
TASM main.asm
TLINK main.obj
main.exe
```

---

## Debugging with GDB

To inspect registers and step through individual instructions:

1. **Compile with debugging symbols (`-g` and DWARF format):**
   ```bash
   nasm -f elf64 -g -F dwarf src/main.asm -o build/main.o
   ld build/main.o -o bin/program
   ```

2. **Start GDB:**
   ```bash
   gdb -tui ./bin/program
   ```

3. **Useful GDB commands:**
   - `layout asm` — Display the disassembly view.
   - `layout regs` — Display CPU register states in real time.
   - `break _start` (or `break main`) — Set a breakpoint at entry.
   - `run` — Start execution.
   - `stepi` / `si` — Step into next assembly instruction.
   - `nexti` / `ni` — Step over next assembly instruction.
   - `info registers` — Print all register contents.

---

## Author

- **David Farta** - [GitHub Profile](https://github.com/FartaDavid)

---