; Programa para ejemplificar el modo de dir. indirecto - indexado
; Borra la RAM de pantalla.

; La RAM de pantalla ocupa 1000 posiciones, desde la $0400 hasta la
; $07e7, ambas incluidas. 1000 posiciones no se pueden recorrer con
; un sólo índice X o Y. Por ello, se configura un puntero en página
; cero y se va incrementando el puntero desde $0400 hasta $07e7.

* = $c000 ; El programa se cargará en 49152

; Constantes

pantInicio      = $0400
pantFinal       = $07e7

puntLow         = $fb
puntHigh        = $fc

espacio         = 32

prog10
        lda #<pantInicio        ; Configura el puntero $fb - $fc
        sta $fb                 ; para que empiece apuntando al
        lda #>pantInicio        ; comienzo de la pantalla
        sta $fc

bucle   lda #espacio            ; Carta el código del espacio en A
        
        ldy #$00                ; Pone el índice Y a 0; queda fijo

        sta (puntLow),y         ; Pone el espacio en la posición
                                ; apuntada por el puntero más el
                                ; índice Y (que vale 0 fijo)

        jsr puntIncrementa      ; Incrementa el puntero mediante
                                ; rutina aparte

        lda $fb                 ; Compara el puntero $fb - $fc
        cmp #<pantFinal         ; con el final de pantalla

        bne bucle               ; Si no ha llegado final, vuelve

        lda $fc
        cmp #>pantFinal

        bne bucle               ; Si no ha llegado final, vuelve

        rts                     ; Si final, vuelve a BASIC

puntIncrementa

        inc $fb                 ; Incrementa el LSB del puntero

        bne fin                 ; Si no llega a 0, fin de rutina

        inc $fc                 ; Si pasa por 0, incrementa MSB

fin     rts                     ; Fin de rutina

watch puntLow                   ; Utilidad del debugger para ver
watch puntHigh                  ; cómo cambia el puntero

