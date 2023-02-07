; Programa para ver el contenido del registro de estado P

* = $c000 ; El programa se cargará a partir de 49152

prog06

        jsr imprimeTit  ; Imprime los nombres de los flags

        ; Registro P sin manipular

        php             ; Mete el registro de estado en la pila
        pla             ; Saca el registro de estado al acumulador

        jsr imprimeAcum ; Imprime el registro de estado

        ; Registro P con C y N activados

        lda #$ff        ; Carga el valor $ff
        clc             ; Borra acarreo
        adc #$ff        ; Suma $ff para provocar acarreo

        php             ; Mete el registro de estado en la pila
        pla             ; Saca el registro de estado al acumulador

        jsr imprimeAcum ; Imprime el registro de estado
        
        ; Registro P con Z activado

        lda #$00        ; Carga el valor 0 para activar Z

        php             ; Mete el registro de estado en la pila
        pla             ; Saca el registro de estado al acumulador

        jsr imprimeAcum ; Imprime el registro de estado

        ; Registro P con I activado

        sei             ; Desactiva interrupciones IRQ

        php             ; Mete el registro de estado en la pila
        pla             ; Saca el registro de estado al acumulador

        jsr imprimeAcum ; Imprime el registro de estado

        cli             ; Vuelve a activar interrupciones IRQ

        ; Registro P con D activado

        sed             ; Activa aritmética BCD

        php             ; Mete el registro de estado en la pila
        pla             ; Saca el registro de estado al acumulador

        cld             ; Vuelve a activar aritmética binaria

        jsr imprimeAcum ; Imprime el registro de estado

        ; Registro P con V y N activados

        lda #127        ; Carga el valor 127
        clv             ; Borra overflow
        adc #127        ; Suma 127 para provocar overflow

        php             ; Mete el registro de estado en la pila
        pla             ; Saca el registro de estado al acumulador

        jsr imprimeAcum ; Imprime el registro de estado
        
        rts
