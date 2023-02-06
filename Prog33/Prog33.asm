; Programa para ejemplificar la expansión de sprites

* = $c000 ; El programa se cargará en 49152

; Programa

Prog33

        COPIA_DATOS_DD sprites,bloque0

        CONF_MULTICOLOR_VV rojo,amarillo

        CONF_BASICA_VDV 0,254,negro
        CONF_AVANZADA_VVVV 0,1,0,0
        POSICION_VVV 0,120,150

        CONF_BASICA_VDV 1,254,negro
        CONF_AVANZADA_VVVV 1,1,0,1
        POSICION_VVV 1,150,150

        CONF_BASICA_VDV 2,254,negro
        CONF_AVANZADA_VVVV 2,1,1,0
        POSICION_VVV 2,180,150

        CONF_BASICA_VDV 3,254,negro
        CONF_AVANZADA_VVVV 3,1,1,1
        POSICION_VVV 3,230,150

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
; expansión horizontal y vertical

defm CONF_AVANZADA_VVVV
        ;/1 = número del sprite
        ;/2 = multicolor
        ;/3 = expansión horizontal
        ;/4 = expansión vertical

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
        beq @fin

        lda tabla,x
        ora expver
        sta expver

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

        lda #/2        ; Fija la posición X del sprite 0
        sta posicionx0,x

        lda #/3        ; Fija la posición Y del sprite 0
        sta posiciony0,x

        endm
