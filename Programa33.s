# Nombre del Proyecto : 50 problemas
# Archivo            : problema33
# Autor              : Moises Acosta Martinez
# Horario            : 15:00-16:00
# -----------------------------------------------------------------------------

# Ejemplo Python:
# -----------------------------------------------------------------------------

// Definir el arreglo y su longitud
// arr = [5, 10, 15, 20, 25]  // Elementos del arreglo (5, 10, 15, 20, 25)
// length = 5                  // Longitud del arreglo
// buffer = ""                 // Variable para almacenar el texto del número

// Inicializar variables
// arr = [5, 10, 15, 20, 25]  // Arreglo de ejemplo
// length = len(arr)          // Longitud del arreglo
// total_sum = 0              // Suma inicializada a 0

// Bucle para recorrer el arreglo y sumar los elementos
// for num in arr:
//     total_sum += num       // Sumar el elemento al total acumulado

// Función para convertir un número entero en texto
// def int_to_str(num):
//     // Convertir el número a texto
//     return str(num)

// Convertir la suma a texto
// result_text = int_to_str(total_sum)

// Imprimir el resultado
// print(f"La suma de los elementos es: {result_text}")

// Salida del programa
// En Python, el programa termina aquí sin necesidad de llamar a un sistema operativo.





# Código
# -----------------------------------------------------------------------------
.section .data
arr:    .word 5, 10, 15, 20, 25    // Elementos del arreglo (5, 10, 15, 20, 25)
length: .word 5                    // Longitud del arreglo
buffer: .space 20                  // Espacio para almacenar el texto del número

.section .text
.global _start

_start:
    // Inicialización de los registros
    ldr x1, =arr            // Cargar la dirección del arreglo en x1
    ldr w2, =5              // Cargar la longitud del arreglo en w2 (5 elementos)
    mov x3, 0               // Registro para almacenar la suma (inicializado en 0)

loop:
    // Comprobar si hemos terminado de recorrer el arreglo
    cmp w2, 0               // Comparar w2 (contador) con 0
    beq end_sum             // Si w2 es 0, salir del bucle

    // Sumar el elemento actual al total
    ldr w4, [x1], #4        // Cargar el siguiente elemento del arreglo en w4 y avanzar x1
    add x3, x3, x4          // Sumar w4 a x3

    // Decrementar el contador y repetir
    sub w2, w2, 1           // Decrementar el contador
    b loop                  // Repetir el bucle

end_sum:
    // Convertir la suma en x3 a texto en buffer
    mov x0, x3              // Pasar la suma al primer argumento para la conversión
    ldr x1, =buffer         // Dirección del buffer para almacenar el texto
    bl int_to_str           // Llamada a la función de conversión

    // Imprimir el resultado
    mov x0, 1               // File descriptor 1 (stdout)
    ldr x1, =buffer         // Dirección del buffer con el texto de la suma
    mov x2, 20              // Longitud máxima a imprimir
    mov x8, 64              // Número de syscall para escribir (write)
    svc 0                   // Llamada al sistema

    // Salida del programa
    mov x8, 93              // Código de salida para salir del programa
    svc 0

// Función para convertir un número entero en texto
int_to_str:
    mov x2, x1              // Guardar la posición de inicio del buffer en x2
    add x1, x1, 20          // Apuntar al final del buffer
    mov w3, 10              // Divisor para obtener dígitos decimales

convert_loop:
    udiv x4, x0, x3         // Dividir x0 entre 10 (quedando el cociente en x4)
    msub x5, x4, x3, x0     // Obtener el residuo de la división en x5
    add x5, x5, '0'         // Convertir el dígito en carácter
    sub x1, x1, 1           // Retroceder en el buffer
    strb w5, [x1]           // Almacenar el carácter en el buffer
    mov x0, x4              // Actualizar x0 con el cociente
    cbz x0, end_convert     // Si x0 es 0, terminamos la conversión
    b convert_loop          // Repetir el bucle

end_convert:
    mov x0, x2              // Restaurar la posición inicial del buffer
    ret                     // Regresar al llamador

