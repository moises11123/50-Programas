# Nombre del Proyecto : 50 problemas
# Archivo            : problema49
# Autor              : Moises Acosta Martinez
# Horario            : 15:00-16:00
# -----------------------------------------------------------------------------

# Ejemplo Python:
# -----------------------------------------------------------------------------

//prompt_msg = "Introduce texto: "  # Mensaje de solicitud
//output_msg = "Texto ingresado: {}"  # Mensaje de salida

// Solicitar al usuario que ingrese un texto
//input_text = input(prompt_msg)  # Leemos la entrada del usuario

// Mostrar el texto ingresado
//print(output_msg.format(input_text))  # Mostramos el texto con el formato adecuado




# Código
# -----------------------------------------------------------------------------

.section .data
prompt_msg: .asciz "Introduce texto: "   // Mensaje de solicitud
output_msg: .asciz "Texto ingresado: %s\n" // Mensaje de salida

.section .bss
.lcomm buffer, 100                        // Buffer de 100 bytes para almacenar la entrada

.section .text
.global _start

_start:
    // Escribir mensaje de solicitud en pantalla
    mov x0, 1                              // File descriptor (1 = stdout)
    ldr x1, =prompt_msg                    // Dirección del mensaje de solicitud
    mov x2, 15                             // Tamaño del mensaje
    mov x8, 64                             // Syscall write (64 en ARM64)
    svc 0                                  // Llamada al sistema

    // Leer entrada desde el teclado
    mov x0, 0                              // File descriptor (0 = stdin)
    ldr x1, =buffer                        // Dirección del buffer para guardar la entrada
    mov x2, 100                            // Tamaño máximo a leer
    mov x8, 63                             // Syscall read (63 en ARM64)
    svc 0                                  // Llamada al sistema

    // Mostrar el texto ingresado
    mov x0, 1                              // File descriptor (1 = stdout)
    ldr x1, =output_msg                    // Dirección del mensaje de salida
    ldr x2, =buffer                        // Dirección del buffer donde está el texto
    mov x8, 64                             // Syscall write (64 en ARM64)
    svc 0                                  // Llamada al sistema

    // Salir del programa
    mov x8, 93                             // Syscall exit (93 en ARM64)
    mov x0, 0                              // Código de salida
    svc 0                                  // Llamada al sistema

