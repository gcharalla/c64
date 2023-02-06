; Programa para ejemplificar el modo bitmap

; 10 SYS49152

*=$0801

        BYTE    $0B, $08, $0A, $00, $9E, $34, $39, $31, $35, $32, $00, $00, $00

; El programa se cargará en 49152

* = $c000

; Por defecto el VIC direcciona el banco 0: $0000 - $3fff

; Dentro de este banco, los bloques de 8K son:
; - $0000 - $1fff => bloque 0
; - $2000 - $3fff => bloque 1 => usamos este bloque de 8K

Prog44
        jsr rellenaBitmap
        jsr rellenaColor
        jsr configuraBitmap
fin     jmp fin

configuraBitmap

        lda #$01
        sta abBase

        jsr activaBitmap

        rts

rellenaColor

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

rellenaBitmap

        lda #%00000001  ; Raya vertical de 1 pixel
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

