; ----------------------------------------

evMouse byte $00
evCats  byte $00
ev      byte $00

evTempX byte $00

eval

        stx evTempX

        lda #0
        sta evMouse
        sta evCats
        sta ev

        ldx #0

evAgain

        lda board,x

evMouse2

        cmp #PIECE_MOUSE
        bne evCat1

        lda evMouse
        clc
        adc mouse_scores,x
        sta evMouse

        jmp evNext
        
evCat1

        cmp #PIECE_CAT1
        bne evCat2

        lda evCats
        clc
        adc cat1_scores,x
        sta evCats

        jmp evNext

evCat2

        cmp #PIECE_CAT2
        bne evCat3

        lda evCats
        clc
        adc cat2_scores,x
        sta evCats

        jmp evNext

evCat3

        cmp #PIECE_CAT3
        bne evCat4

        lda evCats
        clc
        adc cat3_scores,x
        sta evCats

        jmp evNext

evCat4

        cmp #PIECE_CAT4
        bne evNext

        lda evCats
        clc
        adc cat4_scores,x
        sta evCats

evNext

        inx
        cpx #64
        bne evAgain

evEnd

        lda ev
        clc
        adc #$80

        clc
        adc evMouse

        sec
        sbc evCats

        sta ev
        ldx evTempX

        rts

; ----------------------------------------