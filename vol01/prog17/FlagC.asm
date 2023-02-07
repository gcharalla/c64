; Rutina para probar bcs/bcc y el flag C

flagC

        lda #$01
        adc #$ff        ; Sustituir por otros valores y probar
        bcs pintaAcarreo; cómo funciona el salto condicional

pintaNoAcarreo
        
        PINTA_CADENA_D noAcarreo; El ensamblador sustituye esta
        jmp finC                ; llamada por el código de la macro

pintaAcarreo

        PINTA_CADENA_D acarreo  ; Idem

finC
        rts

; Cadenas

acarreo         text "acarreo"
                byte 13, 00

noACarreo       text "no acarreo"
                byte 13, 00
