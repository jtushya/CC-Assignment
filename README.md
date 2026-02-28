# CS F365 — Compiler Construction (Group Repo)

This repository contains the scaffold for the Compiler Construction assignment (Phase 1 & Phase 2).

## What I did
- Added repository skeleton and placeholders for Phase 1 and Phase 2.
- Created example test files and a Windows build script template.

## Repo layout
- phase1/ — CFG, lexical spec, lexer placeholder
- phase2/ — parser placeholder and code-generator placeholder
- tests/ — example input programs (valid & error cases)
- README.md — this file

## Questions / Info I need from you
Please answer these so I can continue setting up and implement code:

1. Group & reporting
- Have you reported your group and chosen language to Ms Akella Amruta / Mr Shubam? If yes, which language was chosen and who is the group leader? If not, do you want me to reserve a language in the repo README?
- Full list of group members (Name & ID) to add to the repo.

2. Language selection details
- Which programming language did your group choose (must not be C, Python, or Java)?
- Confirm the exact features you want in the minimal language (which conditional and which loop syntax—e.g., `if (...) { ... }`, `while`, `for`, etc.).

3. Toolchain & environment
- Which development environment will you use (Windows native, WSL, Linux, or macOS)?
- Do you have access to GNU `flex`/`bison` (or `lex`/`yacc`)? If not, do you prefer a different toolchain (e.g., ANTLR, manual scanner/parser in another language)? The assignment requires Lex/Bison, so confirm whether to target GNU `flex`/`bison`.

4. Output format & conventions
- Any specific convention for three-address code (naming of temporaries, output text format) from instructors or prefered by your group?

5. Test programs & semantics
- Do you have example input programs or sample outputs to include? If not, should I draft basic valid and error test cases for your chosen language?

6. Git & remote
- Should I initialize a local git repo and (optionally) create a GitHub/GitLab remote for you? If yes, provide the remote URL or authorize creation.

7. Deliverables & report format
- Any required report template (PDF/LaTeX/Word) or naming conventions for submission?

## Next steps after you answer
- I'll fill `phase1/CFG.md` with a CFG template tailored to your chosen language.
- Generate starter `lex.l` and `parser.y` skeletons targeting `flex`/`bison` (unless you prefer otherwise).
- Add example test programs in `tests/` and a build script for your environment.

## Deadlines
- Phase 1: 5:00PM 03-Mar-2026
- Phase 2: 5:00PM 16-Apr-2026

---
Please reply with answers to the numbered questions above and any extra constraints (coding style, group workflow, CI, etc.).