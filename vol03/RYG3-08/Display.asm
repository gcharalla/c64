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
        lda #" "
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
        lda #13
        jsr $ffd2

doHash

        lda #"#"
        jsr $ffd2
        lda #":"
        jsr $ffd2
        lda current_hash
        sta dhHex
        jsr displayHex
        lda #","
        jsr $ffd2

doLock

        lda #"l"
        jsr $ffd2
        lda #":"
        jsr $ffd2
        lda current_lock
        sta dhHex
        jsr displayHex
        lda #","
        jsr $ffd2

doEval

        lda #"e"
        jsr $ffd2
        lda #":"
        jsr $ffd2
        jsr eval
        lda ev
        sta dhHex
        jsr displayHex
        
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

displayHashMouse

        ldx #0

dhmAgain

        lda hash_mouse,x
        sta dhHex
        jsr displayHex

        lda #","
        jsr $ffd2

        inx
        cpx #64
        bne dhmAgain

        lda #13
        jsr $ffd2

        rts

; ----------------------------------------

displayHashCat1

        ldx #0

dhc1Again

        lda hash_cat1,x
        sta dhHex
        jsr displayHex

        lda #","
        jsr $ffd2

        inx
        cpx #64
        bne dhc1Again

        lda #13
        jsr $ffd2

        rts

; ----------------------------------------

displayHashCat2

        ldx #0

dhc2Again

        lda hash_cat2,x
        sta dhHex
        jsr displayHex

        lda #","
        jsr $ffd2

        inx
        cpx #64
        bne dhc2Again

        lda #13
        jsr $ffd2

        rts

; ----------------------------------------

displayHashCat3

        ldx #0

dhc3Again

        lda hash_cat3,x
        sta dhHex
        jsr displayHex

        lda #","
        jsr $ffd2

        inx
        cpx #64
        bne dhc3Again

        lda #13
        jsr $ffd2

        rts

; ----------------------------------------

displayHashCat4

        ldx #0

dhc4Again

        lda hash_cat4,x
        sta dhHex
        jsr displayHex

        lda #","
        jsr $ffd2

        inx
        cpx #64
        bne dhc4Again

        lda #13
        jsr $ffd2

        rts

; ----------------------------------------

textMouse       text "--mouse"
                byte $00

dhpmTotal       byte $00

displayHashPosMouse

        lda #0
        sta dhpmTotal

        ldx #0

dhpmAgain

        lda hashpos_mouse_start,x

        cmp #$ff
        beq dhpmNext

        stx dhHex
        jsr displayHex

        lda #":"
        jsr $ffd2

        lda hashpos_mouse_start,x        
        sta algSq
        jsr algebraic

        lda hashpos_mouse_dest,x        
        sta algSq
        jsr algebraic

        lda hashpos_mouse_lock,x        
        sta dhHex
        jsr displayHex

        inc dhpmTotal

        lda #","
        jsr $ffd2

dhpmNext

        inx
        cpx #$00
        bne dhpmAgain

dhpmEnd

        lda #13
        jsr $ffd2

        lda #<textMouse
        sta dtTextLo

        lda #>textMouse
        sta dtTextHi

        jsr displayText

        lda #":"
        jsr $ffd2

        lda dhpmTotal
        sta dhHex
        jsr displayHex

        lda #","
        jsr $ffd2

        lda coll_mouse2
        sta dhHex
        jsr displayHex

        lda coll_mouse1
        sta dhHex
        jsr displayHex

        lda #13
        jsr $ffd2

        rts

; ----------------------------------------

displayLockMouse

        ldx #0

dlmAgain

        lda lock_mouse,x
        sta dhHex
        jsr displayHex

        lda #","
        jsr $ffd2

        inx
        cpx #64
        bne dlmAgain

        lda #13
        jsr $ffd2

        rts

; ----------------------------------------

displayLockCat1

        ldx #0

dlc1Again

        lda lock_cat1,x
        sta dhHex
        jsr displayHex

        lda #","
        jsr $ffd2

        inx
        cpx #64
        bne dlc1Again

        lda #13
        jsr $ffd2

        rts

; ----------------------------------------

displayLockCat2

        ldx #0

dlc2Again

        lda lock_cat2,x
        sta dhHex
        jsr displayHex

        lda #","
        jsr $ffd2

        inx
        cpx #64
        bne dlc2Again

        lda #13
        jsr $ffd2

        rts

; ----------------------------------------

displayLockCat3

        ldx #0

dlc3Again

        lda lock_cat3,x
        sta dhHex
        jsr displayHex

        lda #","
        jsr $ffd2

        inx
        cpx #64
        bne dlc3Again

        lda #13
        jsr $ffd2

        rts

; ----------------------------------------

displayLockCat4

        ldx #0

dlc4Again

        lda lock_cat4,x
        sta dhHex
        jsr displayHex

        lda #","
        jsr $ffd2

        inx
        cpx #64
        bne dlc4Again

        lda #13
        jsr $ffd2

        rts

; ----------------------------------------

textCats        text "---cats"
                byte $00

dhpcTotal       byte $00

displayHashPosCats

        lda #0
        sta dhpcTotal

        ldx #0

dhpcAgain

        lda hashpos_cats_start,x

        cmp #$ff
        beq dhpcNext

        stx dhHex
        jsr displayHex

        lda #":"
        jsr $ffd2

        lda hashpos_cats_start,x        
        sta algSq
        jsr algebraic

        lda hashpos_cats_dest,x        
        sta algSq
        jsr algebraic

        lda hashpos_cats_lock,x        
        sta dhHex
        jsr displayHex

        inc dhpcTotal

        lda #","
        jsr $ffd2

dhpcNext

        inx
        cpx #$00
        bne dhpcAgain

dhpcEnd

        lda #13
        jsr $ffd2

        lda #<textCats
        sta dtTextLo

        lda #>textCats
        sta dtTextHi

        jsr displayText

        lda #":"
        jsr $ffd2

        lda dhpcTotal
        sta dhHex
        jsr displayHex

        lda #","
        jsr $ffd2

        lda coll_cats2
        sta dhHex
        jsr displayHex

        lda coll_cats1
        sta dhHex
        jsr displayHex

        lda #13
        jsr $ffd2

        rts

; ----------------------------------------
