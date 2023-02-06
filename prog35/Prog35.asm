; Programa para ejemplificar las prioridades de sprites

* = $c000 ; El programa se cargará en 49152

; Programa

Prog35

        COPIA_DATOS_DD frame0,bloque0   ; Copia los datos del frame0
        COPIA_DATOS_DD frame1,bloque1   ; Copia los datos del frame1

        CONF_MULTICOLOR_VV rojo,amarillo; Configura los colores compartidos

        CONF_BASICA_VDV 0,254,negro     ; Configura el sprite0 apunt. a frame0
        CONF_AVANZADA_VVVVV 0,1,0,0,0   ; Configura el sprite0 sin prioridad
        POSICION_VVV 0,120,65           ; Posiciona el sprite0 en 120,65

        CONF_BASICA_VDV 1,254,negro     ; Configura el sprite1 apunt. a frame0
        CONF_AVANZADA_VVVVV 1,1,0,0,1   ; Configura el sprite1 con prioridad
        POSICION_VVV 1,160,65           ; Posiciona el sprite1 en 160,65

        rts

; Tabla para convertir entre número de sprite y el bit correspondiente

tabla   byte 1,2,4,8,16,32,64,128

; Macro para copiar los datos de un sprite desde su ubicación provisional
; hasta su ubicación definitiva

defm COPIA_DATOS_DD
        ;/1 = dirección de origen
        ;/2 = dirección de destino

        ldx #$00

@bucle  lda /1,x
        sta /2,x
        
        inx

        cpx #$40

        bne @bucle

        endm

; Macro para configurar los colores del multicolor (colores compartidos)

defm CONF_MULTICOLOR_VV
        ;/1 = multicolor 1
        ;/2 = multicolor 2

        lda #/1
        sta multicolor1

        lda #/2
        sta multicolor2

        endm

; Macro para hacer la configuración básica de un sprite: puntero, activar y
; color del sprite

defm CONF_BASICA_VDV
        ;/1 = número del sprite
        ;/2 = dirección de los datos
        ;/3 = color del sprite

        ldx #/1

        lda #/2
        sta puntero0,x

        lda tabla,x
        ora activar
        sta activar

        lda #/3
        sta color0,x

        endm

; Macro para hacer la configuración avanzada de un sprite: multicolor,
; expansión horizontal y vertical, y prioridad respecto al fondo

defm CONF_AVANZADA_VVVVV
        ;/1 = número del sprite
        ;/2 = multicolor
        ;/3 = expansión horizontal
        ;/4 = expansión vertical
        ;/5 = prioridad respecto al fondo

        ldx #/1

        lda #/2
        beq @exphor

        lda tabla,x
        ora multicolor
        sta multicolor

@exphor

        lda #/3
        beq @expver

        lda tabla,x
        ora exphor
        sta exphor

@expver

        lda #/4
        beq @prio

        lda tabla,x
        ora expver
        sta expver

@prio

        lda #/5
        bne @fin

        lda tabla,x
        ora prioback
        sta prioback

@fin    nop
        
        endm

; Macro para posicionar un sprite

defm POSICION_VVV
        ;/1 = número del sprite
        ;/2 = posición X
        ;/3 = posición Y

        lda #/1
        asl a
        tax

        lda #/2
        sta posicionx0,x

        lda #/3
        sta posiciony0,x

        endm

