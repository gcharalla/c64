; Sonidos del juego

; El sonido se resuelve con 4 piezas:
; 
; 1- Unas estructuras de datos (tablas) donde se guarda información sobre
; los sonidos que hay que reproducir porque ha ocurrido algo (ej. disparo o
; colisión).
; 2- Ante determinados eventos (ej. disparo o colisión) activar información
; en esas estructuras de datos.
; 3- Una rutina que, en cada ciclo del juego, analiza las estructuras de datos
; y reproduce la música / sonido que toque reproducir según la información
; activa en las mismas. Es muy importante tener claro que el sonido no se
; reproduce de comienzo a fin, sino un poco en cada ciclo del bucle del juego.
; 4- Unas tablas con la información "musical" del disparo / colisión. Es decir,
; las frecuencias y las duraciones.

vocesActivas    byte $00,$00,$00
vocesEntradas   byte $00,$00,$00
vocesRetardos   byte $00,$00,$00
vocesSonidosLo  byte <sonidoDisparo,<sonidoColision,$00
vocesSonidosHi  byte >sonidoDisparo,>sonidoColision,$00

; Tablas con los sonidos del disparo y la colisión. Un sonido puede constar de
; varias entradas en la tabla.

; Debido a la sencillez de los sonidos (son sonidos, no melodías), NO nos
; complicamos con octava - nota - duración - volumen. Simplemente codificamos
; frecuencia low - frecuencia high - duración. El volumen es fijo.

; La duración la mediremos en número de ciclos del bucle de juego.

; El disparo tiene dos entradas y el fin de tabla
sonidoDisparo   byte 209,18,5
                byte 96,22,5
                byte 255,255,255 ; fin de la tabla

; La colisión tiene una entrada y el fin de tabla
sonidoColision  byte 31,21,20
                byte 255,255,255 ; fin de la tabla

; Inicializa el SID y las voces

inicializaSonido

        ; Inicializa el SID
        ;jsr inicializaImagenSID
        ;jsr transfiereImagenSID

        ; Fija el volumen
        lda #$0f
        sta volumen
        jsr fijaVolumen

        ; Configura las voces
        jsr configuraVoz0Disparo
        jsr configuraVoz1Colision

        rts

configuraVoz0Disparo

        ; Fija la forma de onda
        lda #Rampa
        sta formaOnda
        lda #Voz0
        sta ffoVoz
        jsr fijaFormaOnda

        ; Fija la envolvemente ADSR
        lda #$00
        sta attack
        lda #$00
        sta decay
        lda #$0a
        sta sustain
        lda #$00
        sta release
        lda #Voz0
        sta faVoz
        jsr fijaADSR

        rts

configuraVoz1Colision

        ; Fija la forma de onda
        lda #Ruido
        sta formaOnda
        lda #Voz1
        sta ffoVoz
        jsr fijaFormaOnda

        ; Fija la envolvemente ADSR
        lda #$00
        sta attack
        lda #$00
        sta decay
        lda #$0a
        sta sustain
        lda #$00
        sta release
        lda #Voz1
        sta faVoz
        jsr fijaADSR

        rts

; Actualiza las voces

actualizaSonido

        ldy #$00

asBucle
        
        ; Voz activa?
        lda vocesActivas,y
        cmp #$01
        bne asSgte

        ; Reproduce el sonido
        sty rsVoz
        jsr reproduceSonido
        ldy rsVoz

asSgte

        ; Ha terminado?
        cpy #$02
        beq asFin
        iny
        jmp asBucle

asFin

        rts
        
; Reproduce el sonido para la voz cargada en rsVoz

; El sonido no se reproduce de comienzo a fin, sino un poco en cada
; ciclo del bucle de juego.

rsVoz   byte $00

reproduceSonido

        ; Carga la voz en X
        ldx rsVoz

        ; Mira el retardo de esa voz, es decir, si el sonido viene sonando
        ; ya de un ciclo anterior
        lda vocesRetardos,x
        bne rsDecRetardo

        ; Si el retardo es 0, es porque la entrada todavía no ha sonado

        ; Hay que ir a la tabla de definición del sonido (sonido = varias
        ; entradas) y cargar sus datos de frecuencia y duración 

        lda vocesEntradas,x
        tay

        ; Configura el puntero ($fb-$fc),y
        lda vocesSonidosLo,x
        sta $fb

        lda vocesSonidosHi,x
        sta $fc

        ; Carga la frecuencia low
        lda ($fb),y
        sta frecLo

        ; Carga la frecuencia high
        iny
        lda ($fb),y
        sta frecHi

        ; Fija la frecuencia
        stx ffVoz
        jsr fijaFrecuencia
        ldx rsVoz

        ; Carga la duración en ciclos de bucle de juego
        iny
        lda ($fb),y
        sta vocesRetardos,x

        ; Activa la voz
        stx avVoz
        jsr activaVoz
        ldx rsVoz

        ; Empieza a sonar transfierendo imagen al SID
        jsr transfiereImagenSID
        ldx rsVoz
        
        rts

rsDecRetardo

        ; Si el retardo es mayor que cero, es porque el sonido ya viene
        ; sonando de un ciclo anterior; hay que decrementar el retardo y,
        ; caso de llegar a 0, actualizar la entrada

        sec
        sbc #$01
        sta vocesRetardos,x

        beq rsActEntrada

        rts

rsActEntrada

        lda vocesEntradas,x
        clc
        adc #$03
        sta vocesEntradas,x

        ; Si es la última entrada ($ff) hay que desactivar la voz y
        ; poner la entrada a 0 de nuevo

        tay
        
        lda vocesSonidosLo,x
        sta $fb

        lda vocesSonidosHi,x
        sta $fc

        lda ($fb),y
        cmp #$ff

        beq rsActEntrada0

        rts

rsActEntrada0

        lda #$00
        sta vocesEntradas,x

        sta vocesActivas,x

        stx dvVoz
        jsr desactivaVoz
        ldx rsVoz

        jsr transfiereImagenSID
        
        rts

; Rutina para activar el sonido del disparo

activaSonidoDisparo

        lda #$01
        sta vocesActivas

        ; Opcional: volver a empezar el sonido desde el comienzo
        ; Alternativa: continuar por donde iba...
        ; lda #$00
        ; sta vocesEntradas
        ; sta vocesRetardos

        ; Con el disparo el efecto de volver a empezar el sonido no queda
        ; bien, porque es muy habitual el disparo continuo, y en ese caso
        ; el sonido no llega a completarse; por ese motivo, se comenta

        rts

; Rutina para activar el sonido de la colisión

activaSonidoColision

        lda #$01
        sta vocesActivas+1

        ; Opcional: volver a empezar el sonido desde el comienzo
        ; Alternativa: continuar por donde iba...
        lda #$00
        sta vocesEntradas+1
        sta vocesRetardos+1

        rts
