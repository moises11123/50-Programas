# -----------------------------------------------------------------------------
# Nombre del Proyecto : 50 problemas
# Archivo            : problema8
# Autor              : Moises Acosta Martinez
# Horario            : 15:00-16:00
# -----------------------------------------------------------------------------

# Ejemplo Python:
# -----------------------------------------------------------------------------

//prompt = "Introduce el número de términos de la serie de Fibonacci: "
//result_msg = "Fibonacci[{}] = {}"

//n_terms = 0
//fib1 = 0
//fib2 = 1

//print(prompt)
//n_terms = int(input())  // Leer el número de términos

//if n_terms <= 0:
//    exit()  // Si n <= 0, salir

//fib1 = 0  // Primer término (0)
//fib2 = 1  // Segundo término (1)

//print(result_msg.format(0, fib1))  // Imprimir el primer término

//if n_terms == 1:
//    exit()  // Si solo se quiere imprimir el primer término, salir

//print(result_msg.format(1, fib2))  // Imprimir el segundo término

//fib_count = 2  // Contador de términos ya impresos

//while fib_count < n_terms:
//    fib_next = fib1 + fib2  // Calcular el siguiente término de Fibonacci

//    print(result_msg.format(fib_count, fib_next))  // Imprimir el término actual

//    fib1 = fib2  // Actualizar fib1
//    fib2 = fib_next  // Actualizar fib2

//    fib_count += 1  // Incrementar el contador


# Código
# -----------------------------------------------------------------------------
.section .data
prompt: .asciz "Introduce el número de términos de la serie de Fibonacci: "
result_msg: .asciz "Fibonacci[%ld] = %ld\n"
scanf_format: .asciz "%ld"
n_terms: .quad 0
fib1: .quad 0
fib2: .quad 1
.section .text
.global main
main:
// Pedir el número de términos
ldr x0, =prompt
bl printf
// Leer el número de términos
ldr x0, =scanf_format
ldr x1, =n_terms
bl scanf
// Cargar el número de términos en x1
ldr x1, =n_terms
ldr x1, [x1]
// Verificar si n es menor o igual a 0
cmp x1, #0
ble end_program // Si n <= 0, salir
// Inicializar los primeros dos términos de Fibonacci
ldr x4, =fib1
ldr x5, =fib2
mov x0, #0 // Primer término (0)
str x0, [x4] // fib1 = 0
mov x0, #1 // Segundo término (1)
str x0, [x5] // fib2 = 1
// Imprimir el primer término
ldr x0, =result_msg
mov x1, #0 // Índice 0
ldr x2, [x4] // Cargar fib1 (0)
bl printf
// Si solo se quiere imprimir el primer término, salir
cmp x1, #1
beq end_program
// Imprimir el segundo término
mov x1, #1 // Índice 1
ldr x0, =result_msg
ldr x2, [x5] // Cargar fib2 (1)
bl printf
// Calcular y mostrar el resto de los términos
mov x7, #2 // Contador de términos ya impresos
fibonacci_loop:
// Cargar los dos últimos términos
ldr x10, [x4] // fib1
ldr x11, [x5] // fib2
add x12, x10, x11 // x12 = fib1 + fib2
// Imprimir el término actual
ldr x0, =result_msg
mov x1, x7 // Índice actual
mov x2, x12 // Valor a imprimir
bl printf
// Actualizar los términos
str x11, [x4] // fib1 = fib2
str x12, [x5] // fib2 = nuevo término (x12)
// Incrementar el contador
add x7, x7, #1
cmp x7, x1
blt fibonacci_loop
end_program:
// Salir del programa
mov x0, #0
mov x8, #93
svc 0
