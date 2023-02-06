; Programa para hacer un uso básico del SID: volumen, frecuencia y activar nota

; 10 SYS49152

;*=$0801

;        BYTE    $0B, $08, $0A, $00, $9E, $34, $39, $31, $35, $32, $00, $00, $00

; El programa se cargará en 49152

* = $c000

Prog48

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
        lda #$0f
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

        ; Activa la voz 1
        jsr activaVoz
        jsr transfiereImagenSID

        ; Espera un tiempo
        lda #$ff
        sta retardolo
        sta retardohi
        jsr meteRetardo

        ; Desactiva la voz 1
        jsr desactivaVoz
        jsr transfiereImagenSID

        rts

