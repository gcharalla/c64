; Programa para ejemplificar multiplicaciones y divisiones sencillas

* = $c000 ; El programa se cargará en 49152

; Constantes

valor = %00001000       ; 8 en decimal

Prog15

        lda #valor      ; Carga el valor en el acumulador
        jsr imprimeAcum ; Imprime el acumulador en binario

        asl a           ; Corre los bits 1 posición a la izq
                        ; Esto equivale a multiplicar por dos
                        ; Observar el modo de direcc. "acumulador"

        jsr imprimeAcum ; Imprime el acumulado en binario

        asl             ; El ensamblador también lo entiendo sin "a"

        jsr imprimeAcum

        lsr a           ; Corre los bits 1 posición a la dcha
                        ; Esto equivale a dividir por dos
                        ; Observar el modo de direcc. "acumulador"

        jsr imprimeAcum

        lsr             ; El ensamblador también lo entiende sin "a"

        jsr imprimeAcum

        rts


