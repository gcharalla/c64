; Juego Asteroids

; Al poner en marcha las colisiones del jugador, se observa que hay colisiones
; en la esquina superior izquierda. Esto es así porque todos los sprites de los
; asteroides están activos, aunque algunos estén fuera de pantalla.

; Por ello, vamos a modificar la inicialización de los asteroides
; para sólo activar los sprites de los asteroides que están activos para la 
; aplicación, es decir, en pantalla y moviéndose.

; No sólo hay que modificar la inicialización (para hacer menos cosas). Además,
; también hay que modificar la activación de asteroides adicionales, para hacer
; en ese momento todo lo que dejamos de hacer en la inicialización.

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

        