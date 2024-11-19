# Nombre del Proyecto : 50 problemas
# Archivo            : problema39
# Autor              : Moises Acosta Martinez
# Horario            : 15:00-16:00
# -----------------------------------------------------------------------------

# Ejemplo Python:
# -----------------------------------------------------------------------------
// Número decimal de ejemplo
//num_decimal = 29

// Mensaje de salida
//msg_binario = "El binario es: {}"

// Convertir el número decimal a binario
//binario = bin(num_decimal)[2:].zfill(32)  // Convierte a binario y llena a 32 bits

// Imprimir el resultado
//print(msg_binario.format(binario))

# Código
# ---------------------------------------------------------------------------

.data
num_decimal: .word 29                      // Número decimal de ejemplo (29 en este caso)
msg_binario: .string "El binario es: %s\n" // Mensaje de salida
binario: .space 33                         // Cadena para almacenar el binario (32 bits + nulo)

.text
.global main
.align 2

main:
    // Prologo de la función main
    stp     x29, x30, [sp, #-16]!
    mov     x29, sp

    // Cargar el número decimal
    adrp    x0, num_decimal               // Cargar la base de la dirección de 'num_decimal'
    add     x0, x0, :lo12:num_decimal     // Completa la dirección de 'num_decimal'
    ldr     w1, [x0]                      // Cargar el valor decimal en w1

    // Inicialización
    adrp    x2, binario                   // Cargar la base de la dirección de 'binario'
    add     x2, x2, :lo12:binario         // Completa la dirección de 'binario'
    mov     w3, #32                       // Contador para 32 bits

loop_conversion:
    subs    w3, w3, #1                    // Decrementa el contador de bits
    lsr     w4, w1, w3                    // Desplaza el número a la derecha
    and     w4, w4, #1                    // Aisla el bit menos significativo
    add     w4, w4, '0'                   // Convierte el bit en carácter ASCII ('0' o '1')
    strb    w4, [x2], #1                  // Almacena el carácter en la cadena y avanza el puntero

    cbnz    w3, loop_conversion           // Repite hasta procesar los 32 bits

    // Terminar la cadena con un nulo
    mov     w4, #0                        // Terminador nulo
    strb    w4, [x2]

    // Imprimir el resultado
    adrp    x0, msg_binario               // Cargar el mensaje para printf
    add     x0, x0, :lo12:msg_binario
    adrp    x1, binario                   // Cargar la dirección base de 'binario' para printf
    add     x1, x1, :lo12:binario
    bl      printf

    // Epílogo de la función main
    ldp     x29, x30, [sp], #16           // Restaurar el frame pointer y el link register
    mov     x0, #0                        // Código de salida 0
    ret
