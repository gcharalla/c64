; Juego Asteroids

; Añadimos diferentes situaciones del juego: antes de empezar (menú), jugando y
; fin de juego (puntuaciones). La de antes de empezar (menú) y la de fin de
; juego pueden ser la misma si al menú le añadimos las puntuaciones.
;
; Además, dado que ahora puede haber N jugadas seguidas, no podemos confiar
; en la inicialización de las variables (byte) que se hace al cargarse el
; programa. Hay que hacer inicializaciones expresas de las variables.

; Por último, desactivamos todos los sprites al empezar para no heredar los
; sprites activos de una partida a la siguiente y añadimos una variable
; jugadorMaxPuntos que da la puntuación máxima de las sucesivas partidas.

; La puntuación máxima se podría grabar a fichero para conservar entre ejecu-
; ciones, pero no lo hacemos por simplicidad.

; Cargardor BASIC
; 10 SYS2064

*=$0801

        BYTE    $0B, $08, $0A, $00, $9E, $32, $30, $36, $34, $00, $00, $00

; Programa principal a partir de $0810 = 2064

*=$0810

menuInit

        ; Desactiva todos los sprites
        ; Necesario para no heredar los sprites activos de una partida
        ; a la siguiente
        lda #$00
        sta SPENA

        ; Inicializa la pantalla de menu
        jsr inicializaPantallaMenu

        ; Pinta puntuación y puntuación máxima
        ; Pero sólo si puntos > 0
        lda jugadorPuntos
        beq menuBucle

        jsr pintaPuntos

menuBucle

        ; Lee el joystick del puerto 2
        ;jsr leeJoystick2

        ;lda #Disparo
        ;bit joy2

        ; bne menuBucle
        
        ; Alternativa basada en el teclado
        jsr getin
        beq menuBucle

        cmp #32
        bne menuBucle

juegoInit

        ; Inicializa la pantalla de juego
        jsr inicializaPantallaJuego

        ; Inicializa el jugador
        jsr incializaJugador

        ; Inicializa los asteroides
        jsr inicializaAsteroides

juegoBucle

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

        jmp juegoBucle

        