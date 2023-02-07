; Inicializa la pantalla

inicializaPantalla

        ; Todo negro
        lda #Negro
        sta colorBorde
        sta colorFondo0
        sta colorFondo1
        sta colorFondo2
        sta colorFondo3

        jsr configuraColores

        ; Color de los caracteres blanco
        lda #Blanco
        sta rcColor

        jsr rellenaColor        

        ; Copia la pantalla
        lda #<pantallaComienzo
        sta cbComienzoLo

        lda #>pantallaComienzo
        sta cbComienzoHi

        lda #<pantallaFin
        sta cbFinLo         

        lda #>pantallaFin
        sta cbFinHi

        lda #<VICSCN
        sta cbDestinoLo     

        lda #>VICSCN
        sta cbDestinoHi     

        jsr copiaBloque

        rts

; Actualiza la pantalla

actualizaPantalla

        ; Pinta la coordenada X
        lda jugadorX
        sta numeroHex2

        lda #$c3
        sta posicionLo2
        
        lda #$04
        sta posicionHi2

        jsr pintaHex2

        ; Pinta la coordenada Y
        lda jugadorY
        sta numeroHex2

        lda #$3b
        sta posicionLo2
        
        lda #$05
        sta posicionHi2

        jsr pintaHex2

        ; Pinta la velocidad
        lda jugadorVelocidad
        sta numeroHex2

        lda #$b3
        sta posicionLo2
        
        lda #$05
        sta posicionHi2

        jsr pintaHex2

        ; Pinta el ángulo
        lda jugadorAngulo
        sta numeroHex2

        lda #$2b
        sta posicionLo2
        
        lda #$06
        sta posicionHi2

        jsr pintaHex2

        rts

