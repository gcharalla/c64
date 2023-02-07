; Inicializa la pantalla de menu

inicializaPantallaMenu

        ; Todo negro
        lda #Negro
        sta colorBorde

        ;lda #Negro
        sta colorFondo0
        sta colorFondo1
        sta colorFondo2
        sta colorFondo3

        jsr configuraColores

        ; Color de los caracteres blanco
        lda #Blanco
        sta rcColor

        jsr rellenaColor        

        ; Copia la pantalla de menu
        lda #<pantallaMenuComienzo
        sta cbComienzoLo

        lda #>pantallaMenuComienzo
        sta cbComienzoHi

        lda #<pantallaMenuFin
        sta cbFinLo         

        lda #>pantallaMenuFin
        sta cbFinHi

        lda #<VICSCN
        sta cbDestinoLo     

        lda #>VICSCN
        sta cbDestinoHi     

        jsr copiaBloque

        rts

; Pinta los puntos

pintaPuntos

        ; Pinta "puntos: "
        lda #<puntos
        sta cadenaLo3
        
        lda #>puntos
        sta cadenaHi3

        lda #<$0688
        sta posicionLo3
        
        lda #>$0688
        sta posicionHi3

        jsr pintaCadena3

        ; Pinta los puntos
        lda jugadorPuntos
        sta numeroHex2

        lda #<$0690
        sta posicionLo2
        
        lda #>$0690
        sta posicionHi2

        jsr pintaHex2

        ; Pinta "maximo: "
        lda #<maxPuntos
        sta cadenaLo3
        
        lda #>maxPuntos
        sta cadenaHi3

        lda #<$0696
        sta posicionLo3
        
        lda #>$0696
        sta posicionHi3

        jsr pintaCadena3

        ; Pinta el máximo de puntos
        lda jugadorMaxPuntos
        sta numeroHex2

        lda #<$069e
        sta posicionLo2
        
        lda #>$069e
        sta posicionHi2

        jsr pintaHex2

        rts

puntos          text 'puntos: '        
                byte $00

maxPuntos       text 'maximo: '
                byte $00

; Inicializa la pantalla de juego

inicializaPantallaJuego

        ; Juego de caracteres personalizados
        lda #15
        sta acJuego

        jsr activaJuego

        ; Copia la pantalla de juego
        lda #<pantallaJuegoComienzo
        sta cbComienzoLo

        lda #>pantallaJuegoComienzo
        sta cbComienzoHi

        lda #<pantallaJuegoFin
        sta cbFinLo         

        lda #>pantallaJuegoFin
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

