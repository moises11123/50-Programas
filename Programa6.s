# -----------------------------------------------------------------------------
# Nombre del Proyecto : 50 problemas
# Archivo            : problema6
# Autor              : Moises Acosta Martinez
# Horario            : 15:00-16:00
# -----------------------------------------------------------------------------

# Ejemplo Python:
# -----------------------------------------------------------------------------
//prompt = "Introduce un número N para calcular la suma de los primeros N números naturales: "
//result_msg = "La suma de los primeros {} números naturales es {}."

//print(prompt)
//number = int(input())

//sum_result = 0

//counter = 1

//while counter <= number:
   // sum_result += counter
  //  counter += 1

//sum_result

//print(result_msg.format(number, sum_result))
# Código
# -----------------------------------------------------------------------------
.section .data
prompt: .asciz "Introduce un número N para calcular la suma de los primeros N números naturales: "
result_msg: .asciz "La suma de los primeros %ld números naturales es %ld.\n"
scanf_format: .asciz "%ld"
number: .quad 0
sum: .quad 0

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

    // Cargar el número en 
    
    ldr x1, =number
    ldr x1, [x1]

    // Inicializar la suma en 0
    mov x2, #0
     // Inicializar el contador en 1
    mov x3, #1

sum_loop:
    // Comparar contador con N
    cmp x3, x1
    // Si el contador es mayor que N, salir del bucle
    bgt end_sum
    
    // Sumar el contador a la suma
    add x2, x2, x3
    
    // Incrementar el contador
    add x3, x3, #1
    
    // Volver al inicio del bucle
    b sum_loop

end_sum:
    // Guardar el resultado de la suma
    ldr x4, =sum
    str x2, [x4]

    // Imprimir el resultado
    ldr x0, =result_msg
    mov x1, x1  // cargar N
    ldr x2, =sum
    ldr x2, [x2]  // cargar el resultado
    bl printf

    // Salir del programa
    mov x0, #0
    mov x8, #93
    svc 0
