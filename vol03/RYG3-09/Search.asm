; ----------------------------------------

move_start      byte $00
move_dest       byte $00

start_time_hh   byte $00
start_time_mm   byte $00
start_time_ss   byte $00
start_time_dd   byte $00

stop_time_hh    byte $00
stop_time_mm    byte $00
stop_time_ss    byte $00
stop_time_dd    byte $00

; ----------------------------------------

thinkMax

        ; Time limit?

        lda #0
        sta ply
        sta nodes1
        sta nodes2
        sta nodes3
        sta nodes4

        jsr newPosition

        lda max_depth ; only max depth for the moment
        sta depth

        tay
        lda #$00
        sta alpha,y

        lda #$ff
        sta beta,y

        jsr search

        jsr displayIter

        rts

; ----------------------------------------

thinkIter

        ; Time limit?

        lda #0
        sta ply
        sta nodes1
        sta nodes2
        sta nodes3
        sta nodes4

        jsr newPosition

        ldx #0

thAgain

        txa
        clc
        adc #1
        sta depth

        tay
        lda #$00
        sta alpha,y

        lda #$ff
        sta beta,y

        jsr search

        jsr displayIter

        inx
        cpx max_depth
        bne thAgain        

        rts

; ----------------------------------------

displayIter

        lda depth
        sta dhHex
        jsr displayHex

        lda #":"
        jsr $ffd2

        lda nodes4
        sta dhHex
        jsr displayHex

        lda nodes3
        sta dhHex
        jsr displayHex

        lda nodes2
        sta dhHex
        jsr displayHex

        lda nodes1
        sta dhHex
        jsr displayHex

        lda #","
        jsr $ffd2

        ldy depth
        lda score,y
        sta dhHex
        jsr displayHex

        lda #13
        jsr $ffd2

        lda depth
        sta dpvDepth

        jsr displayPV

        lda #13
        jsr $ffd2

        rts

; ----------------------------------------

depth   byte $00
alpha   byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
beta    byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00

score   byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00

best_start      byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
                byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
best_dest       byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
                byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00

current_move    byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
                byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
last_move       byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
                byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00

search

        ldy depth
        bne schNotLeaf

schLeaf

        jsr eval

        lda ev
        sta score,y

        rts

schNotLeaf

        lda side
        cmp #SIDE_MOUSE
        bne schNotLeafCats

schNotLeafMouse

        jmp searchMouse
        rts

schNotLeafCats

        jmp searchCats
        rts

; ----------------------------------------

searchMouse

        jsr incNodes

        jsr initBest

        jsr gen

        ; Hash move? => + a lot

        ldy ply
        lda first_move,y

        ldy depth
        sta current_move,y

        ldy ply
        iny
        lda first_move,y

        ldy depth
        sta last_move,y

        lda current_move,y
        cmp last_move,y
        bne schMouseAgain

        jmp schLeaf

schMouseAgain

        ; Sort?

        ldy depth
        lda current_move,y
        tay

        lda move_list_start,y
        sta mmStart

        lda move_list_dest,y
        sta mmDest

        jsr makeMove

        ;jsr displayBoard
        
        ; ---------------

        ldy depth
        lda alpha,y
        dey
        sta alpha,y

        ldy depth
        lda beta,y
        dey
        sta beta,y

        ldy depth
        dey
        sty depth

        jsr search

        ldy depth
        iny
        sty depth

        ; ---------------

        jsr takeBack

schMouseScoreVsAlpha

        ldy depth
        dey
        lda score,y

        iny
        cmp alpha,y
        bcc schMouseAlphaVsBeta

schMouseUpdateAlpha

        sta alpha,y

        lda current_move,y
        tay
        lda move_list_start,y

        ldy depth
        sta best_start,y

        lda current_move,y
        tay
        lda move_list_dest,y

        ldy depth
        sta best_dest,y

schMouseAlphaVsBeta

        lda alpha,y
        cmp beta,y
        bcc schMouseNext

schMouseBetaCutoff

 lda #2
 sta $0400+999

        jmp schMouseEnd

schMouseNext

        ldy depth
        lda current_move,y
        clc
        adc #1
        sta current_move,y

        cmp last_move,y
        beq schMouseEnd
        jmp schMouseAgain

schMouseEnd

        ldy depth
        lda alpha,y
        sta score,y

        lda best_start,y
        sta admStart

        cmp #$ff
        beq schMouseNoBest

        lda best_dest,y
        sta admDest

        lda current_lock
        sta admLock

        jsr addHashPosMouse

schMouseNoBest

        rts

; ----------------------------------------

searchCats

        jsr incNodes

        jsr initBest

        jsr gen

        ; Hash move? => + a lot

        ldy ply
        lda first_move,y

        ldy depth
        sta current_move,y

        ldy ply
        iny
        lda first_move,y

        ldy depth
        sta last_move,y

        lda current_move,y
        cmp last_move,y
        bne schCatsAgain
        
        jmp schLeaf

schCatsAgain

        ; Sort?

        ldy depth
        lda current_move,y
        tay

        lda move_list_start,y
        sta mmStart

        lda move_list_dest,y
        sta mmDest

        jsr makeMove

        ;jsr displayBoard
        
        ; ---------------

        ldy depth
        lda alpha,y
        dey
        sta alpha,y

        ldy depth
        lda beta,y
        dey
        sta beta,y

        ldy depth
        dey
        sty depth

        jsr search

        ldy depth
        iny
        sty depth

        ; ---------------

        jsr takeBack

schCatsScoreVsBeta

        ldy depth
        dey
        lda score,y

        iny
        cmp beta,y
        beq schCatsUpdateBeta
        bcs schCatsBetaVsAlpha

schCatsUpdateBeta

        sta beta,y

        lda current_move,y
        tay
        lda move_list_start,y

        ldy depth
        sta best_start,y

        lda current_move,y
        tay
        lda move_list_dest,y

        ldy depth
        sta best_dest,y

schCatsBetaVsAlpha

        lda beta,y
        cmp alpha,y
        beq schCatsAlphaCutoff
        bcs schCatsNext

schCatsAlphaCutoff

 lda #1
 sta $0400+999

        jmp schCatsEnd

schCatsNext

        ldy depth
        lda current_move,y
        clc
        adc #1
        sta current_move,y

        cmp last_move,y
        beq schCatsEnd
        jmp schCatsAgain

schCatsEnd

        ldy depth
        lda beta,y
        sta score,y

        lda best_start,y
        sta adcStart

        cmp #$ff
        beq schCatsNoBest

        lda best_dest,y
        sta adcDest

        lda current_lock
        sta adcLock

        jsr addHashPosCats

schCatsNoBest

        rts

; ----------------------------------------

incNodes

        lda nodes1
        clc
        adc #1
        sta nodes1

        lda nodes2
        adc #0
        sta nodes2

        lda nodes3
        adc #0
        sta nodes3

        lda nodes4
        adc #0
        sta nodes4

        rts

; ----------------------------------------

initBest

        ldy depth
        lda #$ff
        sta best_start,y
        sta best_dest,y

        rts

; ----------------------------------------

dpvDepth        byte $00

dpvTempX        byte $00
dpvTempY        byte $00

displayPV

        stx dpvTempX
        sty dpvTempY

        ldy #$00

dpvAgain

        lda side
        cmp #SIDE_MOUSE
        bne dpvCats

dpvMouse

        jsr lookUpMouse
        jmp dpvPrintMake

dpvCats

        jsr lookUpCats

dpvPrintMake

        lda hash_start
        cmp #$ff
        beq dpvTakeBack

        lda hash_start
        sta algSq
        jsr algebraic
        
        lda hash_dest
        sta algSq
        jsr algebraic

        lda hash_start
        sta mmStart

        lda hash_dest
        sta mmDest

        jsr makeMove

dpvNext

        iny
        cpy dpvDepth
        bcs dpvTakeBack

        lda #","
        jsr $ffd2

        jmp dpvAgain

dpvTakeBack

        ldy ply
        beq dpvEnd

        jsr takeBack

        jmp dpvTakeBack

dpvEnd

        ldx dpvTempX
        ldy dpvTempY

        rts

; ----------------------------------------
