; ----------------------------------------

gTempX  byte $00
gTempY  byte $00

gen

        stx gTempX
        sty gTempY

        ldx ply
        lda first_move,x

        inx
        sta first_move,x

        ldx #0

gAgain

        ldy side

        cpy #SIDE_MOUSE
        bne gCats

gMouse

        lda board,x
        cmp #PIECE_MOUSE
        bne gNext

        stx gmStart
        lda #DIR_SW
        sta gmDir
        jsr genMouse

        stx gmStart
        lda #DIR_SE
        sta gmDir
        jsr genMouse

        stx gmStart
        lda #DIR_NE
        sta gmDir
        jsr genMouse

        stx gmStart
        lda #DIR_NW
        sta gmDir
        jsr genMouse

gCats

        lda board,x
        cmp #PIECE_CAT1
        bcc gNext

        cmp #PIECE_EMPTY
        bcs gNext

        stx gcStart
        lda #DIR_SW
        sta gcDir
        jsr genCat

        stx gcStart
        lda #DIR_SE
        sta gcDir
        jsr genCat

gNext
        inx
        cpx #64
        bne gAgain
        
        ldx gTempX
        ldy gTempY

        rts

; ----------------------------------------

gmStart byte $00
gmDir   byte $00
gmDest  byte $00

gmTempY byte $00

genMouse

        sty gmTempY

        lda gmStart
        asl
        asl

        clc
        adc gmDir

        tay

        lda mouse_moves,y
        cmp #$ff
        beq gmEnd

        tay
        lda board,y

        cmp #PIECE_EMPTY
        bne gmEnd

        lda gmStart
        sta amStart

        sty amDest

        jsr addMove

gmEnd

        ldy gmTempY

        rts

; ----------------------------------------

gcStart byte $00
gcDir   byte $00
gcDest  byte $00

gcTempY byte $00

genCat

        sty gcTempY

        lda gcStart
        asl

        clc
        adc gcDir

        tay

        lda cat_moves,y
        cmp #$ff
        beq gcEnd

        tay
        lda board,y

        cmp #PIECE_EMPTY
        bne gcEnd

        lda gcStart
        sta amStart

        sty amDest

        jsr addMove

gcEnd

        ldy gcTempY

        rts

; ----------------------------------------

amStart byte $00
amDest  byte $00

amTempY byte $00

addMove

        sty amTempY

        ldy ply
        iny
        
        lda first_move,y
        tay

        lda amStart
        sta move_list_start,y

        lda amDest
        sta move_list_dest,y

        ldy ply
        iny

        lda first_move,y
        clc
        adc #1
        sta first_move,y

        ldy amTempY

        rts

; ----------------------------------------



