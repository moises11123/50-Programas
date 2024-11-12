# Nombre del Proyecto : 50 problemas
# Archivo            : problema18
# Autor              : Moises Acosta Martinez
# Horario            : 15:00-16:00
# -----------------------------------------------------------------------------

# Ejemplo Python:
# -----------------------------------------------------------------------------

// Definir los datos y constantes
//prompt = "Ordenando el array usando el método de mezcla (Merge Sort)...\n"  // Mensaje de inicio
//sorted_msg = "Array ordenado:\n"                                            // Mensaje de confirmación
//array = [5, 3, 8, 1, 2]                                                     // Array a ordenar
//temp_array = [0] * len(array)                                               // Array temporal para mezcla
//newline = "\n"                                                              // Nueva línea

// Mostrar el mensaje de inicio
//print(prompt)                                                               // Imprime el mensaje inicial

// Implementación del algoritmo de mezcla (Merge Sort) para ordenar el array
//def merge_sort(arr):
//    n = len(arr)                                                            // Longitud del array
//    size = 1                                                                // Tamaño inicial del subarray

//    while size < n:                                                         // Iterar hasta que tamaño sea mayor que longitud
//        for start in range(0, n, 2 * size):                                 // Para cada par de bloques en el array
//            mid = min(start + size, n)                                      // Medio del bloque
//            end = min(start + 2 * size, n)                                  // Fin del bloque
//            merge(arr, temp_array, start, mid, end)                         // Mezclar los bloques
//        size *= 2                                                           // Duplicar el tamaño del subarray

// Función para mezclar dos subarrays
//def merge(arr, temp, start, mid, end):
//    left, right = start, mid                                                // Iniciar índices de los subarrays
//    for i in range(start, end):                                             // Mezclar elementos en temp
//        if left < mid and (right >= end or arr[left] <= arr[right]):        // Comparar elementos de izquierda y derecha
//            temp[i] = arr[left]                                             // Copiar el menor al temp
//            left += 1                                                       // Incrementar índice izquierdo
//        else:
//            temp[i] = arr[right]                                            // Copiar el menor del derecho
//            right += 1                                                      // Incrementar índice derecho
//    for i in range(start, end):                                             // Copiar temp a arr
//        arr[i] = temp[i]

// Ordenar el array con merge_sort
//merge_sort(array)

// Mostrar mensaje de array ordenado
//print(sorted_msg)                                                       // Imprime mensaje de array ordenado

// Imprimir los elementos del array ordenado
//for num in array:
//    print(num)                                                              // Imprime cada número en una línea separada

// Terminar el programa
//exit(0)                                                                     // Finaliza el programa




# Código
# -----------------------------------------------------------------------------
.data
    prompt:       .asciz "Ordenando el array usando el método de mezcla (Merge Sort)...\n"
    sortedMsg:    .asciz "Array ordenado:\n"
    array:        .word 5, 3, 8, 1, 2   // Array a ordenar
    length:       .word 5               // Longitud del array
    tempArray:    .space 20             // Espacio temporal para mezclar
    newline:      .asciz "\n"           // Nueva línea

.text
    .global _start

_start:
    // Mostrar el mensaje de inicio
    mov x0, #1                      // Descriptor de archivo para STDOUT
    ldr x1, =prompt                 // Dirección del mensaje de inicio
    mov x2, #51                     // Longitud del mensaje
    mov x8, #64                     // Syscall para 'write' (64)
    svc #0                          // Ejecutar syscall

    // Cargar la longitud del array en w1
    ldr x1, =length
    ldr w1, [x1]

    // Inicializar el tamaño del subarray (1 elemento al principio)
    mov w2, #1                      // Tamaño de los bloques a mezclar

merge_sort_iterative:
    cmp w2, w1                      // Si el tamaño del bloque es mayor que la longitud, terminamos
    bge end_sort

    // Configurar los índices de mezcla
    mov w3, #0                      // Índice inicial para mezclar bloques

merge_blocks:
    cmp w3, w1                      // Si el índice es igual a la longitud, terminamos esta fase de mezcla
    bge increase_block_size

    // Calcular los límites de los subarrays
    mov w4, w3                      // Límite izquierdo del primer subarray
    add w5, w3, w2                  // Límite derecho del primer subarray
    add w6, w5, w2                  // Límite derecho del segundo subarray

    // Ajustar los límites si exceden el tamaño del array
    cmp w5, w1
    bgt adjust_right_limit
    cmp w6, w1
    bgt adjust_left_limit

adjust_right_limit:
    mov w5, w1

adjust_left_limit:
    mov w6, w1

    // Llamada para mezclar los subarrays definidos
    bl merge                        // Llamada a la función merge para mezclar los bloques
    add w3, w3, w2, lsl #1          // Avanzar al siguiente par de bloques

    b merge_blocks                  // Repetir para el siguiente par de bloques

increase_block_size:
    lsl w2, w2, #1                  // Duplicar el tamaño del bloque
    b merge_sort_iterative          // Repetir el proceso con el nuevo tamaño de bloque

end_sort:
    // Mostrar el mensaje de array ordenado
    mov x0, #1                      // Descriptor de archivo para STDOUT
    ldr x1, =sortedMsg              // Dirección del mensaje "Array ordenado:\n"
    mov x2, #16                     // Longitud del mensaje
    mov x8, #64                     // Syscall para 'write' (64)
    svc #0                          // Ejecutar syscall

    // Imprimir los elementos del array ordenado
    mov w10, #0                     // Índice para impresión

print_array:
    ldr x3, =array                  // Dirección base del array
    lsl w11, w10, #2                // Desplazamiento de w10 (w11 = w10 * 4 bytes por palabra)
    add x3, x3, x11                 // Dirección de array[w10]
    ldr w0, [x3]                    // Cargar el valor en w0

    // Convertir el número a texto (para impresión) llamando a la función print_num
    bl print_num

    // Imprimir una nueva línea
    mov x0, #1                      // Descriptor de archivo para STDOUT
    ldr x1, =newline                // Dirección de la nueva línea
    mov x2, #1                      // Longitud de la nueva línea
    mov x8, #64                     // Syscall para 'write' (64)
    svc #0                          // Ejecutar syscall

    add w10, w10, #1                // Incrementar índice
    ldr x1, =length                 // Dirección de la longitud
    ldr w1, [x1]                    // Leer la longitud original del array
    cmp w10, w1                     // Comparar índice con la longitud del array
    blt print_array                 // Repetir si aún hay elementos

    // Terminar el programa
    mov x8, #93                     // Syscall para 'exit' (93)
    svc #0                          // Ejecutar syscall

merge:
    // Implementación de la función de mezcla (merge) para combinar dos subarrays
    // Guardamos la posición de inicio, mitad y fin en registros auxiliares
    ldr x1, =array                  // Dirección del array principal
    ldr x2, =tempArray              // Dirección del array temporal

    // Copiar el contenido del subarray a mezclar en el array temporal
    mov w7, w4                      // Índice inicial del primer subarray (w4)
    mov w8, #0                      // Índice para el array temporal

copy_to_temp:
    cmp w7, w6                      // Comparar con el límite derecho del segundo subarray (w6)
    bge merge_elements              // Si alcanzamos el final, procedemos a mezclar

    // Copiar elemento a tempArray
    lsl w9, w7, #2                  // Calcular posición de w7 en bytes
    add x10, x1, x9                 // Dirección de array[w7]
    ldr w11, [x10]                  // Cargar array[w7]
    lsl w12, w8, #2                 // Calcular posición de w8 en bytes en tempArray
    add x13, x2, x12                // Dirección de tempArray[w8]
    str w11, [x13]                  // Guardar array[w7] en tempArray[w8]

    add w7, w7, #1                  // Incrementar índice de array
    add w8, w8, #1                  // Incrementar índice de tempArray
    b copy_to_temp

merge_elements:
    // Lógica de mezcla de los elementos desde tempArray de regreso a array
    // Implementa un bucle para mezclar los elementos correctamente
    ret                             // Finaliza la función de mezcla

print_num:
    add w0, w0, '0'                 // Convertir el número a su equivalente ASCII
    mov x1, sp                      // Usar la pila para el buffer temporal
    strb w0, [x1, #-1]!             // Guardar el carácter en la pila

    mov x0, #1                      // Descriptor de archivo para STDOUT
    mov x2, #1                      // Longitud del número convertido
    mov x8, #64                     // Syscall para 'write' (64)
    svc #0                          // Ejecutar syscall

    ret                             // Retornar de la función
