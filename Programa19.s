# Nombre del Proyecto : 50 problemas
# Archivo            : problema19
# Autor              : Moises Acosta Martinez
# Horario            : 15:00-16:00
# -----------------------------------------------------------------------------

# Ejemplo Python:
# -----------------------------------------------------------------------------
// Mensajes y variables de matriz en Python
//prompt_matrizA = "Ingrese los elementos de la matriz A (3x3):\n"
//prompt_matrizB = "Ingrese los elementos de la matriz B (3x3):\n"
//prompt_elemento = "Elemento [{i}][{j}]: "
//resultado_text = "Resultado de la suma:\n"

// Espacio de almacenamiento para matrices y resultados
//buffer = ""               // Buffer temporal para entradas del usuario
//matrizA = [[0] * 3 for _ in range(3)]
//matrizB = [[0] * 3 for _ in range(3)]
//resultado = [[0] * 3 for _ in range(3)]

// Leer matriz A
//print(prompt_matrizA)
//for i in range(3):        // Iteración sobre filas
//    for j in range(3):    // Iteración sobre columnas
//        print(prompt_elemento.format(i, j))    // Mostrar mensaje para cada elemento
//        elemento = int(input())                // Leer el elemento como entero
//        matrizA[i][j] = elemento               // Guardar en la matriz A

// Leer matriz B (misma estructura que matriz A)
//print(prompt_matrizB)
//for i in range(3):        
//    for j in range(3):
//        print(prompt_elemento.format(i, j))
//        elemento = int(input())
//        matrizB[i][j] = elemento

// Sumar las matrices y almacenar el resultado en "resultado"
//for i in range(3):
//    for j in range(3):
//        resultado[i][j] = matrizA[i][j] + matrizB[i][j]   // Sumar elementos correspondientes

// Mostrar el resultado de la suma de matrices
//print(resultado_text)
//for i in range(3):
//    for j in range(3):
//        print(resultado[i][j], end=" " if j < 2 else "\n")    // Imprimir cada fila en una línea



# Código
# -----------------------------------------------------------------------------

  .section .data
prompt_matrizA: .asciz "Ingrese los elementos de la matriz A (3x3):\n"
prompt_matrizB: .asciz "Ingrese los elementos de la matriz B (3x3):\n"
prompt_elemento: .asciz "Elemento [%d][%d]: "
resultado_text: .asciz "Resultado de la suma:\n"
buffer: .space 16                 // Espacio para almacenar la entrada del usuario y el resultado temporal
matrizA: .space 36                // 3x3 = 9 elementos de 4 bytes para la primera matriz
matrizB: .space 36                // 3x3 = 9 elementos de 4 bytes para la segunda matriz
resultado: .space 36              // 3x3 = 9 elementos de 4 bytes para la matriz de resultado

        .section .text
        .global _start

_start:
        // Mostrar mensaje para ingresar matriz A
        ldr x0, =prompt_matrizA
        bl print_str

        // Leer los elementos de matriz A
        mov w3, #0                 // Índice de fila i
matrizA_fila_loop:
        mov w4, #0                 // Índice de columna j
matrizA_columna_loop:
        // Mostrar mensaje para cada elemento
        ldr x0, =prompt_elemento
        mov x1, x3                 // Fila actual i
        mov x2, x4                 // Columna actual j
        bl print_elemento          // Llama a la subrutina para mostrar el mensaje de entrada

        // Leer el número ingresado
        mov x0, #0                 // File descriptor 0 (entrada estándar)
        ldr x1, =buffer            // Guardar en buffer
        mov x2, #15                // Tamaño máximo de entrada
        mov x8, #63                // Syscall de read
        svc 0

        // Convertir la entrada a entero y almacenar en matrizA
        ldr x1, =buffer
        bl str_to_int
        ldr x2, =matrizA
        str w0, [x2, x3, LSL #2]   // matrizA[i][j] = valor convertido

        // Incrementar índice de columna y comprobar
        add w4, w4, #1
        cmp w4, #3
        blt matrizA_columna_loop   // Si j < 3, repetir columna

        // Incrementar índice de fila y comprobar
        add w3, w3, #1
        cmp w3, #3
        blt matrizA_fila_loop      // Si i < 3, repetir fila

        // Mostrar mensaje para ingresar matriz B
        ldr x0, =prompt_matrizB
        bl print_str

        // Leer los elementos de matriz B (mismo proceso que matrizA)
        mov w3, #0
matrizB_fila_loop:
        mov w4, #0
matrizB_columna_loop:
        ldr x0, =prompt_elemento
        mov x1, x3
        mov x2, x4
        bl print_elemento

        mov x0, #0
        ldr x1, =buffer
        mov x2, #15
        mov x8, #63
        svc 0

        ldr x1, =buffer
        bl str_to_int
        ldr x2, =matrizB
        str w0, [x2, x3, LSL #2]

        add w4, w4, #1
        cmp w4, #3
        blt matrizB_columna_loop

        add w3, w3, #1
        cmp w3, #3
        blt matrizB_fila_loop

        // Sumar las matrices y almacenar el resultado en "resultado"
        mov w3, #0
suma_fila_loop:
        mov w4, #0
suma_columna_loop:
        ldr x5, =matrizA
        ldr w6, [x5, x3, LSL #2]   // w6 = matrizA[i][j]
        ldr x5, =matrizB
        ldr w7, [x5, x3, LSL #2]   // w7 = matrizB[i][j]
        add w8, w6, w7             // w8 = matrizA[i][j] + matrizB[i][j]
        
        ldr x5, =resultado
        str w8, [x5, x3, LSL #2]   // resultado[i][j] = matrizA[i][j] + matrizB[i][j]

        add w4, w4, #1
        cmp w4, #3
        blt suma_columna_loop

        add w3, w3, #1
        cmp w3, #3
        blt suma_fila_loop

        // Mostrar resultado de la suma de matrices
        ldr x0, =resultado_text
        bl print_str
        mov w3, #0
print_fila_loop:
        mov w4, #0
print_columna_loop:
        ldr x5, =resultado
        ldr w0, [x5, x3, LSL #2]   // w0 = resultado[i][j]
        bl int_to_str              // Convertir a cadena
        ldr x0, =buffer
        bl print_str

        add w4, w4, #1
        cmp w4, #3
        blt print_columna_loop

        add w3, w3, #1
        cmp w3, #3
        blt print_fila_loop

        // Terminar programa
        mov x8, #93
        svc 0


str_to_int:
        mov x0, #0
        mov x2, #10
convert_loop:
        ldrb w3, [x1], #1
        cmp w3, #10
        beq end_convert
        sub w3, w3, #'0'
        mul x0, x0, x2
        add x0, x0, x3
        b convert_loop
end_convert:
        ret


int_to_str:
        mov x3, #10
        mov x4, x2
conv_loop:
        udiv x5, x1, x3
        msub x6, x5, x3, x1
        add x6, x6, #'0'
        strb w6, [x4], #1
        mov x1, x5
        cbnz x1, conv_loop
        ret


print_str:
        mov x8, #64
        mov x1, x0
        mov x2, #25
        mov x0, #1
        svc 0
        ret


print_elemento:
        // Reutiliza print_str con formato adaptado para matriz
        ret
