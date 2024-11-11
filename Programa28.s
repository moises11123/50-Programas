# Nombre del Proyecto : 50 problemas
# Archivo            : problema28
# Autor              : Moises Acosta Martinez
# Horario            : 15:00-16:00
# -----------------------------------------------------------------------------

# Ejemplo Python:
# -----------------------------------------------------------------------------

// Valores de entrada
// value = 0x0000B8D8C5750010  // Valor inicial de 64 bits
// mask = 0x0000B8D8C5750018   // Máscara para bits 8-11
// result = 0                  // Inicialización del resultado

// Mensajes para imprimir en cada paso
// msgInit = "Valor inicial: 0x{:016X}\n"
// msgMask = "Máscara: 0x{:016X}\n"
// msgSet = "Bits establecidos: 0x{:016X}\n"
// msgClear = "Bits borrados: 0x{:016X}\n"
// msgToggl = "Bits alternados: 0x{:016X}\n"

// Imprimir valor inicial
// print(msgInit.format(value))

// Imprimir máscara
// print(msgMask.format(mask))

// Establecer bits usando OR (establece bits en '1' en las posiciones de la máscara)
// set_bits_result = value | mask

// Imprimir resultado de establecer bits
// print(msgSet.format(set_bits_result))

// Borrar bits usando AND con la negación de la máscara (borra bits en '1' en las posiciones de la máscara)
// clear_bits_result = value & ~mask

// Imprimir resultado de borrar bits
// print(msgClear.format(clear_bits_result))

// Alternar bits usando XOR (cambia los bits en '1' en las posiciones de la máscara)
// toggle_bits_result = value ^ mask

// Imprimir resultado de alternar bits
// print(msgToggl.format(toggle_bits_result))



# Código
# -----------------------------------------------------------------------------

.data
    value:    .quad   0x0000B8D8C5750010	// Valor inicial
    mask: 	.quad   0x0000B8D8C5750018	// Máscara para bits 8-11
    result:   .quad   0                 	// Resultado
 
	// Mensajes
    msgInit:  .string "Valor inicial: 0x%016lX\n"
	msgMask:  .string "Máscara: 0x%016lX\n"
	msgSet:   .string "Bits establecidos: 0x%016lX\n"
	msgClear: .string "Bits borrados: 0x%016lX\n"
	msgToggl: .string "Bits alternados: 0x%016lX\n"
 
.text
.global main
.align 2
 
main:
	stp     x29, x30, [sp, #-16]!
	mov     x29, sp
 
	// Imprimir valor inicial y máscara
    adrp	x0, msgInit
	add 	x0, x0, :lo12:msgInit
	adrp    x1, value
	add     x1, x1, :lo12:value
	bl      printf
 
	adrp    x0, msgMask
	add     x0, x0, :lo12:msgMask
	adrp    x1, mask
	add     x1, x1, :lo12:mask
	bl      printf
 
	// Establecer bits
	adrp    x0, value
	add     x0, x0, :lo12:value
	adrp    x1, mask
	add     x1, x1, :lo12:mask
	bl      set_bits
	str 	x0, [sp, #-8]!        	// Guardar resultado
 
    adrp	x0, msgSet
    add 	x0, x0, :lo12:msgSet
    ldr 	x1, [sp], #8          	// Recuperar resultado
	bl  	printf
 
	// Borrar bits
	adrp    x0, value
	add     x0, x0, :lo12:value
	adrp    x1, mask
	add     x1, x1, :lo12:mask
	bl      clear_bits
	str 	x0, [sp, #-8]!        	// Guardar resultado
 
    adrp	x0, msgClear
    add 	x0, x0, :lo12:msgClear
    ldr 	x1, [sp], #8 	         // Recuperar resultado
	bl  	printf
 
	// Alternar bits
	adrp    x0, value
	add     x0, x0, :lo12:value
	adrp    x1, mask
	add     x1, x1, :lo12:mask
	bl      toggle_bits
	str 	x0, [sp, #-8]!        	// Guardar resultado
 
    adrp	x0, msgToggl
    add 	x0, x0, :lo12:msgToggl
    ldr 	x1, [sp], #8          	// Recuperar resultado
	bl  	printf
 
	ldp     x29, x30, [sp], #16
	mov 	x0, #0
	ret
 
// Función para establecer bits
set_bits:
	orr     x0, x0, x1
	ret
 
// Función para borrar bits
clear_bits:
    bic 	x0, x0, x1
	ret
 
// Función para alternar bits
toggle_bits:
	eor     x0, x0, x1
	ret
