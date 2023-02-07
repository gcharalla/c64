; Programa para ejemplificar el uso de asl y lsr

* = $c000 ; El programa se cargara en 49152

Prog18

        jsr leeAcum     ; Lee un byte del teclado
        jsr imprimeAcum ; Lo imprime por pantalla

        jmp Prog18      ; Continúa sin fin...

        