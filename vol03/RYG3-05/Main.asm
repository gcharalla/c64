; ----------------------------------------

; UPDATE AND NEW POSITION

; ----------------------------------------

; 10 SYS2080

*=$0801

        BYTE    $0B, $08, $0A, $00, $9E, $32, $30, $38, $30, $00, $00, $00

; ----------------------------------------

*=$0820

main

        jsr initBoard
        jsr fixedHash;randomize
        jsr newPosition
        jsr displayBoard

        jsr newPosition
        lda #4
        sta mmStart
        lda #13
        sta mmDest
        jsr makeMove
        jsr displayBoard

        jsr takeBack
        jsr displayBoard

        rts

; ----------------------------------------
