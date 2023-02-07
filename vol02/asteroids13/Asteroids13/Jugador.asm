; Variables relacionadas con el jugador

jugadorSprite           byte $00
jugadorActivo           byte $01
jugadorX                byte $90
jugadorY                byte $90
jugadorVelocidad        byte $00
jugadorAngulo           byte $00 ; Tantos angulos como frames: 0...7
jugadorRetardoAngulo    byte 5
jugadorRetardoDisparo   byte 5
jugadorRetardoExplosion byte 5
jugadorExplosionFrame   byte 0
jugadorVidas            byte 5

jugadorFrames           byte 192,193,194,195,196,197,198,199
explosionFrames         byte 201,202,203

; Inicializa el jugador

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

        lda #$01 ; Tras ajustar los disparos ponemos el sprite por encima
        sta caPrioFondo

        jsr configuraAvanzada

        rts

; Actualiza el jugador

actualizaJugador

        ; Analiza la situación del jugador
        lda jugadorActivo
        cmp #$01
        bne ajExplosion

        ; Actualiza la posición del jugador
        jsr actualizaPosicionJugador

        ; Actualiza los disparos del jugador
        jsr actualizaDisparosJugador

        ; Analiza si el jugador ha colisionado
        jsr actualizaColisionesJugador

        rts

ajExplosion

        ; Animación de explosión
        jsr animaExplosion

        rts
 
; Actualiza la posición del jugador

actualizaPosicionJugador

        
        ; Arriba? ===> acelera
apjArriba

        lda #Arriba
        bit joy2
        
        bne apjAbajo

        inc jugadorVelocidad

        ; Abajo? ===> frena
apjAbajo

        lda #Abajo
        bit joy2
        
        bne apjIzquierda

        dec jugadorVelocidad

        ; Izquierda? ===> reduce el ángulo
apjIzquierda

        lda #Izquierda
        bit joy2
        
        bne apjDerecha

        dec jugadorRetardoAngulo

        bne apjDerecha

        dec jugadorAngulo
        
        lda #5
        sta jugadorRetardoAngulo

        ; Derecha? ===> aumenta el ángulo
apjDerecha

        lda #Derecha
        bit joy2
        
        bne apjActualiza

        dec jugadorRetardoAngulo

        bne apjActualiza

        inc jugadorAngulo

        lda #5
        sta jugadorRetardoAngulo

apjActualiza

        ; La velocidad tiene que estar entre 0 y 3
        lda jugadorVelocidad
        cmp #255
        
        bne apjVelPositiva

        lda #0
        sta jugadorVelocidad

apjVelPositiva
        
        lda jugadorVelocidad
        cmp #4
        
        bne apjAngulo

        lda #3
        sta jugadorVelocidad

         ; El ángulo tiene que estar entre 0 y 7
apjAngulo

        lda jugadorAngulo
        cmp #255
        
        bne apjAngPositivo

        lda #7
        sta jugadorAngulo

apjAngPositivo
        
        lda jugadorAngulo
        cmp #8
        
        bne apjCalculo

        lda #0
        sta jugadorAngulo

        ; Calcula la nueva posición
apjCalculo

        lda jugadorX
        sta cnpX

        lda jugadorY
        sta cnpY

        lda jugadorVelocidad
        sta cnpVelocidad

        lda jugadorAngulo
        sta cnpAngulo

        jsr calculaNuevaPosicionJugador

        ; Verifica los límites de la X?
        lda cnpNuevaX
        sta jugadorX

        ; Verifica los límites de la Y
        lda cnpNuevaY
        cmp #29
        bcs apjYMayor29

        lda #249
        
apjYMayor29

        cmp #250
        bcc apjYMenor250

        lda #30

apjYMenor250

        sta jugadorY

        ; Actualiza el frame
        lda jugadorSprite
        sta cbNumero
        
        ldx jugadorAngulo
        lda jugadorFrames,x ; Frame en función del ángulo
        sta cbBloque
        
        lda #GrisClaro
        sta cbColor

        jsr configuraBasica
        
        ; Actualiza la posición
        lda jugadorSprite
        sta psNumero

        lda jugadorX
        sta psCoordX

        lda jugadorY
        sta psCoordY

        jsr posicionaSprite

        rts

; Calcula la nueva posición del jugador

cnpX            byte $00
cnpY            byte $00
cnpVelocidad    byte $00
cnpAngulo       byte $00
cnpNuevaX       byte $00
cnpNuevaY       byte $00

calculaNuevaPosicionJugador

        lda cnpAngulo

cnpAngulo0 ; 0 grados

        cmp #0

        bne cnpAngulo1

        lda cnpX
        sta cnpNuevaX

        lda cnpY
        sec
        sbc cnpVelocidad
        sta cnpNuevaY

        rts

cnpAngulo1 ; 45 grados

        cmp #1

        bne cnpAngulo2

        lda cnpX
        clc
        adc cnpVelocidad 
        sta cnpNuevaX

        lda cnpY
        sec
        sbc cnpVelocidad
        sta cnpNuevaY

        rts

cnpAngulo2 ; 90 grados

        cmp #2

        bne cnpAngulo3

        lda cnpX
        clc
        adc cnpVelocidad 
        sta cnpNuevaX

        lda cnpY
        sta cnpNuevaY

        rts

cnpAngulo3 ; 135 grados

        cmp #3

        bne cnpAngulo4

        lda cnpX
        clc
        adc cnpVelocidad 
        sta cnpNuevaX

        lda cnpY
        clc
        adc cnpVelocidad
        sta cnpNuevaY

        rts

cnpAngulo4 ; 180 grados

        cmp #4

        bne cnpAngulo5

        lda cnpX
        sta cnpNuevaX

        lda cnpY
        clc
        adc cnpVelocidad
        sta cnpNuevaY

        rts

cnpAngulo5 ; 225 grados

        cmp #5

        bne cnpAngulo6

        lda cnpX
        sec
        sbc cnpVelocidad 
        sta cnpNuevaX

        lda cnpY
        clc
        adc cnpVelocidad
        sta cnpNuevaY

        rts

cnpAngulo6 ; 270 grados

        cmp #6

        bne cnpAngulo7

        lda cnpX
        sec
        sbc cnpVelocidad 
        sta cnpNuevaX

        lda cnpY
        sta cnpNuevaY

        rts

cnpAngulo7 ; 315 grados

        cmp #7

        bne cnpFin

        lda cnpX
        sec
        sbc cnpVelocidad 
        sta cnpNuevaX

        lda cnpY
        sec
        sbc cnpVelocidad
        sta cnpNuevaY

        rts

cnpFin

        lda cnpX
        sta cnpNuevaX

        lda cnpY
        sta cnpNuevaY

        rts

; Actualiza los disparos del jugador

actualizaDisparosJugador

        ; Disparo? ===> crea un disparo
adjDisparo

        lda #Disparo
        bit joy2
        
        bne adjNoDisparo

        dec jugadorRetardoDisparo

        bne adjNoDisparo

        ; Convierte de pixelX,pixelY a charX,charY
        lda jugadorX
        sta pixelX

        lda jugadorY
        sta pixelY

        jsr pixel2Char
   
        lda charX
        sta disparoCharX
 
        lda charY
        sta disparoCharY
 
        lda jugadorAngulo
        sta disparoAngulo

        jsr creaDisparo
        
        lda #5
        sta jugadorRetardoDisparo

        ; No disparo? ===> nada
adjNoDisparo

        rts

; Analiza si el jugador ha colisionado

actualizaColisionesJugador

        ; Lee el registro de colisión de sprites
        lda SPSPCL

        ; Mira si el jugador (sprite 0) ha colisionado
        and #%00000001
        
        beq acjFin

        ; Activa la animación de explosión
        lda #$00
        sta jugadorActivo

acjFin

        rts


; Anima explosión

animaExplosion
        
        ; Decrementa el retardo
        dec jugadorRetardoExplosion

        beq aeSgteFrame

        rts

aeSgteFrame

        ; Vuelve a poner el retardo
        lda #5
        sta jugadorRetardoExplosion

        ; Pasa al siguiente frame
        ldy jugadorExplosionFrame

        ; Cambiar de frame => Configuración básica del sprite
        lda jugadorSprite
        sta cbNumero
        
        lda explosionFrames,y
        sta cbBloque
        
        lda #GrisClaro
        sta cbColor

        jsr configuraBasica

        iny
        sty jugadorExplosionFrame

        ; Ha terminado?
        cpy #$04
        beq aeFinAnimacion

        rts

aeFinAnimacion

        ; Decrementa las vidas
        lda jugadorVidas
        sec
        sbc #$01
        sta jugadorVidas

        ; Vuelve a poner el frame 0
        ldy #$00
        sty jugadorExplosionFrame

        ; El estado en activo
        lda #$01
        sta jugadorActivo

        ; Y lee las colisiones para evitar dos seguidas (truco)
        lda SPSPCL

        ; Otra cosa que se podría hacer (opcional) es resetear el juego,
        ; es decir, volver a la situación inicial o la situación inicial
        ; del nivel actual (posiciones, número de asteroides, etc.)

        rts
