# Nombre del Proyecto : 50 problemas
# Archivo            : problema37
# Autor              : Moises Acosta Martinez
# Horario            : 15:00-16:00
# -----------------------------------------------------------------------------

# Ejemplo Python:
# -----------------------------------------------------------------------------

// pila = [32145435, 5345, 12345, 6789, 10234]  # Simula el arreglo de la pila con 5 elementos
// tamano = len(pila)                           # Tamaño del arreglo (calculado directamente)

// msg_pila = "El contenido de la pila es: {}"  # Mensaje para mostrar el contenido de la pila

// acumulador = 0  # Acumulador para la suma
// indice = tamano  # Contador de elementos en la pila

// while indice > 0:
//     elemento = pila[tamano - indice]  # Tomar el elemento actual de la pila 
//     acumulador += elemento            # Sumar el elemento al acumulador
//     indice -= 1                       # Decrementar el índice

// print(msg_pila.format(acumulador))    # Imprimir el resultado acumulado

# Código
# -----------------------------------------------------------------------------

.data
pila: .word 32145435, 5345, 12345, 6789, 10234  // Arreglo que simula la pila con 5 elementos
tamano: .word 5                                 // Tamaño del arreglo (definido directamente)

msg_pila: .string "El contenido de la pila es: %d\n"  

.text
.global main
.align 2

main:
    // Prologo de la función main
    stp     x29, x30, [sp, #-16]!
    mov     x29, sp

    // Inicializar el acumulador y el índice
    mov     w0, #0                    // Acumulador de la suma
    mov     w1, #5                    // Tamaño de la pila
    adrp    x2, pila                  // Dirección base del arreglo que simula la pila
    add     x2, x2, :lo12:pila

loop_pila:
    cbz     w1, fin_pila              // Si el tamaño es 0, terminar el bucle

    ldr     w3, [x2], #4              // Cargar un elemento de 4 bytes y avanzar la dirección
    add     w0, w0, w3                // Sumar el elemento al acumulador
    sub     w1, w1, #1                // Decrementar el tamaño (contador de elementos)

    b       loop_pila                 // Repetir para el siguiente elemento

fin_pila:
    // Imprimir el resultado acumulado
    adrp    x0, msg_pila              // Cargar el mensaje para printf
    add     x0, x0, :lo12:msg_pila
    mov     w1, w0                    // Pasar el contenido acumulado de la pila a w1 para printf
    bl      printf

    // Epílogo de la función main
    ldp     x29, x30, [sp], #16       // Restaurar el frame pointer y el link register
    mov     x0, #0                    // Código de salida 0
    ret
