; Programa para comparar subrutinas y macros

* = $c000 ; El programa se cargará en 49152

Prog21

        lda #$01                        ; Carácter a pintar
        sta char
        jsr pintaPantalla               ; Llama a la subrutina

        rts                             ; Vuelve a BASIC

; Esta subrutina pinta una carácter X en la posición de pantalla $0400
; El carácter X se pasa en la posición char

char    byte $00

pintaPantalla

        lda char
        sta $0400

        rts
