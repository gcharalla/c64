; Rutina para probar bvs/bvc y el flag V

flagV

        lda #127
        adc #127        ; Sustituir por otros valores y probar
        bvs pintaOverf  ; cómo funciona el salto condicional

pintaNoOverf
        
        PINTA_CADENA_D noOverf  ; El ensamblador sustituye esta
        jmp finV                ; llamada por el código de la macro

pintaOverf

        PINTA_CADENA_D overf    ; Idem

finV
        rts

; Cadenas

overf   text "overflow"
        byte 13, 00

noOverf text "no overflow"
        byte 13, 00
