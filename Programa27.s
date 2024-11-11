# Nombre del Proyecto : 50 problemas
# Archivo            : problema27
# Autor              : Moises Acosta Martinez
# Horario            : 15:00-16:00
# -----------------------------------------------------------------------------

# Ejemplo Python:
# -----------------------------------------------------------------------------

// Importamos el módulo struct para representar números de 64 bits en hexadecimal
// import struct

// Valores iniciales de x y y
// x = 0x1234567812345678  // Número de 64 bits
// y = 0x0000000000000005  // Número de 64 bits

// Mensajes de formato
// msgX = "Valor de x: {:016X}\n"
// msgY = "Valor de y: {:016X}\n"
// msgLeft = "Desplazamiento a la izquierda: {:016X}\n"
// msgRight = "Desplazamiento a la derecha: {:016X}\n"

// Función para imprimir el valor de x
// print(msgX.format(x))

// Función para imprimir el valor de y
// print(msgY.format(y))

// Función para realizar el desplazamiento a la izquierda
// def shift_left(value, shift_by):
//     // Desplazar el valor hacia la izquierda por shift_by bits
//     result = value << shift_by
//     // Imprimir el resultado
//     print(msgLeft.format(result))

// Función para realizar el desplazamiento a la derecha
// def shift_right(value, shift_by):
//     // Desplazar el valor hacia la derecha por shift_by bits
//     result = value >> shift_by
//     // Imprimir el resultado
//     print(msgRight.format(result))

// Llamadas a las funciones
// shift_left(x, y)
// shift_right(x, y)



# Código
# -----------------------------------------------------------------------------

.data
    x:  	.quad   0x1234567812345678	// Número de 64 bits
    y:  	.quad   0x0000000000000005	// Número de 64 bits
	
    msgX:	.string "Valor de x: %016lX\n"
    msgY:	.string "Valor de y: %016lX\n"
    msgLeft: .string "Desplazamiento a la izquierda: %016lX\n"
    msgRight:.string "Desplazamiento a la derecha: %016lX\n"
	newline: .string "\n"
 
.text
.global main
.align 2
 
main:
	stp     x29, x30, [sp, #-16]!
	mov 	x29, sp
	
	// Imprimir valor de x
    adrp	x0, msgX
    add 	x0, x0, :lo12:msgX
    mov 	x1, x
    bl  	printf
	
	// Imprimir valor de y
    adrp	x0, msgY
    add     x0, x0, :lo12:msgY
    mov 	x1, y
    bl  	printf
	
	// Desplazamiento a la izquierda
    mov 	x0, x                  	// Cargar el valor de x
    mov 	x1, y                  	// Cargar el valor de y
    bl  	shift_left
	
	// Desplazamiento a la derecha
    mov 	x0, x                  	// Cargar el valor de x
    mov 	x1, y                  	// Cargar el valor de y
	bl  	shift_right
	
	ldp     x29, x30, [sp], #16
	mov 	x0, #0
	ret
 
// Función para desplazamiento a la izquierda
shift_left:
	stp     x29, x30, [sp, #-16]!
	mov 	x29, sp
	
    lsl 	x0, x0, x1             	// Desplazar x a la izquierda por y bits
	
	// Imprimir resultado
    adrp	x0, msgLeft
    add     x0, x0, :lo12:msgLeft
    bl  	printf
	
    ldp 	x29, x30, [sp], #16
	ret
 
// Función para desplazamiento a la derecha
shift_right:
	stp     x29, x30, [sp, #-16]!
	mov 	x29, sp
	
    lsr 	x0, x0, x1             	// Desplazar x a la derecha por y bits
	
	// Imprimir resultado
	adrp    x0, msgRight
	add     x0, x0, :lo12:msgRight
	bl      printf
	
	ldp     x29, x30, [sp], #16
	ret
