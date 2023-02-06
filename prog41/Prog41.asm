; Programa para ejemplificar el uso de juegos de caracteres multicolor

; 10 SYS49152

*=$0801

        BYTE    $0B, $08, $0A, $00, $9E, $34, $39, $31, $35, $32, $00, $00, $00

; El programa se cargará en 49152

* = $c000 

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

Prog41

        jsr copiaCaracteres
        jsr configuraJuegoCaracteres
        jsr configuraColoresFondo
        jsr configuraColoresPantalla
        jsr activaMulticolor
        jsr rellenaCaracteres
fin     jmp fin

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

configuraJuegoCaracteres

        lda #%00000111
        sta acJuego

        jsr activaJuego
        rts

configuraColoresFondo

        lda #Negro
        sta colorFondo0

        lda #Negro
        sta colorFondo1

        lda #Amarillo
        sta colorFondo2

        jsr configuraColores

        rts

configuraColoresPantalla

        lda #VerdeClaro
        sta rcColor

        jsr rellenaColor

        rts

rellenaCaracteres

        lda #$00
        sta rpCaracter

        jsr rellenaPantalla

        rts
