; ----------------------------------------

displayBoard

        jsr displayLetters

        lda #56
        sta drSq
        jsr displayRow

        lda #48
        sta drSq
        jsr displayRow

        lda #40
        sta drSq
        jsr displayRow

        lda #32
        sta drSq
        jsr displayRow

        lda #24
        sta drSq
        jsr displayRow

        lda #16
        sta drSq
        jsr displayRow

        lda #8
        sta drSq
        jsr displayRow

        lda #0
        sta drSq
        jsr displayRow

        jsr displayLetters

        jsr displayOther

        lda #13
        jsr $ffd2

        rts

; ----------------------------------------

letters text "  abcdefgh"
        byte 13,0

displayLetters

        lda #<letters
        sta dtTextLo

        lda #>letters
        sta dtTextHi

        jsr displayText

        rts

; ----------------------------------------

drSq    byte $00

drTempX byte $00
drTempY byte $00

displayRow

        stx drTempX
        sty drTempY

drRow1

        ldx drSq
        lda row,x
        clc
        adc #49
        jsr $ffd2

        lda #" "
        jsr $ffd2

        ldy #0

drAgain

        stx dsSq
        jsr displaySq

        iny
        inx
        cpy #8
        bne drAgain

drRow2

        lda #" "
        jsr $ffd2

        ldx drSq
        lda row,x
        clc
        adc #49
        jsr $ffd2

        lda #13
        jsr $ffd2

        ldx drTempX
        ldy drTempY

        rts

; ----------------------------------------

dsSq    byte $00

dsTempX byte $00

displaySq

        stx dsTempX

        ldx dsSq
        lda board,x

dsMouse

        cmp #PIECE_MOUSE
        bne dsCat1
  
        lda #"m"
        jsr $ffd2

        jmp dsEnd

dsCat1

        cmp #PIECE_CAT1
        bne dsCat2
  
        lda #"c"
        jsr $ffd2

        jmp dsEnd

dsCat2

        cmp #PIECE_CAT2
        bne dsCat3
  
        lda #"c"
        jsr $ffd2

        jmp dsEnd

dsCat3

        cmp #PIECE_CAT3
        bne dsCat4
  
        lda #"c"
        jsr $ffd2

        jmp dsEnd

dsCat4

        cmp #PIECE_CAT4
        bne dsEmpty
  
        lda #"c"
        jsr $ffd2

        jmp dsEnd

dsEmpty

        cmp #PIECE_EMPTY
        bne dsEnd
  
        lda row,x
        clc
        adc col,x
        ror
        bcc dsEven

dsOdd

        lda #"."
        jsr $ffd2

        jmp dsEnd

dsEven

        lda #"x"
        jsr $ffd2

dsEnd

        ldx dsTempX

        rts

; ----------------------------------------

displayOther

        lda #"s"
        jsr $ffd2
        lda #":"
        jsr $ffd2

        lda side
        cmp #SIDE_MOUSE
        bne doCats

doMouse

        lda #"m"
        jsr $ffd2
        lda #","
        jsr $ffd2
        jmp doPly

doCats

        lda #"c"
        jsr $ffd2
        lda #","
        jsr $ffd2

doPly

        lda #"p"
        jsr $ffd2
        lda #":"
        jsr $ffd2
        lda ply
        sta dhHex
        jsr displayHex
        lda #","
        jsr $ffd2

doHply

        lda #"h"
        jsr $ffd2
        lda #":"
        jsr $ffd2
        lda hply
        sta dhHex
        jsr displayHex
;        lda #","
;        jsr $ffd2

;doHash

;        lda #"#"
;        jsr $ffd2
;        lda #":"
;        jsr $ffd2
;        lda current_hash
;        sta dhHex
;        jsr displayHex
;        lda #","
;        jsr $ffd2

;doEval

;        lda #"e"
;        jsr $ffd2
;        lda #":"
;        jsr $ffd2
;        jsr eval
;        lda ev
;        sta dhHex
;        jsr displayHex
        
doReturn
        
        lda #13
        jsr $ffd2

        rts

; ----------------------------------------

dhHex   byte $00

displayHex

        lda dhHex

        lsr a
        lsr a
        lsr a            
        lsr a

        jsr hexcii

        jsr $ffd2

        lda dhHex

        and #%00001111

        jsr hexcii

        jsr $ffd2

        rts

; ----------------------------------------

hexcii

        cmp #$0a

        bcc hexNumber

hexLetter

        adc #$06

hexNumber

        adc #$30

        rts

; ----------------------------------------

dtTextLo        byte $00
dtTextHi        byte $00

displayText

        lda dtTextLo
        sta $fb

        lda dtTextHi
        sta $fc

        ldy #$00

dtAgain

        lda ($fb),y
        beq dtEnd

        jsr $ffd2

        iny
        jmp dtAgain

dtEnd

        rts

; ----------------------------------------

first   byte $00
last    byte $00

displayMoves

        ldx #$00
        lda first_move,x
        sta first

        ldx #$01
        lda first_move,x
        sta last

        ldx first

dmAgain

        lda move_list_start,x
        sta algSq
        jsr algebraic

        lda move_list_dest,x
        sta algSq
        jsr algebraic

        inx
        cpx last
        beq dmEnd

        lda #","
        jsr $ffd2

        jmp dmAgain

dmEnd

        lda #13
        jsr $ffd2

        rts

; ----------------------------------------
