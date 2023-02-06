; Programa para ejemplificar el uso del color de borde y fondo

* = $c000 ; El programa se cargará en 49152

; Constantes

negro = $00
verde = $05

borde = $d020
fondo = $d021
ramcolor = $d800

home = 19
clr = 147       ; Para borrar la pantalla

chrout = $ffd2

Prog30

        jsr colorFondoBorde
        ;jsr colorTexto ; El color hay que ponerlo al final
                        ; porque chrout imprime en azul claro
        jsr imprimeTexto
        jsr colorTexto

siempre jmp siempre

colorFondoBorde

        lda #negro      ; Fondo y borde negros
        sta borde
        sta fondo

        rts

imprimeTexto

        lda #clr
        jsr chrout      ; Borra la pantalla

        ldx #$00        ; Imprime el texto de abajo carácter a carácter

bucle1  lda texto,x
        beq fin

        jsr chrout

        inx
        jmp bucle1

fin     rts

colorTexto

        ldx #$00        ; Dos primeras líneas en verde
        
        lda #verde
bucle2  sta ramcolor,x

        inx

        cpx #80
        bne bucle2

        rts

texto   text "soy un c64 pero parezco un mainframe..."
        byte $00

