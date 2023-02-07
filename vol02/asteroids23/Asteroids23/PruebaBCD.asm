; Programa para probar la conversión de binario a BCD

*=$c000

pruebaBCD

        jsr prueba3N
        rts

contador        byte $00

prueba2N

        lda contador
        sta bite

        jsr biteToBCD

        lda biteBCDHi
        sta numeroBCD
        
        lda #<$0400
        sta posicionLo

        lda #>$0400
        sta posicionHi

        jsr pintaBCD

        lda biteBCDLo
        sta numeroBCD
        
        lda #<$0402
        sta posicionLo

        lda #>$0402
        sta posicionHi

        jsr pintaBCD

tecla2N

        jsr getin
        beq tecla2N

        lda contador
        clc
        adc #$01
        sta contador
        
        jmp prueba2N

contadorLo      byte $00
contadorHi      byte $00

prueba3N

        lda contadorLo
        sta bitesLo

        lda contadorHi
        sta bitesHi

        jsr bitesToBCD

        lda bitesBCDHi
        sta numeroBCD
        
        lda #<$0400
        sta posicionLo

        lda #>$0400
        sta posicionHi

        jsr pintaBCD

        lda bitesBCDLo
        sta numeroBCD
        
        lda #<$0402
        sta posicionLo

        lda #>$0402
        sta posicionHi

        jsr pintaBCD

tecla3N

        jsr getin
        beq tecla3N

        lda contadorLo
        clc
        adc #$01
        sta contadorLo
        
        lda contadorHi
        adc #$00
        sta contadorHi
        
        jmp prueba3N

