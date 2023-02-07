; ----------------------------------------

side            byte $00

ply             byte $00
hply            byte $00

nodes1          byte $00
nodes2          byte $00
nodes3          byte $00
nodes4          byte $00

; ----------------------------------------

board           byte $00,$00,$00,$00,$00,$00,$00,$00
                byte $00,$00,$00,$00,$00,$00,$00,$00
                byte $00,$00,$00,$00,$00,$00,$00,$00
                byte $00,$00,$00,$00,$00,$00,$00,$00
                byte $00,$00,$00,$00,$00,$00,$00,$00
                byte $00,$00,$00,$00,$00,$00,$00,$00
                byte $00,$00,$00,$00,$00,$00,$00,$00
                byte $00,$00,$00,$00,$00,$00,$00,$00

; ----------------------------------------

mouse_score     byte $00
cats_score      byte $00

; ----------------------------------------

mouse_moves     byte -1,-1,9,-1
                byte -1,-1,10,8
                byte -1,-1,11,9
                byte -1,-1,12,10
                byte -1,-1,13,11
                byte -1,-1,14,12
                byte -1,-1,15,13
                byte -1,-1,-1,14
                byte -1,1,17,-1
                byte 0,2,18,16
                byte 1,3,19,17
                byte 2,4,20,18
                byte 3,5,21,19
                byte 4,6,22,20
                byte 5,7,23,21
                byte 6,-1,-1,22
                byte -1,9,25,-1
                byte 8,10,26,24
                byte 9,11,27,25
                byte 10,12,28,26
                byte 11,13,29,27
                byte 12,14,30,28
                byte 13,15,31,29
                byte 14,-1,-1,30
                byte -1,17,33,-1
                byte 16,18,34,32
                byte 17,19,35,33
                byte 18,20,36,34
                byte 19,21,37,35
                byte 20,22,38,36
                byte 21,23,39,37
                byte 22,-1,-1,38
                byte -1,25,41,-1
                byte 24,26,42,40
                byte 25,27,43,41
                byte 26,28,44,42
                byte 27,29,45,43
                byte 28,30,46,44
                byte 29,31,47,45
                byte 30,-1,-1,46
                byte -1,33,49,-1
                byte 32,34,50,48
                byte 33,35,51,49
                byte 34,36,52,50
                byte 35,37,53,51
                byte 36,38,54,52
                byte 37,39,55,53
                byte 38,-1,-1,54
                byte -1,41,57,-1
                byte 40,42,58,56
                byte 41,43,59,57
                byte 42,44,60,58
                byte 43,45,61,59
                byte 44,46,62,60
                byte 45,47,63,61
                byte 46,-1,-1,62
                byte -1,49,-1,-1
                byte 48,50,-1,-1
                byte 49,51,-1,-1
                byte 50,52,-1,-1
                byte 51,53,-1,-1
                byte 52,54,-1,-1
                byte 53,55,-1,-1
                byte 54,-1,-1,-1

cat_moves       byte -1,-1
                byte -1,-1
                byte -1,-1
                byte -1,-1
                byte -1,-1
                byte -1,-1
                byte -1,-1
                byte -1,-1
                byte -1,1
                byte 0,2
                byte 1,3
                byte 2,4
                byte 3,5
                byte 4,6
                byte 5,7
                byte 6,-1
                byte -1,9
                byte 8,10
                byte 9,11
                byte 10,12
                byte 11,13
                byte 12,14
                byte 13,15
                byte 14,-1
                byte -1,17
                byte 16,18
                byte 17,19
                byte 18,20
                byte 19,21
                byte 20,22
                byte 21,23
                byte 22,-1
                byte -1,25
                byte 24,26
                byte 25,27
                byte 26,28
                byte 27,29
                byte 28,30
                byte 29,31
                byte 30,-1
                byte -1,33
                byte 32,34
                byte 33,35
                byte 34,36
                byte 35,37
                byte 36,38
                byte 37,39
                byte 38,-1
                byte -1,41
                byte 40,42
                byte 41,43
                byte 42,44
                byte 43,45
                byte 44,46
                byte 45,47
                byte 46,-1
                byte -1,49
                byte 48,50
                byte 49,51
                byte 50,52
                byte 51,53
                byte 52,54
                byte 53,55
                byte 54,-1

; ----------------------------------------

move_list_start byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
                byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
                byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
                byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
                byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
                
move_list_dest  byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
                byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
                byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
                byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
                byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00

first_move      byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
                byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00

game_list_start byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
                byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
                byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
                byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
                byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
         
game_list_dest  byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
                byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
                byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
                byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
                byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00

; ----------------------------------------

init_board      byte 6,6,6,6,0,6,6,6
                byte 6,6,6,6,6,6,6,6
                byte 6,6,6,6,6,6,6,6 
                byte 6,6,6,6,6,6,6,6
                byte 6,6,6,6,6,6,6,6
                byte 6,6,6,6,6,6,6,6
                byte 6,6,6,6,6,6,6,6
                byte 6,1,6,2,6,3,6,4

col             byte 0,1,2,3,4,5,6,7
                byte 0,1,2,3,4,5,6,7
                byte 0,1,2,3,4,5,6,7
                byte 0,1,2,3,4,5,6,7
                byte 0,1,2,3,4,5,6,7
                byte 0,1,2,3,4,5,6,7   
                byte 0,1,2,3,4,5,6,7
                byte 0,1,2,3,4,5,6,7

row             byte 0,0,0,0,0,0,0,0
                byte 1,1,1,1,1,1,1,1
                byte 2,2,2,2,2,2,2,2
                byte 3,3,3,3,3,3,3,3
                byte 4,4,4,4,4,4,4,4
                byte 5,5,5,5,5,5,5,5
                byte 6,6,6,6,6,6,6,6
                byte 7,7,7,7,7,7,7,7

; ----------------------------------------

mouse_scores    byte 0,0,0,0,0,0,0,0
                byte 1,1,1,1,1,1,1,1
                byte 2,2,2,2,2,2,2,2
                byte 3,3,3,3,3,3,3,3 
                byte 4,4,4,4,4,4,4,4
                byte 5,5,5,5,5,5,5,5
                byte 6,6,6,6,6,6,6,6
                byte 7,7,7,7,7,7,7,7

cat1_scores     byte 0,0,0,0,0,0,0,0
                byte 0,7,0,0,0,0,0,0
                byte 13,0,0,0,0,0,0,0
                byte 0,18,0,0,0,0,0,0
                byte 22,0,0,0,0,0,0,0
                byte 0,25,0,0,0,0,0,0
                byte 27,0,0,0,0,0,0,0
                byte 0,28,0,0,0,0,0,0

cat2_scores     byte 0,0,0,0,0,0,0,0
                byte 0,0,0,7,0,0,0,0
                byte 0,0,13,0,0,0,0,0
                byte 0,0,0,18,0,0,0,0
                byte 0,0,22,0,0,0,0,0
                byte 0,0,0,25,0,0,0,0
                byte 0,0,27,0,0,0,0,0
                byte 0,0,0,28,0,0,0,0

cat3_scores     byte 0,0,0,0,0,0,0,0
                byte 0,0,0,0,0,7,0,0
                byte 0,0,0,0,13,0,0,0
                byte 0,0,0,0,0,18,0,0
                byte 0,0,0,0,22,0,0,0
                byte 0,0,0,0,0,25,0,0
                byte 0,0,0,0,27,0,0,0
                byte 0,0,0,0,0,28,0,0

cat4_scores     byte 0,0,0,0,0,0,0,0
                byte 0,0,0,0,0,0,0,7
                byte 0,0,0,0,0,0,13,0
                byte 0,0,0,0,0,0,0,18
                byte 0,0,0,0,0,0,22,0
                byte 0,0,0,0,0,0,0,25
                byte 0,0,0,0,0,0,27,0
                byte 0,0,0,0,0,0,0,28

; ----------------------------------------

ibTempX byte $00

initBoard

        stx ibTempX

        ldx #$00
        
ibAgain

        lda init_board,x
        sta board,x

        inx
        cpx #64
        bne ibAgain

ibOther

        lda #SIDE_MOUSE
        sta side

        lda #$00
        sta ply
        sta hply

        sta first_move

        ldx ibTempX

        rts

; ----------------------------------------

npTempX byte $00

newPosition

        stx npTempX

        lda #$00
        sta mouse_score
        sta cats_score

        ldx #0

npAgain

        lda board,x
        cmp #PIECE_EMPTY
        bcs npNext

        sta apPiece
        stx apSquare

        jsr addPiece
 
npNext

        inx
        cpx #64
        bne npAgain

        jsr getHash
        lda ghHash
        sta current_hash

        jsr getLock
        lda glLock
        sta current_lock

        ldx npTempX

        rts

; ----------------------------------------

algSq           byte $00

algCol          byte "a","b","c","d","e","f","g","h"
algRow          byte "1","2","3","4","5","6","7","8"

algTempX        byte $00
algTempY        byte $00

algebraic

        stx algTempX
        sty algTempY

        ldx algSq
        cpx #64
        bcc algOk

        rts

algOk

        lda col,x
        tay
        lda algCol,y
        jsr $ffd2
        
        lda row,x
        tay
        lda algRow,y
        jsr $ffd2

        ldx algTempX
        ldy algTempY

        rts

; ----------------------------------------        
