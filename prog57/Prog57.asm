; Programa para ejemplificar el uso de temporización con el CIA1

; Cada segundo se actualizará un contador en la esquina
; superior izquierda de la pantalla

; 10 SYS49152

*=$0801

        BYTE    $0B, $08, $0A, $00, $9E, $34, $39, $31, $35, $32, $00, $00, $00

; El programa se cargará en 49152

*=$c000

Prog57

        ; Imprime un mensaje
        lda #<cadena
        sta cadenaLo

        lda #>cadena
        sta cadenaHi

        jsr pintaCadena

        ; Inhabilita las interrupciones
        sei

        ; Configura la rutina de interrupción
        lda #<rutinaInterrupcion
        sta CINV

        lda #>rutinaInterrupcion
        sta CINV+1

        ; Configura los timers A y B

        ; 1 segundo / 1,02 microsegundos = 980.392 ciclos = $000EF5A8
        ; Timer A = $F5A8
        ; Timer B = $000E

        lda #$a8
        sta TIMALO
        lda #$f5
        sta TIMAHI

        lda #$0e
        sta TIMBLO
        lda #$00
        sta TIMBHI

        ; Timer B: modo de funcionamiento "free running" y fuente timer A
        ; Además, arranca el timer B
        lda #%01000001
        sta CIACRB

        ; Timer A: modo de funcionamiento "free runing" y fuente reloj interno
        ; Además, arranca el timer A
        lda #%00000001
        sta CIACRA
        
        ; Habilita las interrupciones
        cli

        ; Vuelve a BASIC
        rts

; Mensaje

cadena  byte 13
        text "mira la esquina superior izquierda."
        byte 13
        text "veras un contador de segundos."
        byte 13
        text "cada segundo genera una interrupcion."
        byte 13
        text "pinta el contador y luego lo incrementa."
        ;byte 13
        text "a la vez se pueden hacer otras cosas..."
        byte 13
        byte $00

; Rutina de interrupción

contadorBCD     byte $00

rutinaInterrupcion

        ; Verifica si es interrupción del timer B
        lda CIAICR
        and #%00000010

        ; Si es 0, la interrupción no es del timer B
        beq riIntSO

        ; Si es 1, la interrupción sí es del timer B
        jsr pintaContadorBCD

        ; Recupera los registros y termina
        pla
        tay

        pla
        tax

        pla

        rti

riIntSO
        ; La interrupción es del SO
        jmp $ea31

pintaContadorBCD

        ; Carga el contador
        lda contadorBCD

        ; Lo pinta en la esquina superior izquierda        
        sta numeroBCD

        lda #<VICSCN
        sta posicionLo


        lda #>VICSCN
        sta posicionHi

        jsr pintaBCD

        ; Lo incrementa, teniendo en cuenta aritmética BCD
        sed
        clc
        lda contadorBCD
        adc #$01
        sta contadorBCD
        cld
        
        rts
