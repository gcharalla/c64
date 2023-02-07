; Programa para ejemplificar el uso de tsx y verificar el funcionamiento
; de la pila

* = $c000

Prog24

        ; El puntero de la pila en teoría empieza apuntando a $ff
        ; Pero cuando se ejecuta BASIC empieza en $f6
        tsx
        txa
        jsr imprimeAcum

        ; Ahora llamamos a una rutina
        ; Por tanto, el puntero debería caer en 2 posiciones: $f4
        jsr rutina1

        ; Volvemos a estar en $f6
        tsx
        txa
        jsr imprimeAcum

        ; Ahora llamamos a una rutina que llama a otra rutina
        ; Por tanto, el puntero debería caer en 4 posiciones: $f2
        jsr rutina2

        ; Volvemos a estar en $f6
        tsx
        txa
        jsr imprimeAcum

        ; Ahora llamamos a una rutina que llama a otra rutina que llama a otra
        ; Por tanto, el puntero debería caer en 6 posiciones: $f0
        jsr rutina3

        ; Volvemos a estar en $f6
        tsx
        txa
        jsr imprimeAcum

        rts

rutina1

        tsx
        txa
        jsr imprimeAcum

        rts

rutina2

        jsr rutina1
        rts

rutina3

        jsr rutina2
        rts
