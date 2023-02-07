; Variables relacionadas con los asteroides

asteroidesSprites       byte $01,$02,$03,$04,$05,$06,$07
asteroidesActivos       byte $01,$00,$00,$00,$00,$00,$00
asteroidesX             byte $50,$00,$00,$00,$00,$00,$00
asteroidesY             byte $50,$00,$00,$00,$00,$00,$00
asteroidesVelocidad     byte $03,$00,$00,$00,$00,$00,$00
asteroidesAngulo        byte $05,$00,$00,$00,$00,$00,$00
asteroidesExpansion     byte $01,$00,$00,$00,$00,$00,$00

asteroidesFrame         byte 200

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
        
        lda asteroidesFrame ; Bloque 200 de 64 bytes
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
        cpy #$06
        beq iaFin
        iny
        jmp iaBucle

iaFin

        rts

; Actualiza los asteroides

actualizaAsteroides

        ; Actualiza la posición de los asteroides
        jsr actualizaPosicionAsteroides

        ; Actualiza el número de asteroides
        jsr actualizaAsteroidesActivos

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
        cpy #$06
        beq apaFin
        iny
        jmp apaBucle

apaFin

        rts

; Actualiza el número de asteroides activos

actualizaAsteroidesActivos

        ldy #$00

aaaBucle

        ; Activo?
        lda asteroidesActivos,y
        bne aaaSgte

        ; Activa un nuevo asteroide
        lda #$01
        sta asteroidesActivos,y

        ; El resto de datos aleatorios
        ; Para ello nos basamos en el reloj $a0-$a1-$a2
        ; $a2 es la posición que cambia más rápido

        lda $a2
        sta asteroidesX,y

        lda $a2
        sta asteroidesY,y

        lda $a2
        and #%00000011
        sta asteroidesVelocidad,y

        lda $a2
        and #%00000111
        sta asteroidesAngulo,y

        lda $a2
        and #%00000001
        sta asteroidesExpansion,y

        beq aaaNoExpand

        ; Expandido => Configuración avanzada
        lda asteroidesSprites,y
        sta caNumero

        lda #$01
        sta caMulticolor

        lda asteroidesExpansion,y
        sta caExpansionH
        sta caExpansionV

        lda #$01
        sta caPrioFondo

        jsr configuraAvanzada

aaaNoExpand

        rts

aaaSgte

        ; Ha terminado?
        cpy #$06
        beq aaaFin
        iny
        jmp aaaBucle

aaaFin

        rts
