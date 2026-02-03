🏡 Remote Area Resource Management System
(8086 Assembly Language – EMU8086)

A menu-driven, file-based database system developed in 8086 Assembly Language using EMU8086, designed to manage family records and track consumption of essential resources in remote areas.

📌 Project Overview

Managing resources in remote areas requires accurate record keeping and consumption tracking. This project provides a simple but effective solution using low-level assembly programming, demonstrating file handling, data validation, and statistics calculation under DOS.

The system stores records permanently in a text file and prevents duplicate entries.

✨ Features

📋 Menu-driven interface

➕ Add new family records

❌ Duplicate Serial Number prevention

💾 Permanent file storage (record.txt)

📊 Total consumption statistics

⌨️ Keyboard input validation

⚙️ Fully modular assembly procedures

🧾 Record Format (Saved in File)

Each record is stored in the following format:

ID,FamilyMembers,Water


Each entry is written on a new line inside record.txt.

🧠 Concepts Used

8086 Registers (AX, BX, CX, DX)

DOS Interrupts (INT 21H)

File Handling (Create, Open, Write, Close)

Loops & Procedures

Numeric Input & Output

Memory Management

🛠 Tools & Technologies
Tool	Purpose
EMU8086	Assembly Emulator
8086 Assembly	Programming Language
DOS Interrupts	I/O and File Handling
Text File	Persistent Storage
📜 Menu Options

Add New Record

Show Total Consumption

Exit Program

🖥 Screenshots

📸 Screenshots taken from EMU8086 emulator

Main Menu Display

Add New Record Input

Duplicate ID Error

Record Saved Confirmation

Total Consumption Statistics

Saved File (record.txt)

⚠️ Limitations

Maximum of 9 unique records

No record deletion or update

File reading not implemented

Name length limited to 10 characters

🚀 Future Improvements

Add record viewing from file

Implement delete & update functionality

Increase record limit

Add sorting and searching

Improve file format (CSV full fields)

🎓 Educational Purpose

This project is developed for academic learning, focusing on:

Low-level programming

DOS-based file handling

Understanding system architecture

Strengthening assembly language concepts

▶️ How to Run

Open EMU8086

Load the .asm file

Compile and run

Follow on-screen menu instructions
