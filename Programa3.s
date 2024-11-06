# -----------------------------------------------------------------------------
# Nombre del Proyecto : 50 problemas
# Archivo            : problema3
# Autor              : Moises Acosta Martinez
# Horario            : 15:00-16:00
# -----------------------------------------------------------------------------

# Ejemplo Python:
# -----------------------------------------------------------------------------
// prompt1 = "Introduce el primer número: "
// prompt2 = "Introduce el segundo número: "
// result_msg = "La resta es: {}"

// Solicitar el primer número
// num1 = int(input(prompt1))

// Solicitar el segundo número
// num2 = int(input(prompt2))

// Realizar la resta
// result = num1 - num2

// Mostrar el resultado
// print(result_msg.format(result))


#Codigo
#------------------------------------------------------------------------------
.section .data
prompt1: .asciz "Introduce el primer número: "
prompt2: .asciz "Introduce el segundo número: "
result_msg: .asciz "La resta es: %ld\n"
scanf_format: .asciz "%ld" // Formato para leer long int
num1: .quad 0
num2: .quad 0
result: .quad 0
.section .text
.global main
main:
// Pedir el primer número
ldr x0, =prompt1
bl printf
// Leer el primer número
ldr x0, =scanf_format // Cargar formato de scanf
ldr x1, =num1 // Cargar dirección de num1
bl scanf
// Pedir el segundo número
ldr x0, =prompt2
bl printf
// Leer el segundo número
ldr x0, =scanf_format // Cargar formato de scanf
ldr x1, =num2 // Cargar dirección de num2
bl scanf
// Restar los números
ldr x1, =num1
ldr x1, [x1] // Cargar el primer número
ldr x2, =num2
ldr x2, [x2] // Cargar el segundo número
sub x3, x1, x2 // Restar los números
ldr x0, =result
str x3, [x0] // Almacenar el resultado
// Mostrar el resultado
ldr x0, =result_msg
ldr x1, =result
ldr x1, [x1] // Cargar el resultado
bl printf
// Salir del programa
mov x0, #0
mov x8, #93
svc 0
