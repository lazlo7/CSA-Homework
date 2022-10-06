    .intel_syntax noprefix
    .text
    .globl main
    .type main, @function
main:
    push rbp
    mov rbp, rsp

    mov rdi, 0                                                  # rdi - текущий аргумент факториала

main_loop:                                                      # главный цикл, где увеличивается аргумент и проверяется факториал
    inc rdi                                                     # инкремент rdi
    call factorial                                              # вызываем подпрограмму factorial
    cmp rax, 0                                                  # overflow произошел -> rax отрицателен
    jge main_loop                                               # продолжаем вычисления, если rax >= 0

    dec rdi                                                     # dec rdi, т. к. перед overflow'ом он был увеличен
    
    mov esi, edi                                                # выводимое значение rdi
    lea rdi, output_fmt[rip]                                    # формат для printf
    mov eax, 0                                                  # для printf больше нет аргументов и return 0
    call printf@plt                                             # вызываем printf

    pop rbp
    ret

factorial:                                                      # итеративная версия факториала
    push rbp
    mov rbp, rsp

    mov rax, 1                                                  # значение факториала
    mov rbx, 2                                                  # текущий аргумент

    cmp rbx, rdi                                                
    ja factorial_loop_end                                       # если переданный аргумент < 2, сразу выходим

factorial_loop:
    mul rbx                                                     # mul rbx <=> rax = rax * rbx
    inc rbx                                                     # увеличиваем текущий аргумент

    cmp rbx, rdi                                                
    jbe factorial_loop                                          # пока текущий аргумент <= переданного аргумента

factorial_loop_end:
    pop rbp
    ret

    .section .rodata
output_fmt:
    .string "Максимальный аргумент 64-битного факториала без переполнения: %d\n"
