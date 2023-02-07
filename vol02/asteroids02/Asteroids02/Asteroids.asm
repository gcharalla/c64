; Juego Asteroids

; Cambia el movimiento para que se base en ángulo + velocidad

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
        lda #Negro
        sta colorBorde
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


        