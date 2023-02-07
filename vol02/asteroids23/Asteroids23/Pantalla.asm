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

        ; Pinta 3 asteroides (sprites)
        jsr pinta3Asteroides

        rts

; Pinta los puntos

pintaPuntos

        ; Pinta "puntos: "
        lda #<puntos
        sta cadenaLo3
        
        lda #>puntos
        sta cadenaHi3

        lda #<$0687
        sta posicionLo3
        
        lda #>$0687
        sta posicionHi3

        jsr pintaCadena3

        ; Pinta los puntos
;        lda jugadorPuntosHi
;        sta numeroHex2

;        lda #<$068f
;        sta posicionLo2
;        
;        lda #>$068f
;        sta posicionHi2

;        jsr pintaHex2

;        lda jugadorPuntosLo
;        sta numeroHex2

;        lda #<$0691
;        sta posicionLo2
;        
;        lda #>$0691
;        sta posicionHi2

;        jsr pintaHex2

        lda jugadorPuntosHi
        sta bitesHi

        lda jugadorPuntosLo
        sta biteslo

        jsr bitesToBCD ; Convierte los puntos a BCD

        lda bitesBCDHi
        sta numeroBCD

        lda #$8f
        sta posicionLo
        
        lda #$06
        sta posicionHi

        jsr pintaBCD

        lda bitesBCDLo
        sta numeroBCD

        lda #$91
        sta posicionLo
        
        lda #$06
        sta posicionHi

        jsr pintaBCD

        ; Pinta "maximo: "
        lda #<maxPuntos
        sta cadenaLo3
        
        lda #>maxPuntos
        sta cadenaHi3

        lda #<$0695
        sta posicionLo3
        
        lda #>$0695
        sta posicionHi3

        jsr pintaCadena3

        ; Pinta el máximo de puntos
;        lda jugadorMaxPuntosHi
;        sta numeroHex2

;        lda #<$069d
;        sta posicionLo2
;        
;        lda #>$069d
;        sta posicionHi2

;        jsr pintaHex2

;        lda jugadorMaxPuntosLo
;        sta numeroHex2

;        lda #<$069f
;        sta posicionLo2
;        
;        lda #>$069f
;        sta posicionHi2

;        jsr pintaHex2

        lda jugadorMaxPuntosHi
        sta bitesHi

        lda jugadorMaxPuntosLo
        sta biteslo

        jsr bitesToBCD ; Convierte el máximo de puntos a BCD

        lda bitesBCDHi
        sta numeroBCD

        lda #$9d
        sta posicionLo
        
        lda #$06
        sta posicionHi

        jsr pintaBCD

        lda bitesBCDLo
        sta numeroBCD

        lda #$9f
        sta posicionLo
        
        lda #$06
        sta posicionHi

        jsr pintaBCD

        rts

puntos          text 'puntos: '        
                byte $00

maxPuntos       text 'maximo: '
                byte $00

; Pinta 3 asteroides (sprites)

pinta3Asteroides
        
        ; Curiosidad, si alguno de los 3 asteroides / sprites toca alguna
        ; letra de la pantalla inicial / menu, enseguida detecta la colisión
        ; y el programa actúa como si se hubiera destruido el primer asteroide.
        ; Por ello se colocan sin tocar ninguna letra.

        ; Configuración del multicolor para todos los sprites
        lda #GrisOscuro
        sta cmMulticolor1

        lda #Amarillo
        sta cmMulticolor2

        jsr configuraMulticolor

        ; Asteroide 1

        ; Posición
        lda #$01
        sta psNumero

        lda #$30
        sta psCoordXLo

        lda #$00
        sta psCoordXHi

        lda #$30
        sta psCoordY

        jsr posicionaSprite

        ; Configuración básica del sprite
        lda #$01
        sta cbNumero
        
        lda #200 ; Bloque 200 de 64 bytes
        sta cbBloque
        
        lda #GrisClaro
        sta cbColor

        jsr configuraBasica

        ; Configuración avanzada
        lda #$01
        sta caNumero

        lda #$01
        sta caMulticolor

        lda #$01
        sta caExpansionH
        sta caExpansionV

        lda #$01 ; Tras ajustar los disparos ponemos el sprite por encima
        sta caPrioFondo

        jsr configuraAvanzada

        ; Asteroide 2 

        ; Posición
        lda #$02
        sta psNumero

        lda #$65
        sta psCoordXLo

        lda #$00
        sta psCoordXHi

        lda #$70
        sta psCoordY

        jsr posicionaSprite

        ; Configuración básica del sprite
        lda #$02
        sta cbNumero
        
        lda #200 ; Bloque 200 de 64 bytes
        sta cbBloque
        
        lda #GrisClaro
        sta cbColor

        jsr configuraBasica

        ; Configuración avanzada
        lda #$02
        sta caNumero

        lda #$01
        sta caMulticolor

        lda #$01
        sta caExpansionH
        sta caExpansionV

        lda #$01 ; Tras ajustar los disparos ponemos el sprite por encima
        sta caPrioFondo

        jsr configuraAvanzada

        ; Asteroide 3 

        ; Posición
        lda #$03
        sta psNumero

        lda #$20
        sta psCoordXLo

        lda #$01
        sta psCoordXHi

        lda #$a0
        sta psCoordY

        jsr posicionaSprite

        ; Configuración básica del sprite
        lda #$03
        sta cbNumero
        
        lda #200 ; Bloque 200 de 64 bytes
        sta cbBloque
        
        lda #GrisClaro
        sta cbColor

        jsr configuraBasica

        ; Configuración avanzada
        lda #$03
        sta caNumero

        lda #$01
        sta caMulticolor

        lda #$00
        sta caExpansionH
        sta caExpansionV

        lda #$01 ; Tras ajustar los disparos ponemos el sprite por encima
        sta caPrioFondo

        jsr configuraAvanzada

        rts

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
;        lda jugadorXHi
;        sta numeroHex2

;        lda #$c4
;        sta posicionLo2
;        
;        lda #$07
;        sta posicionHi2

;        jsr pintaHex2

;        lda jugadorXLo
;        sta numeroHex2

;        lda #$c6
;        sta posicionLo2
;        
;        lda #$07
;        sta posicionHi2

;        jsr pintaHex2

        lda jugadorXHi
        sta bitesHi

        lda jugadorXLo
        sta biteslo

        jsr bitesToBCD ; Convierte la X a BCD

        lda bitesBCDHi
        sta numeroBCD

        lda #$c4
        sta posicionLo
        
        lda #$07
        sta posicionHi

        jsr pintaBCD

        lda bitesBCDLo
        sta numeroBCD

        lda #$c6
        sta posicionLo
        
        lda #$07
        sta posicionHi

        jsr pintaBCD

        ; Pinta la coordenada Y
;        lda jugadorY
;        sta numeroHex2

;        lda #$cd
;        sta posicionLo2
;        
;        lda #$07
;        sta posicionHi2

;        jsr pintaHex2

        lda jugadorY
        sta bite

        jsr biteToBCD ; Convierte la Y a BCD

        lda biteBCDHi
        sta numeroBCD

        lda #$cb
        sta posicionLo
        
        lda #$07
        sta posicionHi

        jsr pintaBCD

        lda biteBCDLo
        sta numeroBCD

        lda #$cd
        sta posicionLo
        
        lda #$07
        sta posicionHi

        jsr pintaBCD

        ; Pinta la velocidad
        lda jugadorVelocidad
        sta numeroHex2

        lda #$d2
        sta posicionLo2
        
        lda #$07
        sta posicionHi2

        jsr pintaHex2

        ; Pinta el ángulo
        lda jugadorAngulo
        sta numeroHex2

        lda #$d7
        sta posicionLo2
        
        lda #$07
        sta posicionHi2

        jsr pintaHex2

        ; Pinta las vidas
        lda jugadorVidas
        sta numeroHex2

        lda #$dc
        sta posicionLo2
        
        lda #$07
        sta posicionHi2

        jsr pintaHex2

        ; Pinta los puntos
;        lda jugadorPuntosHi
;        sta numeroHex2

;        lda #$e1
;        sta posicionLo2
;        
;        lda #$07
;        sta posicionHi2

;        jsr pintaHex2

;        lda jugadorPuntosLo
;        sta numeroHex2

;        lda #$e3
;        sta posicionLo2
;        
;        lda #$07
;        sta posicionHi2

;        jsr pintaHex2

        lda jugadorPuntosHi
        sta bitesHi

        lda jugadorPuntosLo
        sta biteslo

        jsr bitesToBCD ; Convierte los puntos a BCD

        lda bitesBCDHi
        sta numeroBCD

        lda #$e1
        sta posicionLo
        
        lda #$07
        sta posicionHi

        jsr pintaBCD

        lda bitesBCDLo
        sta numeroBCD

        lda #$e3
        sta posicionLo
        
        lda #$07
        sta posicionHi

        jsr pintaBCD

        ; Pinta reloj $a0-$a1-$a2
;        lda $a1
;        sta numeroHex2

;        lda #$e3
;        sta posicionLo2
;        
;        lda #$07
;        sta posicionHi2

;        jsr pintaHex2

;        lda $a2
;        sta numeroHex2

;        lda #$e5
;        sta posicionLo2
;        
;        lda #$07
;        sta posicionHi2

;        jsr pintaHex2

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

