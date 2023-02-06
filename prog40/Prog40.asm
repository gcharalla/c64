; Programa para ejemplificar el uso de juegos de caracteres personalizados

* = $c000 ; El programa se cargará en 49152

; Por defecto el VIC direcciona el banco 0: $0000 - $3fff

; Dentro de este banco, los bloques de 2K son:
; - $0000 - $07ff
; - $0800 - $0fff
; - $1000 - $17ff
; - $1800 - $1fff
; - $2000 - $17ff
; - $2800 - $2fff
; - $3000 - $37ff
; - $3800 - $3fff ==> vamos a usar este, que es el 111

Prog40

        jsr copiaCaracteres
        jsr configuraVic
        rts

copiaCaracteres

        lda #<comienzoCars
        sta cbComienzoLo

        lda #>comienzoCars
        sta cbComienzoHi

        lda #<finCars
        sta cbFinLo

        lda #>finCars
        sta cbFinHi

        lda #$00
        sta cbDestinoLo

        lda #$38
        sta cbDestinoHi

        jsr copiaBloque
        rts

configuraVic

        lda #%00000111
        sta acJuego

        jsr activaCars
        rts
