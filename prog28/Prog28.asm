; Programa para ejemplificar las diferencias entre códigos de pantalla y
; caracteres PETSCII

* = $c000 ; El programa se cargará en 49152

; Constantes

screencodeA = 1
petsciiA = 65

chrout = $ffd2

; Programa

Prog28

        lda #screencodeA        ; Imprimirá un A en esquina sup izqda
        sta $0400

        lda #petsciiA           ; Imprimirá una pica al lado
        sta $0401

        lda #screencodeA        ; No imprimirá nada porque el carácter
        jsr chrout              ; petscii con valor 1 no es imprimible

        lda #petsciiA           ; Imprimirá una A en el cursor
        jsr chrout

        rts

; Tras ejecutar el programa y comprobar que funciona como se espera,
; pulsar SHIFT + Windows en VICE. Se verá que la A mayúscula se convierte
; en minúscula, y la pica se convierte en A mayúscula. Esto es lo que
; cabría esperar porque el valor 65 de la posición $0401, al activar el
; mapa en minúsculas, se interpreta como A mayúscula (ver mapa de códigos
; de pantalla en minúsculas)  
