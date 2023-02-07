; Librería de rutinas para operaciones matemáticas

; Rutina que calcula el máximo de dos números

maxNumero1      byte $00
maxNumero2      byte $00
maxResultado    byte $00

maximo

        lda maxNumero1
        cmp maxNumero2

        bcc max2

max1

        lda maxNumero1
        sta maxResultado
        rts

max2

        lda maxNumero2
        sta maxResultado
        rts

; Rutina que calcula el mínimo de dos números

minNumero1      byte $00
minNumero2      byte $00
minResultado    byte $00

minimo

        lda minNumero1
        cmp minNumero2

        bcs min2

min1

        lda minNumero1
        sta minResultado
        rts

min2

        lda minNumero2
        sta minResultado
        rts

; Rutina para multiplicar un número de 2 bytes por 2 N veces

multNumLo       byte $00
multNumHi       byte $00

multVeces       byte $00

multResLo       byte $00
multResHi       byte $00

multiplica2NVeces

        lda multNumLo
        sta multResLo

        lda multNumHi
        sta multResHi

        ldx multVeces

        beq m2Fin

m2Bucle

        lda multResLo
        clc
        rol
        sta multResLo

        lda multResHi
        rol ; incluye el acarreo de la parte 'lo' a la 'hi', si existe
        sta multResHi

        dex
        bne m2Bucle

m2Fin

        rts

; Rutina para dividir un número de 2 bytes por 2 N veces

divNumLo        byte $00
divNumHi        byte $00

divVeces        byte $00

divResLo        byte $00
divResHi        byte $00

divide2NVeces

        lda divNumHi
        sta divResHi

        lda divNumLo
        sta divResLo

        ldx divVeces

        beq d2Fin

d2Bucle

        lda divResHi
        clc
        ror
        sta divResHi

        lda divResLo
        ror ; incluye el acarreo de la parte 'hi' a la 'lo', si existe
        sta divResLo

        dex
        bne d2Bucle

d2Fin

        rts
