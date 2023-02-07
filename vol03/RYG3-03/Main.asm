; ----------------------------------------

; HASH GENERATION

; ----------------------------------------

; 10 SYS2080

*=$0801

        BYTE    $0B, $08, $0A, $00, $9E, $32, $30, $38, $30, $00, $00, $00

; ----------------------------------------

*=$0820

main

        jsr initBoard
        jsr displayBoard

        jsr testRandomizeHashes
        
        jsr testAddHashAndLookUp

        jsr testHashPositions

        rts

; ----------------------------------------

testRandomizeHashes

        jsr displayHashMouse
        jsr displayHashCat1
        jsr displayHashCat2
        jsr displayHashCat3
        jsr displayHashCat4

        jsr randomize

        jsr displayHashMouse
        jsr displayHashCat1
        jsr displayHashCat2
        jsr displayHashCat3
        jsr displayHashCat4

        rts

; ----------------------------------------

testAddHashAndLookUp

        jsr lookUpMouse
        lda hash_start
        sta dhHex
        jsr displayHex
        lda hash_dest
        sta dhHex
        jsr displayHex

        lda #4
        sta admStart
        lda #13
        sta admDest
        jsr addHashPosMouse

        lda #13
        jsr $ffd2

        jsr lookUpMouse
        lda hash_start
        sta dhHex
        jsr displayHex
        lda hash_dest
        sta dhHex
        jsr displayHex

        lda #13
        jsr $ffd2

        rts

; ----------------------------------------

testHashPositions

        jsr displayHashPosMouse
        jsr displayHashPosCats

        rts

