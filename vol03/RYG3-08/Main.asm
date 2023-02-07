; ----------------------------------------

; SEARCH AND THINK WITH ITERATIVE DEEPENING

; ----------------------------------------

; 10 SYS2080

*=$0801

        BYTE    $0B, $08, $0A, $00, $9E, $32, $30, $38, $30, $00, $00, $00

; ----------------------------------------

*=$0820

        jmp main

; ----------------------------------------

max_time        byte $00 ; in minutes
max_depth       byte $00

; ----------------------------------------

main

        jsr setup

        jsr displayBoard

        jsr thinkIter

        ;jsr displayHashPosMouse
        ;jsr displayHashPosCats

        rts

; ----------------------------------------

setup

        jsr randomize
        jsr initBoard
        jsr gen

        lda #5
        sta max_time

        lda #8
        sta max_depth

        rts

; ----------------------------------------
