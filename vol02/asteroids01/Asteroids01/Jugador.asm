; Variables relacionadas con el jugador

jugadorSprite           byte $00
jugadorX                byte 183
jugadorY                byte 100

; Rutinas relacionadas con el jugador

incializaJugador

        ; Posición
        lda jugadorSprite
        sta psNumero

        lda jugadorX
        sta psCoordX

        lda jugadorY
        sta psCoordY

        jsr posicionaSprite

        ; Configuración del multicolor para todos los sprites
        lda #GrisOscuro
        sta cmMulticolor1

        lda #Amarillo
        sta cmMulticolor2

        jsr configuraMulticolor

        ; Configuración básica del sprite
        lda jugadorSprite
        sta cbNumero
        
        lda #192 ; Bloque 192 de 64 bytes
        sta cbBloque
        
        lda #GrisClaro
        sta cbColor

        jsr configuraBasica

        ; Configuración avanzada
        lda jugadorSprite
        sta caNumero

        lda #$01
        sta caMulticolor

        lda #$00
        sta caExpansionH
        sta caExpansionV

        lda #$00
        sta caPrioFondo

        jsr configuraAvanzada

        rts

; Actualiza el jugador

actualizaJugador

        ;Actualiza la posición del jugador
        jsr actualizaPosicionJugador

        rts

; Actualiza la posición del jugador

actualizaPosicionJugador

        
        ; Arriba?
apjArriba

        lda #Arriba
        bit joy2
        
        bne apjAbajo

        dec jugadorY

        ; Abajo?
apjAbajo

        lda #Abajo
        bit joy2
        
        bne apjIzquierda

        inc jugadorY

        ; Izquierda?
apjIzquierda

        lda #Izquierda
        bit joy2
        
        bne apjDerecha

        dec jugadorX

        ; Derecha?
apjDerecha

        lda #Derecha
        bit joy2
        
        bne apjActualiza

        inc jugadorX

apjActualiza

        ; Actualiza la posición
        lda jugadorSprite
        sta psNumero

        lda jugadorX
        sta psCoordX

        lda jugadorY
        sta psCoordY

        jsr posicionaSprite

        rts
