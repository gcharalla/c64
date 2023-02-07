; Programa para ejemplificar el uso del modo carácter con color de fondo ext

; 10 SYS49152

*=$0801

        BYTE    $0B, $08, $0A, $00, $9E, $34, $39, $31, $35, $32, $00, $00, $00


; El programa se cargará en 49152

* = $c000

Prog41

        jsr configuraColoresFondo
        jsr configuraColoresPantalla
        jsr activaColorFondoExtendido
        jsr rellenaCaracteres
fin     jmp fin

configuraColoresFondo

        lda #Negro
        sta colorFondo0

        lda #Blanco
        sta colorFondo1

        lda #Rojo
        sta colorFondo2

        lda #Cyan
        sta colorFondo3

        jsr configuraColores

        rts

configuraColoresPantalla

        ldx #$00

rcpbucle

        lda #Azul    
        sta COLORRAM,x

        lda #Verde
        sta COLORRAM+250,x

        lda #Blanco
        sta COLORRAM+500,x

        lda #GrisOscuro
        sta COLORRAM+750,x

        inx

        cpx #250
        bne rcpbucle

        rts

rellenaCaracteres

        ldx #$00

rcbucle

        lda #%00000001
        sta VICSCN,x

        lda #%01000001
        sta VICSCN+250,x

        lda #%10000001
        sta VICSCN+500,x

        lda #%11000001
        sta VICSCN+750,x

        inx

        cpx #250
        bne rcbucle

        rts
