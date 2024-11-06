//Acosta Martinez Moises 22210278
//Lenguajes de interfaz 15:00-16:00


.section .data
prompt: .asciz "Introduce la temperatura en Celsius: "
result_msg: .asciz "La temperatura en Fahrenheit es: %.2f\n"
scanf_format: .asciz "%lf"        // Formato para leer double
temp_celsius: .double 0
temp_fahrenheit: .double 0

// Definición de constantes
nine: .double 9.0
five: .double 5.0
thirtytwo: .double 32.0

.section .text
.global main

main:
    // Pedir la temperatura en Celsius
    ldr x0, =prompt
    bl printf

    // Leer la temperatura en Celsius
    ldr x0, =scanf_format       // Cargar formato de scanf
    ldr x1, =temp_celsius       // Cargar dirección de temp_celsius
     bl scanf

    // Convertir Celsius a Fahrenheit
    ldr x1, =temp_celsius       // Cargar dirección de temp_celsius
    ldr d0, [x1]                // Cargar el valor de Celsius en d0

    // Cargar los valores constantes desde la sección de datos
    ldr x1, =nine               // Cargar dirección de 9.0
    ldr d2, [x1]                // Cargar 9.0 en d2
    ldr x1, =five               // Cargar dirección de 5.0
    ldr d3, [x1]                // Cargar 5.0 en d3
    ldr x1, =thirtytwo          // Cargar dirección de 32.0
    ldr d4, [x1]                // Cargar 32.0 en d4

    // Realizar la conversión: (C * 9/5) + 32
    fmul d1, d0, d2             // d1 = Celsius * 9.0
    fdiv d1, d1, d3             // d1 = (Celsius * 9.0) / 5.0
    fadd d1, d1, d4             // d1 = ((Celsius * 9.0) / 5.0) + 32.0

    // Almacenar el resultado en temp_fahrenheit
    ldr x1, =temp_fahrenheit    // Cargar dirección de temp_fahrenheit
    str d1, [x1]                // Almacenar el resultado

    // Mostrar el resultado
    ldr x0, =result_msg         // Cargar dirección del mensaje
    fmov d0, d1                 // Mover el resultado a d0 para printf
    bl printf
   

    // Salir del programa
    mov x0, #0                  // Código de salida
    mov x8, #93                 // Número de syscall para salir en Linux (exit)
    svc #0   
