; Progama para ejemplificar la resta monobyte con sbc

* = $c000 ; El programa se cargará en 49152

Prog13       
        ; Realiza la resta minuendo - sustraendo

        sec             ; Activa el acarreo
        lda min         ; Carga el minuendo
        sbc sus         ; Resta el sustraendo
        sta res         ; Guarda la resta
        
        bcc cDesact

cAct
        lda #"c"
        jsr chrout
        lda #"="
        jsr chrout
        lda #"1"        ; Imprime C=1
        jsr chrout
        lda #13
        jsr chrout
        jmp fin

cDesact

        lda #"c"
        jsr chrout
        lda #"="
        jsr chrout
        lda #"0"        ; Imprime C=0
        jsr chrout
        lda #13
        jsr chrout
        
fin

        jsr imprimeMem  ; Imprime la resta

        rts             ; Vuelve a BASIC

; Variables

min     byte $f0 ; Probar a cambiar sus valores
sus     byte $ff ; Probar a cambiar sus valores

res     byte $00
