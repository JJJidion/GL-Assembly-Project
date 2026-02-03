calc.asm
section .data
    prompt1 db "Enter first digit (0-9): "
    prompt1_len equ $ - prompt1

    prompt2 db "Enter second digit (0-9): "
    prompt2_len equ $ - prompt2

    result_msg db "Result: "
    result_msg_len equ $ - result_msg

    newline db 10

section .bss
    num1 resb 2
    num2 resb 2
    res resb 3         ; two digits max + null

section .text
    global _start

_start:
    ; --- Prompt first number ---
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt1
    mov edx, prompt1_len
    int 0x80

    ; --- Read first number ---
    mov eax, 3
    mov ebx, 0
    mov ecx, num1
    mov edx, 2
    int 0x80

    ; --- Prompt second number ---
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt2
    mov edx, prompt2_len
    int 0x80

    ; --- Read second number ---
    mov eax, 3
    mov ebx, 0
    mov ecx, num2
    mov edx, 2
    int 0x80

    ; --- Convert ASCII to number ---
    mov al, [num1]
    sub al, '0'
    mov bl, [num2]
    sub bl, '0'

    ; --- Add numbers ---
    add al, bl         ; sum in AL

    ; --- Convert result to string ---
    cmp al, 9
    jg two_digits
    add al, '0'
    mov [res], al
    mov byte [res+1], 0
    jmp print_result

two_digits:
    mov bl, 10
    xor ah, ah         ; clear AH before div
    div bl             ; AL / 10 -> quotient in AL, remainder in AH
    add al, '0'        ; tens
    mov [res], al
    add ah, '0'        ; ones
    mov [res+1], ah
    mov byte [res+2], 0

print_result:
    ; --- Print result message ---
    mov eax, 4
    mov ebx, 1
    mov ecx, result_msg
    mov edx, result_msg_len
    int 0x80

    ; --- Print result ---
    mov eax, 4
    mov ebx, 1
    mov ecx, res
    mov edx, 2          ; max 2 digits
    cmp byte [res+1], 0
    je one_digit
    mov edx, 2
    jmp print_num
one_digit:
    mov edx, 1
print_num:
    int 0x80

    ; --- Print newline ---
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    ; --- Exit ---
    mov eax, 1
    xor ebx, ebx
    int 0x80
