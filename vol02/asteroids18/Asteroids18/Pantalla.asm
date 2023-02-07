; Inicializa la pantalla

inicializaPantalla

        ; Todo negro
        lda #Blanco
        sta colorBorde

        lda #Negro
        sta colorFondo0
        sta colorFondo1
        sta colorFondo2
        sta colorFondo3

        jsr configuraColores

        ; Juego de caracteres personalizados
        lda #15
        sta acJuego

        jsr activaJuego

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
        lda jugadorXHi
        sta numeroHex2

        lda #$c3
        sta posicionLo2
        
        lda #$07
        sta posicionHi2

        jsr pintaHex2

        lda jugadorXLo
        sta numeroHex2

        lda #$c5
        sta posicionLo2
        
        lda #$07
        sta posicionHi2

        jsr pintaHex2

        ; Pinta la coordenada Y
        lda jugadorY
        sta numeroHex2

        lda #$ca
        sta posicionLo2
        
        lda #$07
        sta posicionHi2

        jsr pintaHex2

        ; Pinta la velocidad
        lda jugadorVelocidad
        sta numeroHex2

        lda #$cf
        sta posicionLo2
        
        lda #$07
        sta posicionHi2

        jsr pintaHex2

        ; Pinta el ángulo
        lda jugadorAngulo
        sta numeroHex2

        lda #$d4
        sta posicionLo2
        
        lda #$07
        sta posicionHi2

        jsr pintaHex2

        ; Pinta las vidas
        lda jugadorVidas
        sta numeroHex2

        lda #$d9
        sta posicionLo2
        
        lda #$07
        sta posicionHi2

        jsr pintaHex2

        ; Pinta los puntos
        lda jugadorPuntos
        sta numeroHex2

        lda #$de
        sta posicionLo2
        
        lda #$07
        sta posicionHi2

        jsr pintaHex2

        ; Pinta reloj $a0-$a1-$a2
        lda $a1
        sta numeroHex2

        lda #$e3
        sta posicionLo2
        
        lda #$07
        sta posicionHi2

        jsr pintaHex2

        lda $a2
        sta numeroHex2

        lda #$e5
        sta posicionLo2
        
        lda #$07
        sta posicionHi2

        jsr pintaHex2

        rts

; Pinta un carácter en charX,charY

charX3  byte $00
charY3  byte $00
char    byte $00

pintaCaracter

        lda charX3
        sta charX2

        lda charY3
        sta charY2

        jsr char2Mem

        lda memLo
        sta $fb

        lda memHi   
        sta $fc

        ldy #$00
        lda char

        sta ($fb),y

        rts