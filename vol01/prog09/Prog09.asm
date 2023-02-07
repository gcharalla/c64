; Programa para ejemplificar el modo de direccionamiento indirecto

* = $c000 ; El programa se cargará en la dirección 49152

; Constantes 

chrout = $ffd2 ; Rutina del Kernal para imprimir un carácter

Prog09
        jmp m0          ; Modo absoluto; salta a "m0"

        lda #$00        ; No se llega a ejecutar por el salto directo
        sta $0400       ; No se llega a ejecutar por el salto directo
        rts             ; No se llega a ejecutar por el salto directo

m0
        jmp (m1)        ; Modo indirecto; salta a la dirección
                        ; apuntada por m1 y m1+1, que es "m2"

        lda #$01        ; No se llega a ejecutar por el salto indirecto
        sta $0401       ; No se llega a ejecutar por el salto indirecto
        rts             ; No se llega a ejecutar por el salto indirecto

m1
        byte <m2,>m2    ; El operador < da el LSB y el > el MSB

m2      
        lda #$02        ; Sí se ejecuta por el salto indirecto
        sta $0402       ; Sí se ejecuta por el salto indirecto
        rts             ; Sí se ejecuta por el salto indirecto
