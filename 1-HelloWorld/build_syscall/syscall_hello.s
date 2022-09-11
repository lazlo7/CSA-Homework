    .global main
    .text
main:
    mov $1, %rax            # 1 - системный вызов write
    mov $1, %rdi            # 1 - standard output
    lea .msg(%rip), %rsi    # Адрес msg
    mov $13, %rdx           # Размер в байтах
    syscall

    mov $0, %eax            # return 0
    ret

.section .rodata
.msg:
    .string  "Hello, World\n"
