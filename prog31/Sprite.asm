; Esta es la definición del sprite obtenida diseñando el sprite
; en "Sprite Editor" y exportando los datos a directivas "byte"
; para el ensamblador

spritePulga

 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $01,$00,$80
 BYTE $00,$81,$00
 BYTE $00,$42,$00
 BYTE $00,$42,$00
 BYTE $00,$5A,$00
 BYTE $00,$3C,$00
 BYTE $00,$7E,$00
 BYTE $00,$5A,$00
 BYTE $06,$7E,$60
 BYTE $05,$7E,$A0
 BYTE $04,$FF,$20
 BYTE $02,$7E,$40
 BYTE $02,$3C,$40
 BYTE $02,$18,$40
 BYTE $01,$00,$80
 BYTE $01,$00,$80
 BYTE $01,$00,$80
 BYTE $1F,$00,$F8
 BYTE $00 ; Este último byte es el 64; es "padding" o relleno hasta 64

spriteUnPixel

 BYTE $80,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00 ; Este último byte es el 64; es "padding" o relleno hasta 64

