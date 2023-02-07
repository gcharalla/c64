; Juego Asteroids

; Por último, el sonido. Tenemos 3 voces. Usaremos la voz 0 para los disparos,
; y la voz 1 para las colisiones / explosiones. La voz 2 se podría usar para
; música.

; Cargardor BASIC
; 10 SYS2064

*=$0801

        BYTE    $0B, $08, $0A, $00, $9E, $32, $30, $36, $34, $00, $00, $00

; Programa principal a partir de $0810 = 2064

*=$0810

menuInit

        ; Desactiva todos los sprites; necesario para no heredar los
        ; sprites activos de una partida anterior a la siguiente
        lda #$00
        sta SPENA

        ; Idem sonido
        jsr inicializaImagenSID
        jsr transfiereImagenSID

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

        ; Desactiva los sprites para empezar de cero
        lda #$00
        sta SPENA

juegoInit

        ; Inicializa la pantalla de juego
        jsr inicializaPantallaJuego

        ; Inicializa el jugador
        jsr incializaJugador

        ; Inicializa los asteroides
        jsr inicializaAsteroides

        ; Inicializa el sonido
        jsr inicializaSonido

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

        ; Actualiza el sonido
        jsr actualizaSonido

        jmp juegoBucle
        