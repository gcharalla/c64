; Este programa es para ejemplificar los sistemas de numeración
; Se verá cómo un mismo número puede representarse en decimal, bin y hex

* = $c000 ; El programa se cargará en la dirección 49152

; Constantes
deci = 37
bina = %00100101
hexa = $25

pantalla = $0400

prog02
        lda #deci       ; carga el número decimal
        sta pantalla    ; lo pone en la primera posición de pantalla
        
        lda #bina       ; carga el número binario
        sta pantalla+1  ; lo pone en la segunda posición de pantalla

        lda #hexa       ; carga el número hexadecimal
        sta pantalla+2  ; lo pone en la tercera posición de pantalla
   
        rts             ; vuelve a BASIC

; Se verá que en la pantalla se ve el mismo carácter 3 veces (%%%)
; Esto es así porque los números 37, %00100101 y $25 son el mismo
; Sólo hemos cambiado su forma de representación
     