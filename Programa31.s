# -----------------------------------------------------------------------------
# Nombre del Proyecto : 50 problemas
# Archivo            : problema31
# Autor              : Moises Acosta Martinez
# Horario            : 15:00-16:00
# -----------------------------------------------------------------------------


# Ejemplo Python:
# -----------------------------------------------------------------------------


// Función para calcular el MCD (Máximo Común Divisor)
//def calcular_mcd(a, b):
//    """
//    Calcula el MCD de dos números usando el algoritmo de Euclides.
//    
//    Parámetros:
//    - a (int): Primer número.
//    - b (int): Segundo número.
//    
//    Retorna:
//    - int: MCD de a y b.
//    """
//    // Mientras b no sea 0
//    //while b != 0:
//        // Calcular el residuo
//        //residuo = a % b
//
//        // Actualizar a con el valor de b
//        //a = b
//
//        // Actualizar b con el residuo
//        //b = residuo
//
//    // Retornar el MCD
//    //return a

// Función principal
//def main():
//    """
//    Función principal que calcula el MCM de dos números y lo imprime.
//    """
//
//    // Valores de entrada
//    //num1 = 56  // Primer número
//    //num2 = 98  // Segundo número
//
//    // Guardar los valores originales
//    //original_num1 = num1
//    //original_num2 = num2
//
//    // Calcular el MCD
//    //mcd = calcular_mcd(num1, num2)
//
//    // Calcular el MCM usando la fórmula: MCM = (a * b) / MCD
//    //mcm = (original_num1 * original_num2) // mcd
//
//    // Imprimir el resultado
//    //print(f"El MCM es: {mcm}")

// Punto de entrada del programa
//if __name__ == "__main__":
//    main()




# Código
# -----------------------------------------------------------------------------
.text
.global main
.align 2

main:
    // Prologo de la función main
    stp     x29, x30, [sp, #-16]!
    mov     x29, sp

    // Cargar los valores de entrada
    mov     w0, #56                 // Ejemplo: primer número
    mov     w1, #98                 // Ejemplo: segundo número

    // Guardar los valores originales para usarlos después
    mov     w3, w0                  // Guardar primer número en w3
    mov     w4, w1                  // Guardar segundo número en w4

    // Llamar a la función para calcular el MCD
    bl      calcular_mcd            // w0 contendrá el MCD al retornar

    // Calcular MCM usando la fórmula: MCM = (a * b) / MCD
    mul     w5, w3, w4              // w5 = a * b
    udiv    w0, w5, w0              // w0 = (a * b) / MCD, que es el MCM

    // Imprimir el resultado (MCM en w0)
    adrp    x0, msg_mcm             // Cargar el mensaje para printf
    add     x0, x0, :lo12:msg_mcm
    mov     w1, w0                  // Pasar el MCM a w1 como argumento para printf
    bl      printf

    // Epílogo de la función main
    ldp     x29, x30, [sp], #16
    mov     x0, #0                  // Código de salida 0
    ret

// Función calcular_mcd
// Entrada: w0 = primer número, w1 = segundo número
// Salida: w0 = MCD de los dos números
calcular_mcd:
    stp     x29, x30, [sp, #-16]!
    mov     x29, sp

loop_mcd:
    cmp     w1, #0                  // Comparar w1 con 0
    beq     fin_mcd                 // Si w1 es 0, fin (MCD está en w0)
    udiv    w2, w0, w1              // w2 = w0 / w1
    msub    w2, w2, w1, w0          // w2 = w0 - (w2 * w1) -> residuo
    mov     w0, w1                  // w0 = w1 (intercambiar)
    mov     w1, w2                  // w1 = residuo
    b       loop_mcd                // Repetir mientras w1 no sea 0

fin_mcd:
    ldp     x29, x30, [sp], #16
    ret                             // Retornar el MCD en w0

// Datos
.data
msg_mcm: .string "El MCM es: %d\n"
