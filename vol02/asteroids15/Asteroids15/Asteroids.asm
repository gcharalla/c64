; Juego Asteroids

; La solución para detectar las colisiones sprite - texto (asteroides vs
; disparos) adolece de dos problemas:
;
; 1- No sólo hay que incrementar los puntos. También hay que hacer la animación
; de la explosión. Por ello, habrá que hacer detección individualizada para
; cada sprite / asteroide.
; 2- Cuando los sprites / asteroides colisionan con el texto de la derecha lo
; considera igual que si un disparo alcanza un asteroide. Esto se podría solu-
; cionar limitando la X que alcanzan los asteroides, pero también se puede
; solucionar usando la pantalla completa y poniendo la información en la línea
; de abajo.
;
; En este ejemplo, abordamos el primer problema (individualización).

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

        