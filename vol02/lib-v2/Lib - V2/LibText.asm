; Librería de rutinas para manejar números y cadenas de texto

; Rutina para pintar un número en hexadecimal

numeroHex       byte $00

pintaHex

        lda numeroHex

        lsr a
        lsr a
        lsr a            
        lsr a

        jsr hexcii

        jsr chrout

        lda numeroHex

        and #%00001111

        jsr hexcii

        jsr chrout

        rts

; Rutina que convierte el nibble menos significativo del
; acumulador en su valor ascii

hexcii

        cmp #$0a

        bcc hexnumero

hexletra

        adc #$06

hexnumero

        adc #$30

        rts

; Rutina para pintar un número en hexadecimal en una posición de memoria

numeroHex2      byte $00
posicionLo2     byte $00
posicionHi2     byte $00

pintaHex2

        lda posicionLo2
        sta $fb
        lda posicionHi2
        sta $fc
        ldy #$00

        lda numeroHex2

        lsr a
        lsr a
        lsr a            
        lsr a

        jsr hexcode

        sta ($fb),y

        lda numeroHex2

        and #%00001111

        jsr hexcode

        iny
        sta ($fb),y

        rts

; Rutina que convierte el nibble menos significativo del
; acumulador en su código de pantalla

hexcode

        cmp #$0a

        bcc hexnumero2

hexletra2

        sbc #09
        rts

hexnumero2

        adc #48
        rts

; Rutina que lee un byte del teclado

byteLeido       byte $00

leeTeclado

        jsr getin
        beq leeTeclado
        
        tax
        jsr chrout
        txa

        jsr aschex
        asl a
        asl a
        asl a
        asl a
        sta byteLeido
        
ltsegundo

        jsr getin
        beq ltsegundo
        
        tax
        jsr chrout
        txa

        jsr aschex
        ora byteLeido
        sta byteLeido

        rts
        
; Rutina que convierte el valor ascii de un dígito hexadecimal
; en un nibble con el valor equivalente

aschex

        cmp #$40
        
        bcc ascnumero

ascletra

        sbc #$07

ascnumero

        sec
        sbc #$30
                        
        rts

; Rutina para pintar un número en binario

numeroBin       byte $00

pintaBin

        ldy #$08

pbbucle rol numeroBin

        lda #$00
        adc #$30

        jsr chrout

        dey

        bne pbbucle

        rts

; Rutina para pintar un número BCD

numeroBCD       byte $00
posicionLo      byte $00
posicionHi      byte $00

tablaBCD        text '0123456789'

pintaBCD

        lda posicionLo
        sta $fb

        lda posicionHi
        sta $fc

        ldy #$00

        lda numeroBCD

        lsr a
        lsr a
        lsr a
        lsr a

        tax

        lda tablaBCD,x

        sta ($fb),y

        iny

        lda numeroBCD

        and #%00001111

        tax

        lda tablaBCD,x

        sta ($fb),y

        rts

; Rutina para pintar una cadena

cadenaLo        byte $00
cadenaHi        byte $00

pintaCadena

        lda cadenaLo
        sta $fb

        lda cadenaHi
        sta $fc

        ldy #$00

pcBucle

        lda ($fb),y

        beq pcFin

        jsr chrout

        iny
        jmp pcBucle

pcFin
        
        rts

; Rutina para pintar una cadena en una posición de memoria

cadenaLo3       byte $00
cadenaHi3       byte $00
posicionLo3     byte $00
posicionHi3     byte $00

pintaCadena3

        lda cadenaLo3
        sta $fb

        lda cadenaHi3
        sta $fc

        lda posicionLo3
        sta $fd

        lda posicionHi3
        sta $fe

        ldy #$00

pcBucle3

        lda ($fb),y

        beq pcFin3

        sta ($fd),y

        iny
        jmp pcBucle3

pcFin3
        
        rts

; Rutina para convertir un nibble de peso 0 a BCD

; Un nibble de peso 0, en decimal, puede valer:
; 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15

; Para codificar estos valores decimales en BCD nos llega con un byte, pero
; por coherencia con la siguiente rutina (nibble de peso 1) usaremos dos bytes

nibble0         byte $00
nibble0BCDLo    byte $00
nibble0BCDHi    byte $00

tbl0Lo  byte $00,$01,$02,$03,$04,$05,$06,$07,$08,$09,$10,$11,$12,$13,$14,$15
tbl0Hi  byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

nibble0ToBCD

        ; Se asegura de tomar sólo un nibble
        lda nibble0
        and #%00001111

        ; Lo mueve el registro X para usarlo como índice
        tax

        ; Lee el valor Lo equivalente
        lda tbl0Lo,x
        sta nibble0BCDLo

        ; Lee el valor Hi equivalente (siempre $00 en este caso)
        lda tbl0Hi,x
        sta nibble0BCDHi

        rts

; Rutina para convertir un nibble de peso 1 (x16) a BCD

; Un nibble de peso 1, en decimal, puede valer:
; 0, 16, 32, 48, 64, 80, 96, 112, 128, 144, 160, 176, 192, 208, 224, 240

; Para codificar estos valores decimales en BCD nos hacen falta dos bytes

nibble1         byte $00
nibble1BCDLo    byte $00
nibble1BCDHi    byte $00

tbl1Lo  byte $00,$16,$32,$48,$64,$80,$96,$12,$28,$44,$60,$76,$92,$08,$24,$40
tbl1Hi  byte $00,$00,$00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$02,$02,$02

nibble1ToBCD

        ; Se asegura de tomar sólo un nibble
        lda nibble1
        and #%00001111

        ; Lo mueve el registro X para usarlo como índice
        tax

        ; Lee el valor Lo equivalente
        lda tbl1Lo,x
        sta nibble1BCDLo

        ; Lee el valor Hi equivalente
        lda tbl1Hi,x
        sta nibble1BCDHi

        rts

; Rutina para convertir un nibble de peso 2 (x256) a BCD

; Un nibble de peso 2, en decimal, puede valer:
; 0,256,512,768,1024,1280,1536,1792,2048,2304,2560,2816,3072,3328,3584,3840


; Para codificar estos valores decimales en BCD nos hacen falta dos bytes

nibble2         byte $00
nibble2BCDLo    byte $00
nibble2BCDHi    byte $00

tbl2Lo  byte $00,$56,$12,$68,$24,$80,$36,$92,$48,$04,$60,$16,$72,$28,$84,$40
tbl2Hi  byte $00,$02,$05,$07,$10,$12,$15,$17,$20,$23,$25,$28,$30,$33,$35,$38

nibble2ToBCD

        ; Se asegura de tomar sólo un nibble
        lda nibble2
        and #%00001111

        ; Lo mueve el registro X para usarlo como índice
        tax

        ; Lee el valor Lo equivalente
        lda tbl2Lo,x
        sta nibble2BCDLo

        ; Lee el valor Hi equivalente
        lda tbl2Hi,x
        sta nibble2BCDHi

        rts

; Rutina para convertir un byte (dos nibbles) a BCD

; Un byte (un nibble de peso 1 y otro de peso 0), en decimal, puede valer:
; 0, ... , 255

; Para codificar estos valores decimales en BCD nos hacen falta dos bytes

bite            byte $00

biteBCDLo       byte $00
biteBCDHi       byte $00

biteToBCD

        ; Inicializa la salida por si acaso...

        lda #$00
        sta biteBCDLo
        sta biteBCDHi

        ; Convierte el nibble 0

        lda bite
        and #%00001111
        sta nibble0

        jsr nibble0ToBCD

        ; Convierte el nibble 1

        lda bite
        lsr a
        lsr a
        lsr a
        lsr a
        sta nibble1

        jsr nibble1ToBCD

        ; Ahora hay que sumar
        ; La suma tiene que ser BCD

        sed ; Activa la suma BCD

        clc ; Borra el acarreo

        lda nibble0BCDLo ; Suma los dígitos Lo
        adc nibble1BCDLo

        sta biteBCDLo

        lda nibble0BCDHi ; Suma los dígitos Hi y el acarreo...
        adc nibble1BCDHi

        sta biteBCDHi

        cld ; Desactiva la suma BCD

        rts

; Rutina para convertir dos bytes (sólo consideramos 3 nibbles, no 4) a BCD

; Tres nibbles (pesos 2, 1 y 0), en decimal, puede valer:
; 0, ... , 4095

; Para codificar estos valores decimales en BCD nos hacen falta dos bytes

bitesLo         byte $00
bitesHi         byte $00

bitesBCDLo      byte $00
bitesBCDHi      byte $00

bitesToBCD

        ; Inicializa la salida por si acaso...

        lda #$00
        sta bitesBCDLo
        sta bitesBCDHi

        ; Convierte el nibble 0

        lda bitesLo
        and #%00001111
        sta nibble0

        jsr nibble0ToBCD

        ; Convierte el nibble 1

        lda bitesLo
        lsr a
        lsr a
        lsr a
        lsr a
        sta nibble1

        jsr nibble1ToBCD

        ; Convierte el nibble 2

        lda bitesHi
        and #%00001111
        sta nibble2

        jsr nibble2ToBCD

        ; Ahora hay que sumar
        ; La suma tiene que ser BCD

        sed ; Activa la suma BCD

        clc ; Borra el acarreo

        lda nibble0BCDLo ; Suma los dígitos Lo
        adc nibble1BCDLo

        sta bitesBCDLo

        lda nibble0BCDHi ; Suma los dígitos Hi y el acarreo...
        adc nibble1BCDHi

        sta bitesBCDHi

        clc

        lda bitesBCDLo
        adc nibble2BCDLo

        sta bitesBCDLo

        lda bitesBCDHi
        adc nibble2BCDHi

        sta bitesBCDHi

        cld ; Desactiva la suma BCD

        rts
