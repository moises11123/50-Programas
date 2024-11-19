# -----------------------------------------------------------------------------
# Nombre del Proyecto : 50 problemas
# Archivo            : problema30
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
//
//    // Loop principal del algoritmo de Euclides
//    //while b != 0:
//        // Calcular el residuo de a dividido por b
//        //residuo = a % b
//
//        // Actualizar los valores de a y b
//        //a = b
//        //b = residuo
//
//    // Retornar el resultado (MCD)
//    //return a

// Función principal
//def main():
//    """
//    Función principal que calcula el MCD de dos números de ejemplo e imprime el resultado.
//    """
//
//    // Valores de entrada
//    //num1 = 56  // Primer número
//    //num2 = 98  // Segundo número
//
//    // Llamar a la función calcular_mcd
//    //mcd = calcular_mcd(num1, num2)
//
//    // Imprimir el resultado
//    //print(f"El MCD es: {mcd}")

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
    stp     x29, x30, [sp, #-16]!   // Guardar el frame pointer (fp) y el link register (lr)
    mov     x29, sp                 // Establecer nuevo frame pointer

    // Valores de entrada: colocar en w0 y w1
    mov     w0, #56                 // Ejemplo: primer número
    mov     w1, #98                 // Ejemplo: segundo número

    // Llamar a la función que calcula el MCD
    bl      calcular_mcd

    // Imprimir el resultado (w0 contiene el MCD)
    // Asumiendo que tienes una función de impresión configurada con printf
    adrp    x0, msg_mcd             // Cargar mensaje de formato para printf
    add     x0, x0, :lo12:msg_mcd
    mov     w1, w0                  // Pasar el MCD a w1 como argumento para printf
    bl      printf

    // Epílogo de la función main
    ldp     x29, x30, [sp], #16     // Restaurar el frame pointer y el link register
    mov     x0, #0                  // Código de salida 0
    ret

// Función calcular_mcd
// Entrada: w0 = primer número, w1 = segundo número
// Salida: w0 = MCD de los dos números
calcular_mcd:
    stp     x29, x30, [sp, #-16]!   // Guardar el frame pointer (fp) y el link register (lr)
    mov     x29, sp                 // Establecer nuevo frame pointer

loop_mcd:
    cmp     w1, #0                  // Comparar w1 con 0
    beq     fin                     // Si w1 es 0, fin (MCD está en w0)
    udiv    w2, w0, w1              // w2 = w0 / w1 (división entera)
    msub    w2, w2, w1, w0          // w2 = w0 - (w2 * w1) -> residuo
    mov     w0, w1                  // w0 = w1 (intercambiar)
    mov     w1, w2                  // w1 = residuo
    b       loop_mcd                // Repetir hasta que w1 sea 0

fin:
    ldp     x29, x30, [sp], #16     // Restaurar el frame pointer y el link register
    ret                             // Retornar el MCD en w0

// Datos
.data
msg_mcd: .string "El MCD es: %d\n"
