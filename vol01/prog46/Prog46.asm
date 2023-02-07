; Programa para ejemplificar el uso de scroll

; 10 SYS (49152)

*=$0801

        BYTE    $0E, $08, $0A, $00, $9E, $20, $28,  $34, $39, $31, $35, $32, $29, $00, $00, $00

; El programa se cargará en 49152

* = $c000

Prog46

        jsr inicializaPantalla
        jsr activa38Columnas
        jsr fijaScrollXMin

bucle

        jsr retarda
        jsr actualizaOffset
        jsr controlaSalto
        jsr actualizaScrollX
        jmp bucle

; Variables

mensaje text 'ABABABABABABABABABABABABABABABABABABABAB'
        byte $00

offsetX byte $00

; Rutinas

inicializaPantalla

        lda #147
        jsr $ffd2

        ldx #$00

ipBucle

        lda mensaje,x

        beq ipFin

        sta VICSCN,x
        inx
        
        jmp ipBucle

ipFin

        rts
        
fijaScrollXMin

        lda #$00
        sta offsetX

        sta fsX
        jsr fijaScrollX

        rts

actualizaOffset

        ; Lee el joystick A
        jsr leeJoystickA

        ; Hay movimiento?
        lda joyA
        cmp #Nada
        beq aoFin

        ; Calcula el nuevo offset

aoIzda

        lda #Izquierda
        bit joyA
        bne aoDcha
        
;        lda offsetX
;        cmp #%00000111
;        beq aoDcha

        inc offsetX

aoDcha

        lda #Derecha
        bit joyA
        bne aoFin

;        lda offsetX
;        cmp #%00000000
;        beq aoFin

        dec offsetX

aoFin

        rts        

controlaSalto

csDerecha

        lda offsetX
        cmp #%00001000
        bne csIzquierda

        jsr copiaDerecha

        lda #%00000000
        sta offsetX

        jsr nuevoDatoIzquierda

        jmp csFin

csIzquierda

        lda offsetX
        cmp #%11111111
        bne csFin

        jsr copiaIzquierda

        lda #%00000111
        sta offsetX

        jsr nuevoDatoDerecha

csFin

        rts

actualizaScrollX

        lda offsetX
        sta fsX

        jsr fijaScrollX

        rts

retarda

        lda #250
        sta retRaster

        jsr meteRetardoRaster

        rts

nuevoDatoIzquierda

        lda VICSCN+0
        cmp #'A'
        bne ndiA

        lda #'B'
        sta VICSCN+0

        jmp ndiFin

ndiA

        lda #'A'
        sta VICSCN+0

ndiFin

        rts

nuevoDatoDerecha

        lda VICSCN+39
        cmp #'A'
        bne nddA

        lda #'B'
        sta VICSCN+39

        jmp nddFin

nddA

        lda #'A'
        sta VICSCN+39

nddFin

        rts
