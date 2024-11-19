# -----------------------------------------------------------------------------
# Nombre del Proyecto : 50 problemas
# Archivo            : problema32
# Autor              : Moises Acosta Martinez
# Horario            : 15:00-16:00
# -----------------------------------------------------------------------------

# Ejemplo Python:
# -----------------------------------------------------------------------------

// Función para calcular la potencia
//def calcular_potencia(x, n):
//    """
//    Calcula la potencia de un número elevado a un exponente usando multiplicación iterativa.
//    
//    Parámetros:
//    - x (int): Base del número.
//    - n (int): Exponente.
//    
//    Retorna:
//    - int: Resultado de x elevado a la potencia n.
//    """
//    resultado = 1  // Iniciar resultado en 1 (x^0 = 1)
//
//    // Mientras el exponente no sea 0
//    //while n > 0:
//        // Multiplicar resultado acumulado por la base
//        //resultado *= x
//
//        // Decrementar el exponente
//        //n -= 1
//
//    // Retornar el resultado
//    //return resultado

// Función principal
//def main():
//    """
//    Función principal que calcula x^n y muestra el resultado.
//    """
//
//    // Entradas de ejemplo
//    //x = 3  // Base
//    //n = 4  // Exponente
//
//    // Calcular la potencia
//    //resultado = calcular_potencia(x, n)
//
//    // Imprimir el resultado
//    //print(f"El resultado de {x}^{n} es: {resultado}")

// Ejecutar la función principal
//if __name__ == "__main__":
//    main()


# Código
# -----------------------------------------------------------------------------


.text
.global main
.align 2

main:
    // Prologo de la función main
    stp     x29, x30, [sp, #-16]!    // Guardar el frame pointer (fp) y el link register (lr)
    mov     x29, sp                  // Establecer nuevo frame pointer

    // Entradas de ejemplo
    mov     w0, #3                   // Base: x = 3
    mov     w1, #4                   // Exponente: n = 4

    // Llamar a la función para calcular la potencia
    bl      calcular_potencia        // Resultado en w0 al retornar

    // Imprimir el resultado (potencia en w0)
    adrp    x0, msg_potencia         // Cargar el mensaje para printf
    add     x0, x0, :lo12:msg_potencia
    mov     w1, w0                   // Pasar el resultado a w1 como argumento para printf
    bl      printf

    // Epílogo de la función main
    ldp     x29, x30, [sp], #16      // Restaurar el frame pointer y el link register
    mov     x0, #0                   // Código de salida 0
    ret

// Función calcular_potencia
// Entrada: w0 = base (x), w1 = exponente (n)
// Salida: w0 = x^n
calcular_potencia:
    stp     x29, x30, [sp, #-16]!    // Guardar el frame pointer (fp) y el link register (lr)
    mov     x29, sp                  // Establecer nuevo frame pointer

    mov     w2, w0                   // Guardar la base original en w2
    mov     w0, #1                   // Iniciar resultado en 1 (x^0 = 1)

loop_potencia:
    cbz     w1, fin_potencia         // Si el exponente es 0, fin (w0 contiene el resultado)
    mul     w0, w0, w2               // Multiplicar resultado acumulado por la base
    sub     w1, w1, #1               // Decrementar exponente en 1
    b       loop_potencia            // Repetir hasta que el exponente sea 0

fin_potencia:
    ldp     x29, x30, [sp], #16      // Restaurar el frame pointer y el link register
    ret                              // Retornar el resultado en w0

// Datos
.data
msg_potencia: .string "El resultado de x^n es: %d\n"
