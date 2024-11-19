# Nombre del Proyecto : 50 problemas
# Archivo            : problema36
# Autor              : Moises Acosta Martinez
# Horario            : 15:00-16:00
# -----------------------------------------------------------------------------

# Ejemplo Python:
# -----------------------------------------------------------------------------

// Inicializamos los arreglos y datos iniciales
// arreglo1 = [32145435, 5345, 12345, 6789, 10234]  # Primer arreglo con 5 elementos
// arreglo2 = [10, 20, 5, 15, 25]                   # Segundo arreglo con 5 elementos
// tamano = 5                                       # Tamaño de los arreglos
// msg_resultado = "El segundo elemento más grande es: {}"

// Definimos una función para encontrar el segundo mayor elemento en un arreglo
// def segundo_mayor(arreglo):
//     mayor = segundo_mayor = float('-inf')  # Inicializamos con -infinito
//     for num in arreglo:
//         if num > mayor:
//             segundo_mayor = mayor
//             mayor = num
//         elif segundo_mayor < num < mayor:
//             segundo_mayor = num
//     return segundo_mayor

// Llamamos a la función para encontrar el segundo mayor en el primer arreglo
// segundo_mayor_arreglo1 = segundo_mayor(arreglo1)

// Llamamos a la función para encontrar el segundo mayor en el segundo arreglo
// segundo_mayor_arreglo2 = segundo_mayor(arreglo2)

// Mostramos los resultados con el mensaje formateado
// print(msg_resultado.format(segundo_mayor_arreglo1))
// print(msg_resultado.format(segundo_mayor_arreglo2))


# Código
# -----------------------------------------------------------------------------
.data
arreglo1: .word 32145435, 5345, 12345, 6789, 10234  // Primer arreglo con 5 elementos
arreglo2: .word 10, 20, 5, 15, 25                   // Segundo arreglo con 5 elementos
tamano: .word 5                                     // Tamaño de los arreglos
msg_resultado: .string "El segundo elemento más grande es: %d\n"

.text
.global main
.align 2

main:
    // Prologo de la función main
    stp     x29, x30, [sp, #-16]!   // Guardar el frame pointer y el link register
    mov     x29, sp

    // Encontrar el segundo elemento más grande en el primer arreglo
    adrp    x2, arreglo1            // Dirección base del primer arreglo
    add     x2, x2, :lo12:arreglo1
    mov     w1, #5                  // Tamaño del arreglo
    mov     w3, #0                  // Mayor actual
    mov     w4, #0                  // Segundo mayor

loop_arreglo1:
    cbz     w1, fin_arreglo1        // Si el tamaño es 0, terminar el bucle

    ldr     w5, [x2], #4            // Cargar el elemento actual y avanzar
    sub     w1, w1, #1              // Decrementar el tamaño

    cmp     w5, w3                  // Comparar con el mayor actual
    b.le    no_actualizar1          // Si no es mayor, saltar

    mov     w4, w3                  // Actualizar el segundo mayor
    mov     w3, w5                  // Actualizar el mayor

    b       loop_arreglo1           // Continuar al siguiente elemento

no_actualizar1:
    cmp     w5, w4                  // Comparar con el segundo mayor
    b.le    loop_arreglo1           // Si no es mayor, continuar

    mov     w4, w5                  // Actualizar el segundo mayor
    b       loop_arreglo1

fin_arreglo1:
    mov     w6, w4                  // Guardar el segundo mayor del primer arreglo

    // Encontrar el segundo elemento más grande en el segundo arreglo
    adrp    x2, arreglo2            // Dirección base del segundo arreglo
    add     x2, x2, :lo12:arreglo2
    mov     w1, #5                  // Tamaño del arreglo
    mov     w3, #0                  // Mayor actual
    mov     w4, #0                  // Segundo mayor

loop_arreglo2:
    cbz     w1, fin_arreglo2        // Si el tamaño es 0, terminar el bucle

    ldr     w5, [x2], #4            // Cargar el elemento actual y avanzar
    sub     w1, w1, #1              // Decrementar el tamaño

    cmp     w5, w3                  // Comparar con el mayor actual
    b.le    no_actualizar2          // Si no es mayor, saltar

    mov     w4, w3                  // Actualizar el segundo mayor
    mov     w3, w5                  // Actualizar el mayor

    b       loop_arreglo2           // Continuar al siguiente elemento

no_actualizar2:
    cmp     w5, w4                  // Comparar con el segundo mayor
    b.le    loop_arreglo2           // Si no es mayor, continuar

    mov     w4, w5                  // Actualizar el segundo mayor
    b       loop_arreglo2

fin_arreglo2:
    mov     w7, w4                  // Guardar el segundo mayor del segundo arreglo

    // Imprimir el segundo mayor del primer arreglo
    adrp    x0, msg_resultado       // Cargar el mensaje para printf
    add     x0, x0, :lo12:msg_resultado
    mov     w1, w6                  // Pasar el segundo mayor del primer arreglo como argumento
    bl      printf                  // Llamar a printf para imprimir el segundo mayor del primer arreglo

    // Imprimir el segundo mayor del segundo arreglo
    adrp    x0, msg_resultado       // Cargar el mensaje para printf
    add     x0, x0, :lo12:msg_resultado
    mov     w1, w7                  // Pasar el segundo mayor del segundo arreglo como argumento
    bl      printf                  // Llamar a printf para imprimir el segundo mayor del segundo arreglo

    // Epílogo de la función main
    ldp     x29, x30, [sp], #16     // Restaurar el frame pointer y el link register
    mov     x0, #0                  // Código de salida 0
    ret
