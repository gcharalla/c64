; ----------------------------------------

repeat 0, 63, index

history_index

                byte $00,$00,$00,$00,$00,$00,$00,$00
                byte $00,$00,$00,$00,$00,$00,$00,$00
                byte $00,$00,$00,$00,$00,$00,$00,$00
                byte $00,$00,$00,$00,$00,$00,$00,$00
                byte $00,$00,$00,$00,$00,$00,$00,$00
                byte $00,$00,$00,$00,$00,$00,$00,$00
                byte $00,$00,$00,$00,$00,$00,$00,$00
                byte $00,$00,$00,$00,$00,$00,$00,$00

endrepeat

; ----------------------------------------

histLo
repeat 0, 63, index
                byte <history_index
endrepeat

histHi
repeat 0, 63, index
                byte >history_index
endrepeat

; ----------------------------------------

ghTempY byte $00

ghStart byte $00
ghDest  byte $00

getHistory

        sty ghTempY

        ldy ghStart
        lda histLo,y
        sta $fb

        lda histHi,y
        sta $fc

        ldy ghDest
        lda ($fb),y

        ldy ghTempY

        rts

; ----------------------------------------

ihAdd   byte $00
ihStart byte $00
ihDest  byte $00

ihTempY byte $00

incHistory

        sty ihTempY

        ldy ihStart
        lda histLo,y
        sta $fb

        lda histHi,y
        sta $fc

        ldy ihDest
        lda ($fb),y

        clc
        adc ihAdd
        bcc ihNoMax

ihMax

        lda #$ff

ihNoMax

        sta ($fb),y

        ldy ihTempY

        rts

; ----------------------------------------        

nhTempX byte $00
nhTempY byte $00

newHistory

        stx nhTempX
        sty nhTempY

        ldx #0

nhAgain1

        lda histLo,x
        sta $fb

        lda histHi,x
        sta $fc

        ldy #0
        lda #0

nhAgain2

        sta ($fb),y

nhNext

        iny
        cpy #64
        bne nhAgain2

        inx
        ;inx
        cpx #64
        bne nhAgain1

nhEnd

        ldx nhTempX
        ldy nhTempY

        rts

; ----------------------------------------        
