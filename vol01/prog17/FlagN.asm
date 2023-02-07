; Rutina para probar bmi/bpl y el flag N o S

flagN

        lda #127
        adc #127        ; Sustituir por otros valores y probar
        bmi pintaNegat  ; cómo funciona el salto condicional

pintaPosit
        
        PINTA_CADENA_D positivo ; El ensamblador sustituye esta
        jmp finN                ; llamada por el código de la macro

pintaNegat

        PINTA_CADENA_D negativo ; Idem

finN
        rts

; Cadenas

positivo        text "positivo"
                byte 13, 00

negativo        text "negativo"
                byte 13, 00
