# -----------------------------------------------------------------------------
# Nombre del Proyecto : 50 problemas
# Archivo            : problema23
# Autor              : Moises Acosta Martinez
# Horario            : 15:00-16:00
# -----------------------------------------------------------------------------

# Ejemplo Python:
# -----------------------------------------------------------------------------
// Definir el número que queremos convertir a una cadena de dígitos ASCII
//number = 12345  // MOV x0, 12345
//result = []     // Reservar espacio para almacenar los dígitos ASCII (equivalente a .skip en //ensamblador)

// Bucle para convertir el número en dígitos ASCII
//while number > 0:  // CMP x0, #0 y BNE convert_loop
    // Dividir el número por 10 para obtener el cociente
    quotient = number // 10  // UDIV x4, x0, x3
    remainder = number % 10  // Obtener el resto de la división

    // Convertir el dígito en su valor ASCII sumando 48 (offset de ASCII para '0')
    ascii_digit = remainder + 48  // ADD x6, x6, #48
    result.append(chr(ascii_digit))  // STRB w6, [x1, x2] - Almacenar el dígito como carácter ASCII

    // Actualizar el número al cociente para continuar con el siguiente dígito
    number = quotient  // MOV x0, x4

// Invertir el resultado porque el dígito menos significativo está al final
result.reverse()  // Necesario para obtener la cadena en el orden correcto

// Convertir la lista de caracteres en una cadena
output_string = ''.join(result)  // Simular el terminador nulo en la cadena de salida
print(output_string)  // Equivalente a la syscall para imprimir la cadena

// Código de salida, simulando la syscall exit con el código 0
exit(0)  // MOV x8, 93 y SVC 0 - Llamada al sistema para terminar el programa




# Código
# -----------------------------------------------------------------------------

.section .data
    result: .skip 10              // Reservar espacio para la cadena de salida (máximo 10 dígitos)

.section .text
.global _start
_start:
    MOV x0, 12345                // El número a convertir a ASCII
    ADRP x1, result              // Cargar la dirección base de la cadena de resultado
    ADD x1, x1, :lo12:result     // Obtener la dirección de result
    MOV x2, 0                    // Índice para escribir en la cadena (comienza en 0)
    MOV x3, 10                   // Guardar el valor 10 en un registro para la división y multiplicación

convert_loop:
    UDIV x4, x0, x3              // Dividir el número entre 10 (obtener el cociente)
    MUL x5, x4, x3               // Multiplicar el cociente por 10 (obtener el residuo)
    SUB x6, x0, x5               // Resto de la división (el último dígito)
    ADD x6, x6, #48              // Convertir el dígito a su valor ASCII
    STRB w6, [x1, x2]            // Almacenar el dígito como carácter ASCII en la cadena
    ADD x2, x2, #1               // Avanzar el índice en la cadena
    MOV x0, x4                   // El nuevo número es el cociente
    CMP x0, #0                   // Comprobar si el número es 0
    BNE convert_loop             // Si no es 0, continuar el ciclo

    // Finalizar la cadena de caracteres con el terminador nulo (0)
    MOV w5, #0                   // Valor nulo (0)
    STRB w5, [x1, x2]            // Colocar el terminador nulo al final de la cadena

    // Imprimir la cadena resultante
    MOV x0, 1                    // Descriptor de archivo para stdout
    ADRP x1, result              // Dirección de la cadena
    ADD x1, x1, :lo12:result
    MOV x2, x2                   // Longitud de la cadena (el índice actual)
    MOV x8, 64                   // Syscall para write
    SVC 0                        // Llamada al sistema

    // Terminar el programa
    MOV x8, 93                   // Syscall para exit
    MOV x0, 0                    // Código de salida
    SVC 0                        // Llamada al sistema
