; Rutina para probar beq/bne y el flag Z

flagZ

        lda #$00        ; Sustituir por $00, $01, ..., y probar
        beq pintaIgual  ; cómo funciona el salto condicional

pintaNoIgual
        
        PINTA_CADENA_D noCero   ; El ensamblador sustituye esta
        jmp finZ                ; llamada por el código de la macro

pintaIgual

        PINTA_CADENA_D cero     ; Idem

finZ
        rts

; Cadenas

cero    text "cero/igual"
        byte 13, 00

noCero  text "no cero/no igual"
        byte 13, 00
