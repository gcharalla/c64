; Juego Asteroids

; Presentamos los números en decimal, no en hex.

; X = coordenada X (9 bits). Tenemos que seguir usando codificación binaria,
; porque los registros del VIC, y en particular, la coordenada X de los sprites
; esperan esta codificación. Habrá que pasar a BCD antes de pintar.

; Y = coordenada Y (8 bits). Idem coordenada X.

; V = velocidad. Oscila entre 0 y 3. En este rango de valores tan reducido, las
; codificaciones binaria y BCD coinciden. No hace falta hacer nada.

; A = ángulo. Oscila entre 0 y 7. Idem velocidad.

; N = número de vidas. Oscila entre 0 y 5. Idem velocidad y ángulo.

; P = puntos. Actualmente, sólo usa un byte. El máximo valor es 255. Como cada
; asteroide matado da 10 puntos, esto equivale a 25 asteroides. Se queda corto.
; Hay que meter otro byte (Lo y Hi). Además, habrá que pasar a BCD antes de
; pintar.

; Máximo de puntos. Idem puntos.

; T = tiempo. La codificación hexadecimal es más compacta que la decimal. Por
; ejemplo, el valor 255 ocupa 2 posiciones (ff) en formato hexadecimal, pero
; 3 posiciones (255) en decimal. Al pasar todo a decimal, necesitamos ahorrar
; espacio en pantalla, así que quitamos el tiempo.

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
        lda jugadorPuntosLo
        beq jpHi

        jsr pintaPuntos
        jmp menuBucle

jpHi

        lda jugadorPuntosHi
        beq menuBucle

        jsr pintaPuntos
        jmp menuBucle

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
        