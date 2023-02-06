; Programa para ejemplificar el funcionamiento de las bifurcaciones

* = $c000 ; El programa se cargará en 49152

Prog17
        jsr flagZ
        jsr flagC
        jsr flagV
        jsr flagN
        rts

