; Programa para ejemplificar el uso del TOD

; El TOD se pintará en la esquina superior izquierda de la pantalla
; 60 veces por segundo, cada vez que se produzca una interrupción del SO

; 10 SYS49152

*=$0801

        BYTE    $0B, $08, $0A, $00, $9E, $34, $39, $31, $35, $32, $00, $00, $00

; El programa se cargará en 49152

*=$c000

Prog58

        ; Inhabilita las interrupciones
        sei

        ; Configura la rutina de interrupción
        lda #<rutinaInterrupcion
        sta CINV

        lda #>rutinaInterrupcion
        sta CINV+1

        ; Arranca el reloj
        lda #$00
        sta TODTEN

        ; Habilita las interrupciones
        cli

        ; Vuelve a BASIC
        rts

; Rutina de interrupción

rutinaInterrupcion

        ; Pinta la hora
        jsr pintaTOD

        ; Continúa con la interrupción es del SO
        jmp $ea31

pintaTOD

        ; Lee y pinta horas
        jsr pintaHoras

        ; Pinta :
        lda #58
        sta $0402

        ; Lee y pinta minutos
        jsr pintaMinutos

        ; Pinta :
        lda #58
        sta $0405

        ; Lee y pinta segundos
        jsr pintaSegundos

        ; Lee décimas para el desbloqueo (aunque no las pinte)
        lda TODTEN

        rts

pintaHoras

        ; Lee horas
        lda TODHRS
        and #$1f ; para quitar el bit AM/PM y otros bits del nibble alto

        ; Pinta horas
        sta numeroBCD

        lda #<VICSCN
        sta posicionLo


        lda #>VICSCN
        sta posicionHi

        jsr pintaBCD
        
        rts

pintaMinutos

        ; Lee minutos
        lda TODMIN

        ; Pinta minutos
        sta numeroBCD

        lda #<$0403
        sta posicionLo


        lda #>$0403
        sta posicionHi

        jsr pintaBCD
        
        rts

pintaSegundos

        ; Lee segundos
        lda TODSEC

        ; Pinta segundos
        sta numeroBCD

        lda #<$0406
        sta posicionLo


        lda #>$0406
        sta posicionHi

        jsr pintaBCD
        
        rts
