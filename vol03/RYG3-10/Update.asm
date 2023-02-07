; ----------------------------------------

upPiece         byte $00
upStart         byte $00
upDest          byte $00

upTempX         byte $00

updatePiece

        stx upTempX

        lda upPiece
        sta uhPiece

        lda upStart
        sta uhSquare

        jsr updateHash

        lda upPiece
        sta uhPiece

        lda upDest
        sta uhSquare

        jsr updateHash

        ldx upDest
        lda upPiece
        sta board,x

        ldx upStart
        lda #PIECE_EMPTY
        sta board,x

        ldx upTempX

        rts

; ----------------------------------------

apPiece         byte $00
apSquare        byte $00

apTempX         byte $00

addPiece

        stx apTempX

        lda apPiece
        sta uhPiece

        lda apSquare
        lda uhSquare

        jsr updateHash

        ldx apSquare
        lda apPiece
        sta board,x

        ldx apTempX

        rts

; ----------------------------------------

mmStart         byte $00
mmDest          byte $00

mmTempX         byte $00

makeMove

        stx mmTempX

        ldx hply
        lda mmStart
        sta game_list_start,x

        lda mmDest
        sta game_list_dest,x

        inc ply
        inc hply

        ldx mmStart
        lda board,x
        sta upPiece

        lda mmStart
        sta upStart

        lda mmDest
        sta upDest

        jsr updatePiece

        lda side
        eor #%00000001
        sta side

        ldx mmTempX

        rts

; ----------------------------------------

tbTempX byte $00
        
takeBack

        stx tbTempX

        lda side
        eor #%00000001
        sta side

        dec ply
        dec hply

        ldx hply
        lda game_list_start,x
        sta upDest

        lda game_list_dest,x
        sta upStart

        tax
        lda board,x
        sta upPiece

        jsr updatePiece

        ldx tbTempX

        rts

; ----------------------------------------
