* = $c300 ; 49920

        SEGUNDA_MACRO
        rts

defm    SEGUNDA_MACRO

        ; Desde una macro se puede llamar a una subrutina
        lda #$05
        sta char
        jsr pintaPantalla

        ; Pero no se puede usar otra macro
        ; Tengo que comentar la "llamada" porque si la descomento no esambla
        ;PINTA_PANTALLA 6

        endm
