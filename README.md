# 🏡 Remote Area Resource Management System  
### (8086 Assembly Language – EMU8086)

A **menu-driven, file-based database system** developed in **8086 Assembly Language** using **EMU8086**, designed to manage family records and track consumption of essential resources in remote areas.

---

## 📌 Project Overview

Managing resources in remote areas requires accurate record keeping and consumption tracking. This project provides a simple but effective solution using **low-level assembly programming**, demonstrating file handling, data validation, and statistics calculation under DOS.

The system stores records permanently in a text file and prevents duplicate entries.

---

## ✨ Features

- 📋 Menu-driven interface  
- ➕ Add new family records  
- ❌ Duplicate Serial Number prevention  
- 💾 Permanent file storage (`record.txt`)  
- 📊 Total consumption statistics  
- ⌨️ Keyboard input validation  
- ⚙️ Modular assembly procedures  

---

## 🧾 Record Format

Each record is saved in the following format:

Each record is written on a new line inside `record.txt`.

---

## 🧠 Concepts Used

- 8086 Registers (AX, BX, CX, DX)
- DOS Interrupts (`INT 21H`)
- File Handling (Create, Open, Write, Close)
- Loops and Procedures
- Numeric Input and Output
- Memory Management

---

## 🛠 Tools & Technologies

| Tool | Purpose |
|------|--------|
| EMU8086 | Assembly Emulator |
| 8086 Assembly | Programming Language |
| DOS Interrupts | I/O and File Handling |
| Text File | Persistent Storage |
---

## 📜 Menu Options

1. Add New Record  
2. Show Total Consumption  
3. Exit Program   

---

## ⚠️ Limitations

- Maximum of 9 records  
- No record update or deletion  
- File reading not implemented  
- Fixed-length input fields  

---

## 🚀 Future Improvements

- Add record viewing from file  
- Implement update and delete features  
- Increase storage limit  
- Add searching and sorting  
- Improve file structure (CSV format)  

---

## 🎓 Educational Purpose

This project is developed for academic learning, focusing on:

- Low-level programming concepts  
- DOS-based file handling  
- Understanding computer architecture  
- Assembly language mastery  

---

## ▶️ How to Run

1. Open EMU8086  
2. Load the `.asm` file  
3. Compile and run the program  
4. Follow on-screen menu instructions  


This project is for educational purposes only.
