; Este programa es para verificar los modos de direccionamiento
; soportados por las instrucciones sta, stx y sty

* = $c000 ; El programa se cargará en la posición 49152

Prog11

        ; inicializaciones

        lda #$00
        ldx #$00
        ldy #$00

        ; sta

        sta $c100       ; Modo absoluto: soportado
        sta $c100,x     ; Modo absoluto indexado X: soportado
        sta $c100,y     ; Modo absoluto indexado Y: soportado
        sta $fb         ; Modo página cero: soportado
        sta $fb,x       ; Modo página cero indexado X: soportado
        sta $fb,y       ; El ensamblador lo convierte en sta $00fb,y
                        ; *** Comprobar en depurador ***
        sta $(fb),y     ; Modo indirecto indexado: soportado
        sta $(fb,x)     ; Modo indexado indirecto: soportado

        ; stx

        stx $c100       ; Modo absoluto: soportado
        stx $fb         ; Modo página cero: soportado
        stx $fb,y       ; Modo página cero indexado Y: soportado
                        ; El ensamblador NO lo convierte en stx $00fb,y
        ;stx $c100,y    ; Hay que comentarlo porque no ensambla

        ; sty

        sty $c100       ; Modo absoluto: soportado
        sty $fb         ; Modo página cero: soportado
        sty $fb,x       ; Modo página cero indexado X: soportado
                        ; El ensamblador NO lo convierte en sty $00fb,x
        ;sty $c100,x    ; Hay que comentarlo porque no ensambla

        rts
