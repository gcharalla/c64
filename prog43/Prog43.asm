; Programa para ejemplificar el diseño y uso de pantallas con CMB prg Studio

; 10 SYS49152

*=$0801

        BYTE    $0B, $08, $0A, $00, $9E, $34, $39, $31, $35, $32, $00, $00, $00

; El programa se cargará en 49152

* = $c000

Prog43

        jsr borraPantalla
        jsr pintaPantalla
fin     jmp fin

chrout = $ffd2

borraPantalla

        lda #147
        jsr chrout
        rts

pintaPantalla

        ldx #$0

        lda tablaPantallasLo,x
        sta cbComienzoLo

        lda tablaPantallasHi,x
        sta cbComienzoHi

        ; 1000 = $03e8

        lda tablaPantallasLo,x
        clc
        adc #$e8
        sta cbFinLo

        lda tablaPantallasHi,x
        adc #$03
        sta cbFinHi

        lda #<VICSCN
        sta cbDestinoLo

        lda #>VICSCN
        sta cbDestinoHi

        jsr copiaBloque

        rts

; Tabla de pantallas
; De momento sólo hay una, pero podría haber más

tablaPantallasLo        byte <pantalla1
tablaPantallasHi        byte >pantalla1
