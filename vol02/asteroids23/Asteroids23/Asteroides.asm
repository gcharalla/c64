; Variables relacionadas con los asteroides

asteroidesConfComienzo
                                byte $00,$00,$00,$00,$00,$00,$00
                                byte $50,$00,$00,$00,$00,$00,$00
                                byte $01,$00,$00,$00,$00,$00,$00
                                byte $50,$00,$00,$00,$00,$00,$00
                                byte $02,$00,$00,$00,$00,$00,$00
                                byte $01,$00,$00,$00,$00,$00,$00
                                byte $01,$00,$00,$00,$00,$00,$00
                                byte 5,5,5,5,5,5,5
                                byte 0,0,0,0,0,0,0
asteroidesConfFin

asteroidesSprites               byte $01,$02,$03,$04,$05,$06,$07
asteroidesSpritesBits           byte 2,4,8,16,32,64,128
asteroidesActivos               byte $00,$00,$00,$00,$00,$00,$00
asteroidesXLo                   byte $50,$00,$00,$00,$00,$00,$00
asteroidesXHi                   byte $01,$00,$00,$00,$00,$00,$00
asteroidesY                     byte $50,$00,$00,$00,$00,$00,$00
asteroidesVelocidad             byte $02,$00,$00,$00,$00,$00,$00
asteroidesAngulo                byte $01,$00,$00,$00,$00,$00,$00
asteroidesExpansion             byte $01,$00,$00,$00,$00,$00,$00
asteroidesRetardoExplosion      byte 5,5,5,5,5,5,5
asteroidesExplosionFrame        byte 0,0,0,0,0,0,0

asteroidesFrame                 byte 200

; Inicializa variables de los asteroides

inicializaVariablesAsteroides

        lda #<asteroidesConfComienzo
        sta cbComienzoLo

        lda #>asteroidesConfComienzo
        sta cbComienzoHi

        lda #<asteroidesConfFin
        sta cbFinLo         

        lda #>asteroidesConfFin
        sta cbFinHi

        lda #<asteroidesActivos
        sta cbDestinoLo     

        lda #>asteroidesActivos
        sta cbDestinoHi     

        jsr copiaBloque

        rts

; Inicializa los asteroides

inicializaAsteroides

        ; Inicializa variables
        jsr inicializaVariablesAsteroides        

        ldy #$00

iaBucle

        ; Activo?
        lda asteroidesActivos,y
        cmp #$01
        bne iaSgte

        ; Posici??n
        lda asteroidesSprites,y
        sta psNumero

        lda asteroidesXLo,y
        sta psCoordXLo

        lda asteroidesXHi,y
        sta psCoordXHi

        lda asteroidesY,y
        sta psCoordY

        jsr posicionaSprite

        ; Configuraci??n del multicolor para todos los sprites
        ; No hace falta por ser com??n para todos los sprites

        ; Configuraci??n b??sica del sprite
        lda asteroidesSprites,y
        sta cbNumero
        
        lda asteroidesFrame ; Bloque 200 de 64 bytes
        sta cbBloque
        
        lda #GrisClaro
        sta cbColor

        jsr configuraBasica

        ; Configuraci??n avanzada
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

iaSgte

        ; Ha terminado?
        cpy #$06
        beq iaFin
        iny
        jmp iaBucle

iaFin

        rts

; Actualiza los asteroides

actualizaAsteroides

        ; Actualiza la posici??n de los asteroides
        jsr actualizaPosicionAsteroides

        ; Actualiza el n??mero de asteroides
        jsr actualizaAsteroidesActivos

        ; Analiza si los asteroides han colisionado (disparos)
        jsr actualizaColisionesAsteroides

        rts

; Actualiza la posici??n de los asteroides

actualizaPosicionAsteroides

        ldy #$00

apaBucle
        
        ; Activo?
        lda asteroidesActivos,y
        cmp #$01
        bne apaExplosion

        ; Calcula la nueva posici??n
        lda asteroidesXLo,y
        sta cnpXLo

        lda asteroidesXHi,y
        sta cnpXHi

        lda asteroidesY,y
        sta cnpY

        lda asteroidesVelocidad,y
        sta cnpVelocidad

        lda asteroidesAngulo,y
        sta cnpAngulo

        jsr calculaNuevaPosicionJugador

        ; Verifica los l??mites de la X
        lda cnpNuevaXLo
        sta asteroidesXLo,y

        lda cnpNuevaXHi
        sta asteroidesXHi,y

        jsr verificaLimitesXAsteroides

        ; Verifica los l??mites de la Y
        lda cnpNuevaY
        sta asteroidesY,y

        jsr verificaLimitesYAsteroides

        ; Actualiza la posici??n
        lda asteroidesSprites,y
        sta psNumero

        lda asteroidesXLo,y
        sta psCoordXLo

        lda asteroidesXHi,y
        sta psCoordXHi

        lda asteroidesY,y
        sta psCoordY

        jsr posicionaSprite

        jmp apaSgte

apaExplosion

        ; Explosion?
        lda asteroidesActivos,y
        cmp #$02
        bne apaSgte

        sty aeaAsteroide
        jsr animaExplosionAsteroide
        ldy aeaAsteroide

apaSgte

        ; Ha terminado?
        cpy #$06
        beq apaFin
        iny
        jmp apaBucle

apaFin

        rts

; Verifica los l??mites de la X

verificaLimitesXAsteroides

        lda asteroidesXHi,y
        beq apaXNoHi

apaXSiHi

        lda asteroidesXLo,y
        cmp #$57
        bcc apaXMenor343

        lda #$19
        sta asteroidesXLo,y
        lda #$00
        sta asteroidesXHi,y

apaXMenor343

        rts

apaXNoHi

        lda asteroidesXLo,y
        cmp #$18
        bcs apaXMayor24

        lda #$56
        sta asteroidesXLo,y
        lda #$01
        sta asteroidesXHi,y

apaXMayor24

        rts

; Verifica los l??mites de la Y

verificaLimitesYAsteroides

        lda asteroidesY,y
        cmp #40;#29
        bcs apaYMayor29

        lda #210

apaYMayor29

        cmp #211
        bcc apaYMenor211

        lda #41;#30

apaYMenor211

        sta asteroidesY,y

        rts

; Actualiza el n??mero de asteroides activos

actualizaAsteroidesActivos

        ldy #$00

aaaBucle

        ; Inactivo?
        lda asteroidesActivos,y
        cmp #$00
        bne aaaSgte

        ; Activa un nuevo asteroide
        lda #$01
        sta asteroidesActivos,y

        ; El resto de datos aleatorios
        ; Para ello nos basamos en el reloj $a0-$a1-$a2
        ; $a2 es la posici??n que cambia m??s r??pido

        lda $a2
        sta asteroidesXLo,y

        ;lda $a2
        and #%00000001
        sta asteroidesXHi,y

        jsr verificaLimitesXAsteroides

        lda $a2
        asl a ; A??adido para que los asteroides no salgan siempre en la diagonal
        sta asteroidesY,y

        jsr verificaLimitesYAsteroides

aaaVelocidad

        lda $a2
        and #%00000011
        sta asteroidesVelocidad,y
        beq aaaVelocidad ; A??adido para que no haya asteroides parados

        ;lda jugadorNivel ; Si se quiere que la velocidad vaya creciendo...
        ;clc
        ;adc #$01
        ;sta asteroidesVelocidad,y

        lda $a2
        and #%00000111
        sta asteroidesAngulo,y

        lda $a2
        and #%00000001 ; Correcci??n en LibSprites para poner / quitar expansi??n
        sta asteroidesExpansion,y

        ; Posici??n
        lda asteroidesSprites,y
        sta psNumero

        lda asteroidesXLo,y
        sta psCoordXLo

        lda asteroidesXHi,y
        sta psCoordXHi

        lda asteroidesY,y
        sta psCoordY

        jsr posicionaSprite

        ; Configuraci??n del multicolor para todos los sprites
        ; No hace falta por ser com??n para todos los sprites

        ; Configuraci??n b??sica del sprite
        lda asteroidesSprites,y
        sta cbNumero
        
        lda asteroidesFrame ; Bloque 200 de 64 bytes
        sta cbBloque
        
        lda #GrisClaro
        sta cbColor

        jsr configuraBasica

        ; Configuraci??n avanzada
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

        rts

aaaSgte

        ; Ha terminado?
        ;cpy #$06
        cpy jugadorNivel
        beq aaaFin
        iny
        jmp aaaBucle

aaaFin

        rts

; Analiza si los asteroides han colisionado (con disparos)

acaTemp byte $00

actualizaColisionesAsteroides

        ; Lee el registro de colisi??n de sprites - texto

        ; IMPORTANTE: Como al leerlo se borra, para procesarlo varias veces
        ; hay que hacer una copia en una variable temporal (acaTemp)

        lda SPBGCL
        sta acaTemp

        ldy #$00

acaBucle
        
        ; Activo?
        lda asteroidesActivos,y
        cmp #$01
        bne acaSgte

        ; Lee el registro de colisi??n de sprites - texto
        lda acaTemp

        ; Mira si el asteroide Y ha colisionado
        and asteroidesSpritesBits,y

        beq acaSgte

        ; Desactiva el asteroide para la aplicaci??n
        ; Si usamos el valor $00 el asteroide se volver?? a activar
        ; Necesitamos otro valor (ej. $02) para se??alizar a la aplicaci??n
        ; que hay que ejecutar la animaci??n de la explosi??n. Y ya puestos
        ; usaremos este mismo valor para la explosi??n del jugador (anterior-
        ; mente se usaba $00)
        lda #$02
        sta asteroidesActivos,y

        ; Desactiva el sprite del asteoride
        ;lda asteroidesSpritesBits,y
        ;eor SPENA
        ;sta SPENA

        ; Para el sonido de la colisi??n
        jsr activaSonidoColision

acaSgte

        ; Ha terminado?
        cpy #$06
        beq acaFin
        iny
        jmp acaBucle

acaFin

        rts

; Anima explosi??n

aeaAsteroide    byte $00
aeaNumeroFrame  byte $00

animaExplosionAsteroide

        ldy aeaAsteroide

        ; Decrementa el retardo
        lda asteroidesRetardoExplosion,y
        sec
        sbc #$01
        sta asteroidesRetardoExplosion,y

        beq aeaSgteFrame

        rts

aeaSgteFrame

        ; Vuelve a poner el retardo
        lda #5
        sta asteroidesRetardoExplosion,y

        ; Pasa al siguiente frame
        ldx asteroidesExplosionFrame,y
        stx aeaNumeroFrame

        ; Cambiar de frame => Configuraci??n b??sica del sprite
        lda asteroidesSprites,y
        sta cbNumero
        
        lda explosionFrames,x
        sta cbBloque
        
        lda #GrisClaro
        sta cbColor

        jsr configuraBasica
        ldx aeaNumeroFrame

        inx
        txa
        sta asteroidesExplosionFrame,y

        ; Ha terminado?
        cpx #$04
        beq aeaFinAnimacion

        rts

aeaFinAnimacion

        ; Incrementa los puntos del jugador
        lda jugadorPuntosLo
        clc
        adc #10
        sta jugadorPuntosLo

        lda jugadorPuntosHi ; Para el acarreo...
        adc #$00
        sta jugadorPuntosHi

        ; Decrementa el retardo del nivel
        dec jugadorRetardoNivel
        bne aeaFinAnimacion2

        ; Incrementa el nivel
        lda #5
        sta jugadorRetardoNivel
        
        lda jugadorNivel
        clc
        adc #$01
        sta jugadorNivel

        cmp #$07
        bne aeaFinAnimacion2

        lda #$06
        sta jugadorNivel

aeaFinAnimacion2        

        ; Vuelve a poner el frame 0
        ldx #$00
        txa
        sta asteroidesExplosionFrame,y

        ; El estado en desactivo
        lda #$00
        sta asteroidesActivos,y

        ; Y lee las colisiones para evitar dos seguidas (truco)
        lda SPBGCL

        rts


