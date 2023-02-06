; Programa para ejemplificar el uso de macros

* = $c000 ; El programa se cargará en 49152

Prog21

        PINTA_PANTALLA_VD 1,$0400       ; Pinta el valor 1 en $0400
        PINTA_PANTALLA_VD 2,$0401       ; Pinta el valor 2 en $401
        rts                             ; Vuelve a BASIC

; Esta macro pinta un carácter X en una posición de pantalla Y

; Es habitual que el nombre se ponga en mayúsculas (convenio),
; y añadir al final una letra por cada parámetro, que será una D
; en el caso de una dirección, y una V en el caso de un valor

defm    PINTA_PANTALLA_VD
        ; /1 pasará el carácter a pintar
        ; /2 pasará la posición de pantalla
        lda #/1
        sta /2

        endm

; Si se analiza el código máquina generado tras ensamblar, por ejemplo con el
; depurador/debugger, se verá que cada "llamada" a PINTA_PANTALLA_VD es
; sustituda por el código lda #/1 sta /2, y tanto en /1 como en /2 aparecen
; los parámetros pasados.
