; Ejemplo de inclusión y reproducción de un fichero SID descargado de HVSC

* = $c000

Prog54

        ; Inicializa el fichero SID
        ; La dirección concreta depende del fichero SID descargado
        jsr $c980

        ; Configura la rutina de interrupción
        sei

        lda #<irq
        sta $0314
        lda #>irq
        sta $0315

        cli
        
        ; Vuelve a BASIC
        rts

; Rutina de interrupción

irq

        ; Reproduce el fichero SID
        ; La dirección concreta depende del fichero SID descargado
        jsr $ca52

        ; Continúa con la rutina de interrupción del sistema
        jmp $ea31

