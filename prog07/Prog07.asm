; Programa para ejemplificar los modos de direccionamiento
; inmediato y absoluto

* = $c000 ; El programa se cargará en la posición 49152

pantalla = $0400

prog07
        lda #$00        ; modo inmediato; se carga el valor $00 en A
        sta pantalla    ; imprime A ($00) en pantalla

        lda $00         ; modo absoluto; en realidad página cero
                        ; carga el valor almacenado en la dir $00
                        ; en el acumulador
        sta pantalla+1  ; imprime A (valor de la pos. $00) en pantalla
        
                        ; como se podrá observar, no es lo mismo
                        ; pintar el valor $00 que el contenido de la
                        ; posición $00

        rts             ; vuelve a BASIC

