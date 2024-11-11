# -----------------------------------------------------------------------------
# Nombre del Proyecto : 50 problemas
# Archivo            : problema15
# Autor              : Moises Acosta Martinez
# Horario            : 15:00-16:00
# -----------------------------------------------------------------------------

# Ejemplo Python:
# -----------------------------------------------------------------------------

// Definición de datos
// array = [1, 3, 5, 7, 9, 11, 13, 15, 17, 19]  # Arreglo ordenado
// array_size = len(array)                       # Tamaño del arreglo
// target = 7                                    # Valor a buscar

// Búsqueda binaria en Python
// def binary_search(array, target):
//     low = 0                                   # Índice inicial (low)
//     high = array_size - 1                     # Índice final (high)

//     while low <= high:
//         mid = (low + high) // 2               # Calcula el índice medio

//         if array[mid] == target:              # Si se encuentra el valor
//             return mid                        # Retorna el índice

//         elif array[mid] < target:             # Si el valor es menor, busca en la mitad derecha
//             low = mid + 1

//         else:                                 # Si el valor es mayor, busca en la mitad izquierda
//             high = mid - 1

//     return -1                                 # Retorna -1 si el valor no se encuentra

// Ejecuta la función de búsqueda binaria y muestra el resultado
// result = binary_search(array, target)

// if result != -1:
//     print(f"Valor encontrado en el índice: {result}")
// else:
//     print("Valor no encontrado")



# Código
# -----------------------------------------------------------------------------
.section .data
array:      .word 1, 3, 5, 7, 9, 11, 13, 15, 17, 19  // Arreglo ordenado
array_size: .word 10                             // Tamaño del arreglo
target:     .word 7                              // Valor a buscar

.section .text
.global _start

_start:
    // Cargar el tamaño del arreglo y la dirección del primer elemento
    adrp x1, array_size                   // Carga la página base de array_size en x1
    add x1, x1, :lo12:array_size          // Completa la dirección con el offset bajo de array_size
    ldr w2, [x1]                          // Carga el tamaño del arreglo en w2

    adrp x3, array                        // Carga la página base de array en x3
    add x3, x3, :lo12:array               // Completa la dirección con el offset bajo de array
    adrp x4, target                       // Carga la página base de target en x4
    add x4, x4, :lo12:target              // Completa la dirección con el offset bajo de target
    ldr w5, [x4]                          // Carga el valor a buscar en w5

    mov w6, #0                            // Inicializa el índice de inicio (low)
    mov w7, w2                            // Inicializa el índice final (high) al tamaño del arreglo

binary_search_loop:
    cmp w6, w7                            // Verifica si low <= high
    bgt not_found                         // Si no, el valor no se encuentra

    add w8, w6, w7                        // w8 = low + high
    lsr w8, w8, #1                        // w8 = (low + high) / 2 (dividir entre 2)

    ldr w9, [x3, x8, lsl #2]              // Cargar el elemento en la mitad del arreglo (array[mid])
    cmp w9, w5                            // Compara el valor encontrado con el valor objetivo
    beq found                             // Si son iguales, hemos encontrado el valor

    blt search_right                      // Si el valor es menor que el objetivo, buscar en la mitad derecha
    b search_left                         // Si el valor es mayor, buscar en la mitad izquierda

search_left:
    sub w7, w8, #1                        // high = mid - 1
    b binary_search_loop                  // Repetir la búsqueda

search_right:
    add w6, w8, #1                        // low = mid + 1
    b binary_search_loop                  // Repetir la búsqueda

not_found:
    mov w0, #-1                           // Si no se encuentra el valor, retorna -1
    mov x8, #93                           // Código de salida para ARM Linux
    svc #0                                // Llama al sistema para salir

found:
    mov w0, w8                            // Retorna el índice donde se encontró el valor
    mov x8, #93                           // Código de salida para ARM Linux
    svc #0                                // Llama al sistema para salir
