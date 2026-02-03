# GL Reflection

Through doing multiple challenges in **pwn.college**, I have learned much about the logic and the rules of Assembly.

For example, there was a challenge which asked me to calculate the average of 4 consecutive quad words stored on the stack and push the average on the stack without using `pop`.

This challenge was significant because it forced me to abandon my previous understanding of the stack as a strict **'Last-In, First-Out'** structure where I could only interact with the top item. Instead, I learned to utilise **pointer arithmetic** relative to the Stack Pointer (`rsp`).

By adding offsets (e.g., `[rsp + 8]`, `[rsp + 16]`), I was able to 'peek' deeper into the stack to retrieve data non-destructively. This taught me that the stack is simply a region of memory like any other, and as long as I understand the data size (8 bytes for a Quad Word), I can access any part of it directly without modifying the stack pointer itself.

### Code Example
```assembly
; Paste your solution code for the stack challenge here
; Example:
; mov rax, [rsp]
; add rax, [rsp + 8]
