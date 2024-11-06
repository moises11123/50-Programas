# -----------------------------------------------------------------------------
# Nombre del Proyecto : 50 problemas
# Archivo            : problema7
# Autor              : Moises Acosta Martinez
# Horario            : 15:00-16:00
# -----------------------------------------------------------------------------

# Ejemplo Python:
# -----------------------------------------------------------------------------

//prompt = "Introduce un número para calcular su factorial: "
//result_msg = "El factorial de {} es {}."

//print(prompt)
//number = int(input())  # Leer el número ingresado por el usuario

//factorial = 1  // Inicializar el factorial en 1

//counter = 1  // Inicializar contador en 1

//while counter <= number:  // Bucle para calcular el factorial
//    factorial *= counter  // factorial *= contador
//    counter += 1  // Incrementar el contador

//print(result_msg.format(number, factorial))  // Imprimir el resultado
# -----------------------------------------------------------------------------

.section .data
prompt: .asciz "Introduce un número para calcular su factorial: "
result_msg: .asciz "El factorial de %ld es %ld.\n"
scanf_format: .asciz "%ld"
number: .quad 0
factorial: .quad 1
.section .text
.global main
main:
// Pedir al usuario un número
ldr x0, =prompt
bl printf
// Leer el número
ldr x0, =scanf_format
ldr x1, =number
bl scanf
// Cargar el número en x1
ldr x1, =number
ldr x1, [x1]
// Inicializar factorial en 1
mov x2, #1
// Calcular el factorial
mov x3, #1 // Inicializar contador en 1
factorial_loop:
cmp x3, x1 // Comparar contador con el número
bgt end_factorial // Si contador > número, salir del bucle
mul x2, x2, x3 // factorial *= contador
add x3, x3, #1 // Incrementar contador
b factorial_loop // Volver al inicio del bucle
end_factorial:
// Guardar el resultado del factorial
ldr x4, =factorial
str x2, [x4]
// Imprimir el resultado
ldr x0, =result_msg
mov x1, x1 // cargar el número
ldr x2, =factorial
ldr x2, [x2] // cargar el resultado
bl printf
// Salir del programa
mov x0, #0
mov x8, #93
svc 0

# Código
