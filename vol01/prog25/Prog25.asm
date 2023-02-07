; Programa para ejemplificar las interrupciones

; En este caso la rutina de interrupción del usuario no es completa, no
; sustituye a la del sistema, sino que la completementa con un trocito
; de código adicional

; Se observará cómo un carácter va cambiando en la esquina superior izquierda
; de la pantalla, según el sistema va haciendo parpadear el cursor

* = $c000 ; El programa se cargará en 49152

Prog25

        sei             ; Deshabilita las interrupciones temporalmente

        lda #<rutinaInt ; Configura el vector de interrupción; parte low
        sta $0314

        lda #>rutinaInt ; Configura el vector de interrupción; parte high
        sta $0315

        cli             ; Vuelve a habilitar las interrupciones

        rts             ; Vuelve a BASIC

; A partir de aquí, cada vez que haya una interrupción, se ejecutará
; nuestra rutina de interrupción (ver abajo) y luego la del sistema

cont    byte $00

rutinaInt

        inc cont        ; Incrementa el contador
        
        lda cont        ; Carga el contador

        sta $0400       ; Lo pinta en la esquina sup - izqda de la pantalla

        jmp $ea31       ; Continúa con la rutina habitual del sistema
                        ; Por tanto, no hay que recuperar registros ni
                        ; hacer rti...

        ; Este trocito de código se ejecuta antes de ejecutar la rutina
        ; habitual del sistema, que continúa en $ea31...
