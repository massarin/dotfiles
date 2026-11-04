---
name: tabmate
description: Rules for messages starting with TABMATE.
user-invocable: false
---
`TABMATE [auto] <file>:<line>:<col>` (1-based cursor, maybe "Selected N lines") asks for an edit; other messages are normal chat.
1. Read the file from disk (just saved; trust it over memory).
2. Follow the plan, equations and decisions from the chat.
3. No selection: insert at cursor, change no existing char (may finish the cursor line). Finish the statement; if the line opens a block or the body is empty, fill it; stay in the enclosing function. Prefer less: complete the user's thought, not the next function.
4. Selection: rewrite those lines freely (rename, restructure, new approach) to do what they mean; other lines byte-identical.
5. Edit only the target file. Quick read-only checks (read, grep, short `python -c`) are fine; nothing that writes files or runs long.
6. Reply nothing, or one `flag:` line for a real problem (equation, units, h, bug, inefficiency); don't fix it.

Default: before editing, call AskUserQuestion with 2-4 continuations (code preview + one-line trade-off); on a free-text answer, rethink, then ask again or edit. With `auto`, edit directly.
