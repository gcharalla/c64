; Programa para ejemplificar el uso de los joysticks

; 10 SYS49152

*=$0801

        BYTE    $0B, $08, $0A, $00, $9E, $34, $39, $31, $35, $32, $00, $00, $00

; El programa se cargará en 49152

*=$c000

Prog56

        ; Lee el joystick1
        jsr leeJoystick1

        ; Pinta el joystick1
        jsr pintaJoystick1

        jmp Prog56

; Rutina para pintar lo que se lee en el joystick1

pintaJoystick1

        lda joy1
        
        sta numeroBin
        jsr pintaBin

        lda #13
        jsr chrout

        rts

