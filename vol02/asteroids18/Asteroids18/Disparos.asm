; Disparos activos con su posición charX,charY

disparosActivos         byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
disparosCharX           byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
disparosCharY           byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
disparosAngulo          byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00

; Rutina que convierte de pixelX,pixelY a charX,charY
; charX = ((pixelX-24)/8)+1, charY = ((pixelY-50)/8)+1
; Los +1 son para que el disparo salga más o menos del centro del sprite

pixelXLo        byte $00
pixelXHi        byte $00
pixelY          byte $00
charX           byte $00
charY           byte $00

pixel2Char

        ; Coordenada Y
        lda pixelY
        sec
        sbc #50;#40

        lsr a
        lsr a
        lsr a

        clc
        adc #$01

        sta charY

        ; Coordenada X (2 bytes)

        lda pixelXHi
        beq p2cNoHi

p2cSiHi

        lda pixelXLo

        lsr a
        lsr a
        lsr a

        clc
        adc #30; X=256 aporta 29 columas; +1 para centrar en el sprite...

        sta charX

        rts

p2cNoHi

        lda pixelXLo
        sec
        sbc #24;#12

        lsr a
        lsr a
        lsr a

        clc
        adc #$01

        sta charX

        rts

; Rutina que convierte de charX,charY a posición de memoria de vídeo

charX2          byte $00
charY2          byte $00
memLo           byte $00
memHi           byte $00

; Generado con "data generator"
tablaMemLo      byte $00,$28,$50,$78,$A0,$C8,$F0,$18,$40
                byte $68,$90,$B8,$E0,$08,$30,$58,$80,$A8
                byte $D0,$F8,$20,$48,$70,$98,$C0

; Generado con "data generator"
tablaMemHi      byte $04,$04,$04,$04,$04,$04,$04,$05,$05
                byte $05,$05,$05,$05,$06,$06,$06,$06,$06
                byte $06,$06,$07,$07,$07,$07,$07

char2Mem

        ldy charY2

        lda tablaMemLo,y

        clc
        adc charX2

        sta memLo

        lda tablaMemHi,y
        adc #$00 ; Para sumar acarreo de parte lo si lo hubiera

        sta memHi

        rts

; Rutina que crea un nuevo disparo

disparoCharX    byte $00        
disparoCharY    byte $00
disparoAngulo   byte $00

creaDisparo

        ; Verifica los límites
        lda disparoCharX
        cmp #00
        bcs cdXMayor00

        rts

cdXMayor00

        cmp #40
        bcc cdXMenor40

        rts

cdXMenor40

        lda disparoCharY
        cmp #00
        bcs cdYMayor0

        rts

cdYMayor0

        ;cmp #25
        cmp #24
        bcc cdYMenor25

        rts

cdYMenor25

        ; A partir de aquí crea el disparo
        ldx #$00

cdBucle
        lda disparosActivos,x
        bne cdActivo

        lda #$01
        sta disparosActivos,x

        lda disparoCharX
        sta disparosCharX,x

        lda disparoCharY
        sta disparosCharY,x

        lda disparoAngulo
        sta disparosAngulo,x

        rts

cdActivo

        inx
        cpx #10
        bne cdBucle

        rts

; Rutina que actualiza los disparos
; Atualiza: borra posición actual + mueve + pinta en nueva posición

actualizaDisparos

        ldx #$00

adBucle

        lda disparosActivos,x
        bne adActivo

        jmp adSgte

adActivo

        ; Borra el disparo en la posición actual
        lda disparosCharX,x
        sta charX3

        lda disparosCharY,x
        sta charY3

        lda #' '
        sta char

        jsr pintaCaracter

        ; Calcula nueva posición
        ; Mueve
        lda disparosCharX,x
        sta cnpdCharX

        lda disparosCharY,x
        sta cnpdCharY

        lda disparosAngulo,x
        sta cnpdAngulo

        lda disparosCharY,x
        sta cnpdCharY

        jsr calculaNuevaPosicionDisparo

        lda cnpdNuevaCharX

        ; Si llega al borde se desactiva
        cmp #00
        bcs cnpdCharXMayor00

        lda #00
        sta disparosActivos,x
        jmp adSgte

cnpdCharXMayor00

        cmp #40
        bcc cnpdCharXMenor40

        lda #00
        sta disparosActivos,x
        jmp adSgte

cnpdCharXMenor40

        sta disparosCharX,x

        lda cnpdNuevaCharY

        ; Si llega al borde se desactiva
        cmp #00
        bcs cnpdCharYMayor00

        lda #00
        sta disparosActivos,x
        jmp adSgte
        
cnpdCharYMayor00

        ;cmp #25
        cmp #24
        bcc cnpdCharYMenor25

        lda #00
        sta disparosActivos,x
        jmp adSgte

cnpdCharYMenor25

        sta disparosCharY,x

        ; Pinta el disparo en la nueva posición
        lda disparosCharX,x
        sta charX3

        lda disparosCharY,x
        sta charY3

        lda #'@'
        sta char

        jsr pintaCaracter

adSgte

        inx
        cpx #10
        beq adFin

        jmp adBucle

adFin

        rts

; Calcula la nueva posición del disparo

cnpdCharX       byte $00
cnpdCharY       byte $00
cnpdAngulo      byte $00
cnpdNuevaCharX  byte $00
cnpdNuevaCharY  byte $00

calculaNuevaPosicionDisparo

        lda cnpdAngulo

cnpdAngulo0 ; 0 grados

        cmp #0

        bne cnpdAngulo1

        lda cnpdCharX
        sta cnpdNuevaCharX

        lda cnpdCharY
        sec
        sbc #$01
        sta cnpdNuevaCharY

        rts

cnpdAngulo1 ; 45 grados

        cmp #1

        bne cnpdAngulo2

        lda cnpdCharX
        clc
        adc #$01
        sta cnpdNuevaCharX

        lda cnpdCharY
        sec
        sbc #$01
        sta cnpdNuevaCharY

        rts

cnpdAngulo2 ; 90 grados

        cmp #2

        bne cnpdAngulo3

        lda cnpdCharX
        clc
        adc #$01
        sta cnpdNuevaCharX

        lda cnpdCharY
        sta cnpdNuevaCharY

        rts

cnpdAngulo3 ; 135 grados

        cmp #3

        bne cnpdAngulo4

        lda cnpdCharX
        clc
        adc #$01
        sta cnpdNuevaCharX

        lda cnpdCharY
        clc
        adc #$01
        sta cnpdNuevaCharY

        rts

cnpdAngulo4 ; 180 grados

        cmp #4

        bne cnpdAngulo5

        lda cnpdCharX
        sta cnpdNuevaCharX

        lda cnpdCharY
        clc
        adc #$01
        sta cnpdNuevaCharY

        rts

cnpdAngulo5 ; 225 grados

        cmp #5

        bne cnpdAngulo6

        lda cnpdCharX
        sec
        sbc #$01
        sta cnpdNuevaCharX

        lda cnpdCharY
        clc
        adc #$01
        sta cnpdNuevaCharY

        rts

cnpdAngulo6 ; 270 grados

        cmp #6

        bne cnpdAngulo7

        lda cnpdCharX
        sec
        sbc #$01
        sta cnpdNuevaCharX

        lda cnpdCharY
        sta cnpdNuevaCharY

        rts

cnpdAngulo7 ; 315 grados

        cmp #7

        bne cnpdFin

        lda cnpdCharX
        sec
        sbc #$01
        sta cnpdNuevaCharX

        lda cnpdCharY
        sec
        sbc #$01
        sta cnpdNuevaCharY

        rts

cnpdFin

        lda cnpdCharX
        sta cnpdNuevaCharX

        lda cnpdCharY
        sta cnpdNuevaCharY

        rts
