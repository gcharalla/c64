; Juego Asteroids

; Eliminamos las zonas no visibles de la pantalla
; Por izquierda: 1 todavía se ve, 0 ya no                                
; Por derecha: 255 todavía se ve
; Por arriba: 30 todavía se ve, 29 ya no ===> sobre todo estos 30 pixels
; Por abajo: 249 todavía se ve, 250 ya no ===> y estos 5 pixels

; Cargardor BASIC
; 10 SYS2064

*=$0801

        BYTE    $0B, $08, $0A, $00, $9E, $32, $30, $36, $34, $00, $00, $00

; Programa principal a partir de $0810 = 2064

*=$0810

Asteroids

        ; Inicializa la pantalla
        jsr inicializaPantalla

        ; Inicializa el jugador
        jsr incializaJugador

bucle

        ; Espera a que el raster esté fuera de pantalla
        lda #255
        sta retRaster

        jsr meteRetardoRaster

        ; Lee el joystick del puerto 2
        jsr leeJoystick2

        ; Actualiza el jugador
        jsr actualizaJugador



        jmp bucle

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

        ; Pantalla vacía (llena de espacios)
        lda #' '        
        sta rpCaracter

        jsr rellenaPantalla

        ; Color de los caracteres blanco
        lda #Blanco
        sta rcColor

        jsr rellenaColor        
        
        rts


        