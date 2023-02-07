; Programa para comparar subrutinas y macros

* = $c100 ; El programa se cargará en 49408

Prog21b

        PINTA_PANTALLA_V 2              ; Llama a la macro

        rts                             ; Vuelve a BASIC

; Esta macro pinta un carácter X en la posición de pantalla $0401

; Es habitual que el nombre se ponga en mayúsculas (convenio),
; y añadir al final una letra por cada parámetro, que será una D
; en el caso de una dirección, y una V en el caso de un valor

defm    PINTA_PANTALLA_V
        ; /1 pasará el carácter a pintar
        lda #/1
        sta $0401

        endm

; Para hacer la comparación de subrutina vs macro más sencilla se ha
; eliminado la posición de pantalla como parámetro.

; El paso de posiciones de memoria en macros es sencillo, porque cada
; llamada a la macro se sustituye por una copia de su código, y en cada copia
; los parámetros se sustituyen por sus valores, sean estos valores simples o
; direcciones.

; En cambio el paso de posiciones de memoria como parámetro en subrutinas es
; algo más complejo. Como sólo cabe un byte en cada posición de memoria, y
; como las posiciones de memoria del C64 tienen 2 bytes (64K), la conclusión
; es que nos hacen falta 2 bytes o posiciones de memoria para pasar una posición
; de memoria como parámetro: el byte menos significativo o LSB y el byte más
; significativo o MSB.

; Para evitar esta complejidad extra, que aporta poco a la comparación
; subrutina vs macro, y que de hecho puede confundir, se usan direcciones
; fijas, no parametrizables.
