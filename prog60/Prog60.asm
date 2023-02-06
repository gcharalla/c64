; Programa para ejemplificar la carga de ficheros

; 10 SYS49152

;*=$0801

;        BYTE    $0B, $08, $0A, $00, $9E, $34, $39, $31, $35, $32, $00, $00, $00

; El programa se cargará en 49152

*=$c000

Prog60

        ; Este es el programa que carga el fichero
        ; Utiliza la rutina load del Kernal

        ; Vamos a usar disco (8)
        lda #$01
        ldx #$08
        ldy #$01
        jsr SETLFS

        ; Nombre de fichero
        lda #$0a
        ldx #<nombreFichero
        ldy #>nombreFichero
        jsr SETNAM

        ; Carga del fichero/programa

        ; Vamos a hacer una carga, no una verificación
        lda #$00        

        ; Si no fuéramos a usar la dirección de la cabecera, sino que
        ; quisiéramos hacer la carga en otra dirección, cargaríamos 
        ; X e Y con esa dirección (X = LSB, Y = MSB)

        ; Carga
        clc
        jsr LOAD

        ; Conviene revisar los errores, que vienen en acarreo
        bcc fin

        ; Si C=1, pinta mensaje de error
        sta error
        jsr pintaError

fin

        ; Vuelve a BASIC
        rts

nombreFichero   text "miprograma" ; Longitud 10=$0a

; Rutina para pintar errores

cadenaError     byte 13
                text "error: "
                byte $00
error           byte $00

pintaError

        lda #<cadenaError
        sta cadenaLo

        lda #>cadenaError
        sta cadenaHi

        jsr pintaCadena

        lda error
        sta numeroHex

        jsr pintaHex

        rts
