; ----------------------------------------

; MOVE SORTING AND OPTIMIZED CUTTOFS

; ----------------------------------------

; 10 SYS2080

*=$0801

        BYTE    $0B, $08, $0A, $00, $9E, $32, $30, $38, $30, $00, $00, $00

; ----------------------------------------

*=$0820

        jmp main

; ----------------------------------------

computer_side   byte $00
player          byte $00,$00

fixed_time      byte $00
fixed_depth     byte $00

max_time        byte $00
max_depth       byte $00

turns           byte $00

command1        byte $00
command2        byte $00
command3        byte $00
command4        byte $00

command_start   byte $00
command_dest    byte $00

; ----------------------------------------

main

        jsr setup

again

        lda side
        cmp computer_side
        bne human

computer
        
        jsr computerTurn

human

        jsr humanTurn

        lda command1
        cmp #"."
        bne again

        lda command2
        cmp #"q"
        bne again

end 

        rts

; ----------------------------------------

textNLM text "no legal moves!"
        byte 13,$00
textCM  text "computer's move:"
        byte $00

computerTurn

        ldy side
        lda #PLAYER_COMPUTER
        sta player,y

        jsr thinkIter

        inc turns

        jsr getHash
        lda ghHash
        sta current_hash

        jsr getLock
        lda glLock
        sta current_lock

        lda side
        cmp #SIDE_MOUSE
        bne ctCats

ctMouse

        jsr lookUpMouse
        jmp ctLookUp

ctCats

        jsr lookUpCats

ctLookUp

        lda hash_start
        cmp #$ff
        bne ctComputerMove

ctNoLegalMove

        lda #<textNLM
        sta dtTextLo

        lda #>textNLM
        sta dtTextHi

        jsr displayText

        lda #PIECE_EMPTY
        sta computer_side

        jsr gen

        jsr displayBoard

        rts

ctComputerMove

        lda #<textCM
        sta dtTextLo

        lda #>textCM
        sta dtTextHi

        jsr displayText

        lda hash_start
        sta algSq
        jsr algebraic

        lda hash_dest
        sta algSq
        jsr algebraic

        lda #13
        jsr $ffd2

        lda hash_start
        sta mmStart

        lda hash_dest
        sta mmDest

        jsr makeMove

        lda #$00
        sta ply
        sta first_move

        jsr gen

        jsr displayBoard

        jsr checkResult

        rts

; ----------------------------------------


textGo          text "go"
                byte 13,0

textHelp        text "help"
                byte 13,0

textNew         text "new game"
                byte 13,0

textOff         text "off"
                byte 13,0

textQuit        text "quit"
                byte 13,0

textDepth       text "set depth"
                byte 13,0

textTime        text "set time"
                byte 13,0

textSwitch      text "switch sides"
                byte 13,0

textUndo        text "undo"
                byte 13,0

textIllegal     text "illegal"
                byte 13,0

; ----------------------------------------

humanTurn

        jsr command

        lda command1
        cmp #"."
        beq commands

        jmp parse

commands

        lda command2

dboard

        cmp #"b"
        bne go

        jsr displayBoard

        rts

go
        cmp #"g"
        bne help

        lda #<textGo
        sta dtTextLo

        lda #>textGo
        sta dtTextHi

        jsr displayText

        lda side
        sta computer_side

        rts

help

        cmp #"h"
        bne moves

        lda #<textHelp
        sta dtTextLo

        lda #>textHelp
        sta dtTextHi

        jsr displayText

        rts

moves

        cmp #"m"
        bne new

        jsr displayMoves

        rts

new 

        cmp #"n"
        bne off

        lda #<textNew
        sta dtTextLo

        lda #>textNew
        sta dtTextHi

        jsr displayText

        jsr newGame

        rts

off

        cmp #"o"
        bne quit

        lda #<textOff
        sta dtTextLo

        lda #>textOff
        sta dtTextHi

        jsr displayText

        lda #PIECE_EMPTY
        sta computer_side

        rts

quit

        cmp #"q"
        bne sdepth

        lda #<textQuit
        sta dtTextLo

        lda #>textQuit
        sta dtTextHi

        jsr displayText

        rts

sdepth

        cmp #"d"
        bne stime

        lda command3
        cmp #"1"
        bcc stime

        cmp #":"
        bcs stime

        sec
        sbc #$30

        sta max_depth

        lda #5
        sta max_time

        lda #$01
        sta fixed_depth

        lda #<textDepth
        sta dtTextLo

        lda #>textDepth
        sta dtTextHi

        jsr displayText

        rts

stime

        cmp #"t"
        bne switch

        lda command3
        cmp #"1"
        bcc switch

        cmp #":"
        bcs switch

        sec
        sbc #$30

        sta max_time

        lda MAX_PLY
        sta max_depth

        lda #$01
        sta fixed_time

        lda #<textTime
        sta dtTextLo

        lda #>textTime
        sta dtTextHi

        jsr displayText

        rts

switch

        cmp #"s"
        bne undo

        lda #<textSwitch
        sta dtTextLo

        lda #>textSwitch
        sta dtTextHi

        jsr displayText

        lda side
        eor #%00000001
        sta side

        rts

undo

        cmp #"u"
        bne extra

        lda #<textUndo
        sta dtTextLo

        lda #>textUndo
        sta dtTextHi

        jsr displayText

        lda hply
        beq undoEnd

        lda #PIECE_EMPTY
        sta computer_side

        jsr takeBack

        lda #$00
        sta ply
        sta first_move

        jsr gen
        
undoEnd

        rts

extra

        cmp #"e"
        bne parse

        jsr displayHashPosMouse
        jsr displayHashPosCats

        rts        

parse

        jsr parseMove

        lda command_start
        cmp #$ff
        bne parseOk

parseKo

        lda #<textIllegal
        sta dtTextlo

        lda #>textIllegal
        sta dtTextHi

        jsr displayText

        rts
        
parseOk

        lda #$00
        sta ply
        sta first_move

        jsr gen

        jsr verifyMove

        lda vmOK
        bne parseKo

parseMove2

        lda command_start
        sta mmStart

        lda command_dest
        sta mmDest

        jsr makeMove

        lda command_start
        sta algSq
        jsr algebraic

        lda command_dest
        sta algSq
        jsr algebraic

        lda #13
        jsr $ffd2

        lda #$00
        sta ply
        sta first_move

        jsr gen

        ;jsr displayBoard

        jsr checkResult

        rts

; ----------------------------------------

setup

        jsr fixedHash;randomize
        jsr initBoard
        jsr gen

        lda #PIECE_EMPTY
        sta computer_side

        lda #0
        sta player+0
        sta player+1

        lda #5 ; minutes
        sta max_time

        lda #10;4
        sta max_depth

        rts

; ----------------------------------------

command

        lda #$00
        sta command1
        sta command2
        sta command3
        sta command4

        lda #"?"
        jsr $ffd2

        lda #" "
        jsr $ffd2

input1

        jsr $ffe4
        beq input1

        cmp #20
        beq input1

        sta command1
        jsr $ffd2

        cmp #13
        bne input2

        rts

input2

        jsr $ffe4
        beq input2

        sta command2
        jsr $ffd2

        cmp #20
        beq input1

        cmp #13
        bne input3

        rts

input3

        jsr $ffe4
        beq input3

        sta command3
        jsr $ffd2

        cmp #20
        beq input2

        cmp #13
        bne input4

        rts

input4

        jsr $ffe4
        beq input4

        sta command4
        jsr $ffd2

        cmp #20
        beq input3

        cmp #13
        bne input5

        rts

input5

        jsr $ffe4
        beq input5

        cmp #20
        bne inputEnd

        jsr $ffd2
        jmp input4

inputEnd

        lda #13
        jsr $ffd2

        rts

; ----------------------------------------

newGame

        lda #PIECE_EMPTY
        sta computer_side

        jsr initBoard

        lda #$00
        sta first_move
        sta turns
        sta ply
        sta hply
        
        jsr gen

        rts

; ----------------------------------------

parseMove

pmStart

        lda command1
        cmp #"a"
        bcc pmIllegal

        cmp #"i"
        bcs pmIllegal

        sec
        sbc #65
        sta command_start

        lda command2
        cmp #"1"
        bcc pmIllegal

        cmp #"9"
        bcs pmIllegal

        sec
        sbc #49
        asl
        asl
        asl

        clc
        adc command_start
        sta command_start

pmDest

        lda command3
        cmp #"a"
        bcc pmIllegal

        cmp #"i"
        bcs pmIllegal

        sec
        sbc #65
        sta command_dest

        lda command4
        cmp #"1"
        bcc pmIllegal

        cmp #"9"
        bcs pmIllegal

        sec
        sbc #49
        asl
        asl
        asl

        clc
        adc command_dest
        sta command_dest

        rts

pmIllegal

        lda #$ff
        sta command_start
        sta command_dest

        rts
                
; ----------------------------------------

vmFirst byte $00
vmLast  byte $00

vmOK    byte $00

verifyMove

        lda #$ff
        sta vmOK

        ldx #$00
        lda first_move,x
        sta vmFirst

        ldx #$01
        lda first_move,x
        sta vmLast

        ldx vmFirst

vmStart

        lda move_list_start,x
        cmp command_start
        bne vmNext
       
vmDest

        lda move_list_dest,x
        cmp command_dest
        bne vmNext

        lda #$00
        sta vmOK

        rts

vmNext

        inx
        cpx vmLast
        bne vmStart

        rts

; ----------------------------------------

checkResult

        lda side
        cmp #SIDE_MOUSE
        bne crSideCats

crSideMouse

        jsr mouseNoMoves
        jmp crEnd

crSideCats

        jsr mouseInRow7
        jsr catsNoMoves

crEnd

        rts

; ----------------------------------------

mr7MouseWins    text "*** mouse wins!! ***"
                byte 13, 13, 0
mr7CatsWin      text "*** cats win!! ***"
                byte 13, 13, 0

mouseInRow7

        ldx #56

mr7Again

        lda board,x
        cmp #PIECE_MOUSE
        bne mr7Next

        lda #<mr7MouseWins
        sta dtTextLo

        lda #>mr7MouseWins
        sta dtTextHi

        jsr displayText

        jsr newGame

        jmp mr7End

mr7Next

        inx
        cpx #64
        bne mr7Again

mr7End

        rts

; ----------------------------------------

mouseNoMoves

        lda first_move+1
        bne mnmEnd

        lda #<mr7CatsWin
        sta dtTextLo

        lda #>mr7CatsWin
        sta dtTextHi

        jsr displayText

        jsr newGame

mnmEnd

        rts

; ----------------------------------------

catsNoMoves

        lda first_move+1
        bne cnmEnd

        lda #<mr7MouseWins
        sta dtTextLo

        lda #>mr7MouseWins
        sta dtTextHi

        jsr displayText

        jsr newGame

cnmEnd

        rts

; ----------------------------------------
