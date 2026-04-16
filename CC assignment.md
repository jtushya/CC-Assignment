# CS f364 Compiler Construction Assignment

This assignment will be carried out in two phases. Students must work in groups of up to a maximum of 5 members.

---

## Phase 1: Language Design and Lexical Analysis

### Tasks

### 1. Selection of Programming Language

- Choose one programming language of your choice.  
- As per literature, there are more than 700 programming languages.  
- You may choose *any* language except **C, Python, and Java**.  
- A comprehensive list of programming languages is available at:  
  https://www.scriptol.com/programming/list-programming-languages.php  
  *(This link is only for reference; you may use other sources as well.)*  
- Each **group (5 members max.)** must choose a unique language.  
- Language selection follows a **first-come, first-served policy**.

---

### ❗ DEADLINE FOR REPORTING

Group leaders should report in-person to:

- **Ms Akella Amruta** *OR* **Mr Shubam**  
- **Venue:** H-117 Research Scholars' Lab  
- **Time:** 6pm to 7pm 13/02/26 *(Tomorrow)*  

You need to report the **members (Name & ID)** in your group and the **unique chosen language**.

---

### 2. Context-Free Grammar (CFG) Specification

- Formally specify the syntax of a minimal version of the chosen language using a CFG.
- The language must support:
  - Variable declarations  
  - Assignment statements  
  - Expressions (arithmetic, relational, and logical)  
  - One conditional statement  
  - One loop statement  
- The expression grammar must include at least one operator with multiple precedence levels.

---

### 3. Lexical Specification

- For each terminal symbol in the CFG, specify the corresponding regular expression.

---

### 4. Lexer Implementation

- Implement a Lexer using **Lex** to recognize tokens of your language.

---

### 5. Testing the Lexer

Run the lexer using:
- One valid input program  
- One input program with lexical errors  

---

### 🔴 PHASE 1 Implementation Submission Deadline  
**5:00PM 03-Mar-2026 (Tuesday)**  

*Mode of Submission will be posted soon.*

---

# Phase 2: Parsing and Intermediate Code Generation

### Tasks

### 1. Parser Implementation

- Implement a parser using **BISON** for the CFG submitted in Phase 1.
- Test the parser using:
  - One valid input program  
  - One input program with syntax errors  

---

### 2. Three Address Code Generation

- Implement a three-address code generator for the constructs defined in your CFG.
- Run the complete system (lexer + parser + code generator) using:
  - One valid input program  
  - One input program with errors  

---

### 🔴 PHASE 2 Implementation Submission Deadline  
**5:00PM 16-Apr-2026 (Thursday)**  