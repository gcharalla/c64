; Variables relacionadas con los asteroides

asteroidesSprites       byte $01,$02,$03,$04,$05,$06,$07
asteroidesActivos       byte $01,$01,$00,$00,$00,$00,$00
asteroidesX             byte $50,$60,$00,$00,$00,$00,$00
asteroidesY             byte $50,$60,$00,$00,$00,$00,$00
asteroidesVelocidad     byte $03,$01,$00,$00,$00,$00,$00
asteroidesAngulo        byte $05,$03,$00,$00,$00,$00,$00
asteroidesExpansion     byte $01,$00,$00,$00,$00,$00,$00

; Inicializa los asteroides

inicializaAsteroides

        ldy #$00

iaBucle

        ; Posición
        lda asteroidesSprites,y
        sta psNumero

        lda asteroidesX,y
        sta psCoordX

        lda asteroidesY,y
        sta psCoordY

        jsr posicionaSprite

        ; Configuración del multicolor para todos los sprites
        ; No hace falta por ser común para todos los sprites

        ; Configuración básica del sprite
        lda asteroidesSprites,y
        sta cbNumero
        
        lda #200 ; Bloque 200 de 64 bytes
        sta cbBloque
        
        lda #GrisClaro
        sta cbColor

        jsr configuraBasica

        ; Configuración avanzada
        lda asteroidesSprites,y
        sta caNumero

        lda #$01
        sta caMulticolor

        lda asteroidesExpansion,y
        sta caExpansionH
        sta caExpansionV

        lda #$01 ; Tras ajustar los disparos ponemos el sprite por encima
        sta caPrioFondo

        jsr configuraAvanzada

        ; Ha terminado?
        iny
        cpy #$06
        bne iaBucle

        ; Para arrancar el reloj TOD
        sta TODTEN

        rts

; Actualiza los asteroides

actualizaAsteroides

        ; Actualiza la posición de los asteroides
        jsr actualizaPosicionAsteroides

        rts

; Actualiza la posición de los asteroides

actualizaPosicionAsteroides

        ldy #$00

apaBucle
        
        ; Activo?
        lda asteroidesActivos,y
        beq apaSgte

        ; Calcula la nueva posición
        lda asteroidesX,y
        sta cnpX

        lda asteroidesY,y
        sta cnpY

        lda asteroidesVelocidad,y
        sta cnpVelocidad

        lda asteroidesAngulo,y
        sta cnpAngulo

        jsr calculaNuevaPosicionJugador

        ; Verifica los límites de la X?
        lda cnpNuevaX
        sta asteroidesX,y

        ; Verifica los límites de la Y
        lda cnpNuevaY
        cmp #29
        bcs apaYMayor29

        lda #249
        
apaYMayor29

        cmp #250
        bcc apaYMenor250

        lda #30

apaYMenor250

        sta asteroidesY,y

        ; Actualiza la posición
        lda asteroidesSprites,y
        sta psNumero

        lda asteroidesX,y
        sta psCoordX

        lda asteroidesY,y
        sta psCoordY

        jsr posicionaSprite

apaSgte

        ; Ha terminado?
        iny
        cpy #$06
        bne apaBucle

        rts

