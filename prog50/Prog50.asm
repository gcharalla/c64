; Programa para ejemplificar el uso de filtros con el SID

; 10 SYS49152

;*=$0801

;        BYTE    $0B, $08, $0A, $00, $9E, $34, $39, $31, $35, $32, $00, $00, $00

; El programa se cargará en 49152

* = $c000

Prog50

        ; Configura frecuencia, volumen, onda y ADSR
        jsr configuraVoz

        ; Activa la voz 1
        jsr activaVoz
        jsr transfiereImagenSID

        ; Pinta una cadena de texto
        lda #<cadena1
        sta cadenaLo
        lda #>cadena1
        sta cadenaHi
        jsr pintaCadena

        ; Espera una tecla mientras suena la voz 1 (todavía sin filtro)
tecla1

        jsr getin
        beq tecla1

        ; Configura un filtro paso bajo y enruta por él la voz 1

        ; Como el filtro es paso bajo y la frecuencia de corte es menor
        ; que la frecuencia de la voz, la voz debe dejar de oirse

        lda #PasoBajo
        sta tipoFiltro
        lda #$00
        sta frecCorteLo
        lda #$10
        sta frecCorteHi
        jsr configuraFiltro

        jsr transfiereImagenSID

        ; Pinta una cadena de texto
        lda #<cadena2
        sta cadenaLo
        lda #>cadena2
        sta cadenaHi
        jsr pintaCadena

        ; Espera una tecla mientras "suena" la voz 1 (ya con filtro)
        ; Por eso la voz 1 debe dejar de oirse
tecla2

        jsr getin
        beq tecla2

        ; Desactiva la voz 1
        jsr desactivaVoz
        jsr transfiereImagenSID

        rts

configuraVoz

        ; Inicializa el SID
        jsr inicializaImagenSID
        jsr transfiereImagenSID

        ; Fija la frecuencia
        lda #$1e
        sta freclo
        lda #$86
        sta frechi
        jsr fijaFrecuencia

        ; Fija el volumen
        lda #$01
        sta volumen
        jsr fijaVolumen

        ; Fija la forma de onda
        lda #Triangular
        sta formaOnda
        jsr fijaFormaOnda

        ; Fija la envolvemente ADSR
        lda #$03
        sta attack
        lda #$01
        sta decay
        lda #$0b
        sta sustain
        lda #$01
        sta release
        jsr fijaADSR

        rts

cadena1 text "voz 1 sin filtro. pulsa una tecla..."
        byte 13,00

cadena2 text "voz 1 con filtro. pulsa una tecla..."
        byte 13,00
