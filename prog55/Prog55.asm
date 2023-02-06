; Programa para ejemplificar el uso del CIA1 para leer el teclado

; 10 SYS49152

*=$0801

        BYTE    $0B, $08, $0A, $00, $9E, $34, $39, $31, $35, $32, $00, $00, $00

; El programa se cargará en 49152

* = $c000

Prog54

        ; Configuración del CIA1
        jsr leeTecladoIOConf

bucle

        ; Lee teclado
        jsr leeTecladoIO
        
        ; Imprime las coordenadas X,Y de la tecla pulsada
        jsr imprimeCoordenadas

        ; Imprime el carácter Petscii correspondiente a X,Y
        jsr imprimePetscii

        ; Vuelta a empezar
        jmp bucle

imprimeCoordenadas

        ; Imprime la coordenada X de la tecla pulsada
        lda #<cadenaX
        sta cadenaLo
        lda #>cadenaX
        sta cadenaHi
        jsr pintaCadena

        lda coordX
        sta numeroHex
        jsr pintaHex

        lda #44 ; coma
        jsr chrout

        ; Imprime la coordenada Yde la tecla pulsada
        lda #<cadenaY
        sta cadenaLo
        lda #>cadenaY
        sta cadenaHi
        jsr pintaCadena

        lda coordY
        sta numeroHex
        jsr pintaHex

        lda #44 ; coma
        jsr chrout

        rts

cadenaX text "x:"
        byte 0

cadenaY text "y:"
        byte 0

imprimePetscii

        lda coordX
        sta coordX2

        lda coordY
        sta coordY2

        jsr xy2Petscii

        lda petscii
        jsr chrout

        lda #13 ; retorno de carro
        jsr chrout

        rts
