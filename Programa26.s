# Nombre del Proyecto : 50 problemas
# Archivo            : problema26
# Autor              : Moises Acosta Martinez
# Horario            : 15:00-16:00
# -----------------------------------------------------------------------------

# Ejemplo Python:
# -----------------------------------------------------------------------------

// Valores de entrada
// value1 = 0x1234567812345678  // Número de 64 bits
// value2 = 0x8765432187654321  // Número de 64 bits

// Mensajes de salida
// msgAnd = "AND: {:016X}\n"
// msgOr = "OR: {:016X}\n"
// msgXor = "XOR: {:016X}\n"

// Realizar operación bitwise AND
// and_result = value1 & value2

// Imprimir resultado de AND
// print(msgAnd.format(and_result))

// Realizar operación bitwise OR
// or_result = value1 | value2

// Imprimir resultado de OR
// print(msgOr.format(or_result))

// Realizar operación bitwise XOR
// xor_result = value1 ^ value2

// Imprimir resultado de XOR
// print(msgXor.format(xor_result))



# Código
# -----------------------------------------------------------------------------

.data
	// Valores de entrada
	value1:  	.quad   0x1234567812345678
	value2:      .quad   0x8765432187654321
 
	// Mensajes de salida
    msgAnd:  	.string "AND: %016lX\n"
	msgOr:   	.string "OR: %016lX\n"
	msgXor:      .string "XOR: %016lX\n"
 
.text
.global main
.align 2
 
main:
	stp     x29, x30, [sp, #-16]!
	mov     x29, sp
 
	// Realizar operaciones bitwise
    ldr 	x2, =value1
	ldr 	x3, =value2
	ldr     x2, [x2]
	ldr     x3, [x3]
 
	and     x4, x2, x3
	orr 	x5, x2, x3
    eor 	x6, x2, x3
 
	// Imprimir resultados
    adrp	x0, msgAnd
    add 	x0, x0, :lo12:msgAnd
    mov 	x1, x4
    bl  	printf
 
    adrp	x0, msgOr
    add 	x0, x0, :lo12:msgOr
	mov 	x1, x5
	bl      printf
 
	adrp    x0, msgXor
	add 	x0, x0, :lo12:msgXor
    mov 	x1, x6
	bl  	printf
 
	ldp     x29, x30, [sp], #16
	mov 	x0, #0
	ret
