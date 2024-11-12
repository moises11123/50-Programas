# -----------------------------------------------------------------------------
# Nombre del Proyecto : 50 problemas
# Archivo            : problema12
# Autor              : Moises Acosta Martinez
# Horario            : 15:00-16:00
# -----------------------------------------------------------------------------

# Ejemplo Python:
# -----------------------------------------------------------------------------

// Definir los datos y constantes
//mensaje_resultado = "El valor máximo es: "
//arreglo = [505, 304, 360, 90, 820, 450, 670, 230]  // Arreglo de enteros precargado
//tamanio_arreglo = len(arreglo)                      // Tamaño del arreglo

// Función para encontrar el valor máximo en el arreglo
//def find_max(arr):
//    max_val = arr[0]  // Inicializar con el primer elemento del arreglo
//    for i in range(1, len(arr)):
//        if arr[i] > max_val:
//            max_val = arr[i]
//    return max_val

// Llamar a la función para encontrar el máximo
//valor_maximo = find_max(arreglo)

// Mostrar el mensaje y el número máximo
//print(mensaje_resultado, valor_maximo)




# Código
# -----------------------------------------------------------------------------


  .section .data
mensaje_resultado: .asciz "El valor máximo es: "
arreglo:          .quad 505, 304, 360, 90, 820, 450, 670, 230 // Arreglo de enteros precargado
tamanio_arreglo:  .quad 8                   // Tamaño del arreglo

        .section .text
        .global _start

_start:
        // Cargar la dirección del arreglo y su tamaño
        ldr x1, =arreglo               // Dirección del arreglo en x1
        ldr x0, =tamanio_arreglo       // Tamaño del arreglo en x0
        ldr x0, [x0]                   // Leer el tamaño en x0

        // Llamada a la subrutina para encontrar el máximo
        bl find_max                    // Al regresar, el máximo está en x3

        // Mostrar el mensaje de resultado
        ldr x0, =mensaje_resultado
        bl print_str

        // Imprimir el número máximo
        mov x0, x3                     // Pasar el máximo a x0 para imprimir
        bl print_num                   // Imprimir el número en consola

        // Terminar el programa
        mov x8, #93                    // Syscall para "exit"
        svc 0


find_max:
        ldr x3, [x1]                   // Inicializar x3 con el primer elemento como el máximo
        mov x2, #1                     // Índice inicial (segundo elemento)

loop:
        cmp x2, x0                     // Comparar índice con el tamaño del arreglo
        b.ge end_find_max              // Si índice >= tamaño, termina

        ldr x4, [x1, x2, lsl #3]       // Cargar el siguiente elemento en x4
        cmp x3, x4                     // Comparar máximo actual con el elemento
        csel x3, x3, x4, gt            // Si x3 > x4, mantener x3; de lo contrario, x3 = x4

        add x2, x2, #1                 // Incrementar el índice
        b loop

end_find_max:
        ret


print_str:
        mov x8, #64                    // Syscall para write
        mov x1, x0                     // Dirección de la cadena a imprimir
        mov x2, #128                   // Longitud máxima del mensaje
        mov x0, #1                     // File descriptor 1 (salida estándar)
        svc 0
        ret


print_num:
        // Aquí va la lógica para convertir x0 a ASCII y enviarlo a consola.
        // Por simplicidad, imprime el valor como texto.
        ret




