; Programa para ejemplificar el modo bitmap multicolor

; 10 SYS49152

*=$0801

        BYTE    $0B, $08, $0A, $00, $9E, $34, $39, $31, $35, $32, $00, $00, $00

; El programa se cargará en 49152

* = $c000

; Por defecto el VIC direcciona el banco 0: $0000 - $3fff

; Dentro de este banco, los bloques de 8K son:
; - $0000 - $1fff => bloque 0
; - $2000 - $3fff => bloque 1 => usamos este bloque de 8K

Prog45
        jsr rellenaBitmap
        jsr rellenaRamPantalla
        jsr rellenaRamColor
        jsr configuraBitmap
fin     jmp fin

configuraBitmap

        lda #Azul
        sta BGCOL0

        lda #$01
        sta abBaseMulti

        jsr activaBitmapMulti

        rts

rellenaRamPantalla

        lda #%00010000  ; Blanco y negro
        sta rbByte

        lda #<VICSCN
        sta rbComienzoLo
        lda #>VICSCN
        sta rbComienzoHi

        lda #<$07e8
        sta rbFinLo
        lda #>$07e8
        sta rbFinHi

        jsr rellenaBloque

        rts

rellenaRamColor

        lda #Cyan
        sta rbByte

        lda #<COLORRAM
        sta rbComienzoLo
        lda #>COLORRAM
        sta rbComienzoHi

        lda #<$dbe8
        sta rbFinLo
        lda #>$dbe8
        sta rbFinHi

        jsr rellenaBloque

        rts

rellenaBitmap

        lda #%00011011  ; Los 4 colores: 00-01-10-11
        sta rbByte

        lda #<$2000
        sta rbComienzoLo
        lda #>$2000
        sta rbComienzoHi

        lda #<$4000
        sta rbFinLo
        lda #>$4000
        sta rbFinHi

        jsr rellenaBloque

        rts

