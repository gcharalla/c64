; Juego Asteroids

; Una vez individualizada la detección de las colisiones para los asteroides,
; el siguiente paso es hacer la animación de la explosión.

; Falta también resolver el asunto del texto de la derecha.

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

        ; Inicializa los asteroides
        jsr inicializaAsteroides

bucle

        ; Espera a que el raster esté fuera de pantalla
        lda #255
        sta retRaster

        jsr meteRetardoRaster

        ; Lee el joystick del puerto 2
        jsr leeJoystick2

        ; Actualiza el jugador
        jsr actualizaJugador

        ; Actualiza la pantalla
        jsr actualizaPantalla

        ; Actualiza los disparos
        jsr actualizaDisparos

        ; Actualiza los asteroides
        jsr actualizaAsteroides

        jmp bucle

        