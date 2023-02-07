* = $c000 ; dirección de memoria donde se cargará el programa

pantalla = $0400 ; dirección de inicio de la RAM de pantalla

prog01
        ldx #$00        ; el registro X hace de índice
bucle   lda cadena,x    ; carga el carácter X-esimo en el acumulador
        beq fin         ; si es 0, salta al final
        sta pantalla,x  ; si no es 0, pinta el carácter en pantalla
        inx             ; incrementa el índice X
        jmp bucle       ; vuelve al comienzo del bucle
fin     rts             ; termina el programa, volviendo a BASIC

; cadena de texto a imprimir en pantalla
; consta de dos líneas y termina con el carácter cero

cadena  text '   PROGRAMACION RETRO DEL COMMODORE 64  '
        text '   ***********************************  '
        byte 0
       