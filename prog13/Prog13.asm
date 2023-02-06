; Progama para ejemplificar la suma multibyte con adc

* = $c000 ; El programa se cargará en 49152

Prog13

        ; Imprime la suma inicializada a cero

        ; (Esto se puede hacer de forma más compacta y sencilla
        ; con una macro, pero todavía no hemos llegado ahí :-( )

        jsr imprimeMem
        
        ; Suma los bytes LSB
        clc             ; Borra el acarreo anterior
        lda sum1Low     ; Carga el sumando 1, byte LSB
        adc sum2Low     ; Suma el sumando 2, byte LSB
        sta sumaLow     ; Pone la suma en suma, byte LSB

        ; Suma los bytes MSB

        ; *** OJO, ahora no se borra el acarreo ***

        lda sum1High    ; Carga el sumando 1, byte MSB
        adc sum2High    ; Suma el sumando 2, byte MSB
        sta sumaHigh    ; Pone la suma en suma, byte MSB

        ; Imprime la suma
        jsr imprimeMem

        rts             ; Vuelve a BASIC

; Variables

sum1Low         byte $ff
sum1High        byte $00

sum2Low         byte $ff
sum2High        byte $00

sumaLow         byte $00
sumaHigh        byte $00

