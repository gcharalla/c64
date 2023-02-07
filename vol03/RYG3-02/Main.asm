; ----------------------------------------

; MOVE GENERATION

; ----------------------------------------

; 10 SYS2080

*=$0801

        BYTE    $0B, $08, $0A, $00, $9E, $32, $30, $38, $30, $00, $00, $00

; ----------------------------------------

*=$0820

main

        jsr initBoard
        jsr displayBoard

        lda #SIDE_MOUSE
        sta side
        jsr gen
        jsr displayMoves

        lda #SIDE_CATS
        sta side
        jsr gen
        jsr displayMoves

        rts

; ----------------------------------------

