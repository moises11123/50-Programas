# -----------------------------------------------------------------------------
# Nombre del Proyecto : 50 problemas
# Archivo            : problema14
# Autor              : Moises Acosta Martinez
# Horario            : 15:00-16:00
# -----------------------------------------------------------------------------

# Ejemplo Python:
# -----------------------------------------------------------------------------

// Definición de datos
// arreglo = [1, 3, 5, 8, 13, 21, 34, 55, 89]               // Arreglo predefinido
// tam_arreglo = len(arreglo)                               // Tamaño del arreglo
// mensaje_encontrado = "Número 8 encontrado en la posición: "
// mensaje_no_encontrado = "Número 8 no encontrado\n"
// buffer = ""                                              // Buffer para mostrar la posición

// Valor a buscar
// valor_a_buscar = 8
// posicion_encontrada = -1  // Inicializamos la posición como no encontrada

// Bucle para buscar el valor en el arreglo
// for i in range(tam_arreglo):
//     if arreglo[i] == valor_a_buscar:
//         posicion_encontrada = i
//         break

// Mostrar el mensaje de resultado según el valor de posicion_encontrada
// if posicion_encontrada != -1:
//     print(mensaje_encontrado, posicion_encontrada)  // Imprime el mensaje de éxito y la posición
// else:
//     print(mensaje_no_encontrado)  // Imprime el mensaje de fracaso



# Código
# -----------------------------------------------------------------------------


    .section .data
arreglo:         .quad 1, 3, 5, 8, 13, 21, 34, 55, 89  // Arreglo predefinido
tam_arreglo:     .quad 9                              // Tamaño del arreglo
mensaje_encontrado: .asciz "Número 8 encontrado en la posición: "
mensaje_no_encontrado: .asciz "Número 8 no encontrado\n"
buffer:          .space 16                            // Espacio para mostrar la posición

        .section .text
        .global _start

_start:
        // Inicializar registros y variables
        ldr x1, =arreglo                             // Dirección del inicio del arreglo
        ldr x2, =tam_arreglo                         // Tamaño del arreglo
        ldr x2, [x2]                                 // Cargar el tamaño del arreglo
        mov x3, #8                                   // Valor a buscar
        mov x4, #0                                   // Índice de búsqueda

buscar_loop:
        cmp x4, x2                                   // Comparar índice con tamaño
        b.ge no_encontrado                           // Si índice >= tamaño, no se encontró

        ldr x5, [x1, x4, LSL #3]                     // Cargar elemento del arreglo (64 bits)
        cmp x5, x3                                   // Comparar con el valor buscado
        b.eq encontrado                             // Si es igual, ir a "encontrado"

        add x4, x4, #1                               // Incrementar el índice
        b buscar_loop                                // Repetir el bucle

encontrado:
        ldr x0, =mensaje_encontrado                  // Mensaje de éxito
        bl print_str
        mov x0, x4                                   // Pasar índice encontrado a x0
        bl int_to_str                                // Convertir índice a texto
        ldr x0, =buffer                              // Dirección del buffer con el número convertido
        bl print_str                                 // Imprimir índice
        b fin_programa

no_encontrado:
        ldr x0, =mensaje_no_encontrado               // Mensaje de fracaso
        bl print_str

fin_programa:
        mov x8, #93                                  // Syscall para "exit"
        svc 0

// =========================================
// Subrutina: int_to_str (Convierte entero en x1 a cadena en x2)
// =========================================
int_to_str:
        mov x3, #10                                  // Divisor para conversión a decimal
        mov x4, x2                                   // Dirección de escritura en buffer

conv_loop:
        udiv x5, x1, x3                              // División entera x1 / 10
        msub x6, x5, x3, x1                          // Resto: x6 = x1 - (x5 * 10)
        add x6, x6, #'0'                             // Convertir dígito a carácter ASCII
        strb w6, [x4], #1                            // Guardar el dígito en el buffer
        mov x1, x5                                   // Actualizar x1 con el cociente
        cbnz x1, conv_loop                           // Repetir si x1 no es cero
        ret

// =========================================
// Subrutina: print_str (Imprime una cadena terminada en NULL en x0)
// =========================================
print_str:
        mov x8, #64                                  // Syscall para write
        mov x1, x0                                   // Dirección de la cadena a imprimir
        mov x2, #25                                  // Longitud máxima del mensaje
        mov x0, #1                                   // File descriptor 1 (salida estándar)
        svc 0
        ret
