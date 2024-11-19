# Nombre del Proyecto : 50 problemas
# Archivo            : problema38
# Autor              : Moises Acosta Martinez
# Horario            : 15:00-16:00
# -----------------------------------------------------------------------------

# Ejemplo Python:
# -----------------------------------------------------------------------------


// Definir el arreglo que simula la cola y su tamaño
//cola = [32145435, 5345, 12345, 6789, 10234]  # Elementos en la cola
//tamano = len(cola)                           # Tamaño de la cola

// Definir el mensaje para mostrar el contenido de la cola
//msg_cola = "El contenido de la cola es: {}"

// Inicializar el acumulador y el índice
//acumulador = 0  # Acumulador para la suma
//indice = 0      # Índice para recorrer la cola

// Recorrer la cola y sumar sus elementos
//while indice < tamano:
//    elemento = cola[indice]  # Obtener el elemento actual de la cola
//    acumulador += elemento   # Sumar el elemento al acumulador
//    indice += 1              # Incrementar el índice

// Imprimir el resultado acumulado
//print(msg_cola.format(acumulador))



# Código
# ---------------------------------------------------------------------------

.data
cola: .word 32145435, 5345, 12345, 6789, 10234  // Arreglo que simula la cola con 5 elementos
tamano: .word 5                                 // Tamaño de la cola (definido directamente)

msg_cola: .string "El contenido de la cola es: %d\n"  

.text
.global main
.align 2

main:
    // Prologo de la función main
    stp     x29, x30, [sp, #-16]!
    mov     x29, sp

    // Inicializar el acumulador y el índice
    mov     w0, #0                    // Acumulador de la suma
    mov     w1, #5                    // Tamaño de la cola
    adrp    x2, cola                  // Dirección base del arreglo que simula la cola
    add     x2, x2, :lo12:cola

loop_cola:
    cbz     w1, fin_cola              // Si el tamaño es 0, terminar el bucle

    ldr     w3, [x2], #4              // Cargar el siguiente elemento de la cola y avanzar la dirección
    add     w0, w0, w3                // Sumar el elemento al acumulador
    sub     w1, w1, #1                // Decrementar el tamaño (contador de elementos)

    b       loop_cola                 // Repetir para el siguiente elemento

fin_cola:
    // Imprimir el resultado acumulado
    adrp    x0, msg_cola              // Cargar el mensaje para printf
    add     x0, x0, :lo12:msg_cola
    mov     w1, w0                    // Pasar el contenido acumulado de la cola a w1 para printf
    bl      printf

    // Epílogo de la función main
    ldp     x29, x30, [sp], #16       // Restaurar el frame pointer y el link register
    mov     x0, #0                    // Código de salida 0
    ret
