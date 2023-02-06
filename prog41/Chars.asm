; En este fichero ponemos la definición de los caracteres

; Los diseñamos con el editor de caracteres
; Y los exportamos a formato listado de bytes

; El código de pantalla 0 (@) lo dejamos igual
; Los códigos 1-10 (A-J) los redefinimos
; El resto de códigos los dejamos igual

; Exportamos los 256 códigos de pantalla

comienzoCars

        BYTE    170,234,249,245,245,245,213,85
        BYTE    24,60,102,126,102,102,102,0
        BYTE    124,102,102,124,102,102,124,0
        BYTE    60,102,96,96,96,102,60,0
        BYTE    120,108,102,102,102,108,120,0
        BYTE    126,96,96,120,96,96,126,0
        BYTE    126,96,96,120,96,96,96,0
        BYTE    60,102,96,110,102,102,60,0
        BYTE    102,102,102,126,102,102,102,0
        BYTE    60,24,24,24,24,24,60,0
        BYTE    30,12,12,12,12,108,56,0
        BYTE    102,108,120,112,120,108,102,0
        BYTE    96,96,96,96,96,96,126,0
        BYTE    99,119,127,107,99,99,99,0
        BYTE    102,118,126,126,110,102,102,0
        BYTE    60,102,102,102,102,102,60,0
        BYTE    124,102,102,124,96,96,96,0
        BYTE    60,102,102,102,102,60,14,0
        BYTE    124,102,102,124,120,108,102,0
        BYTE    60,102,96,60,6,102,60,0
        BYTE    126,24,24,24,24,24,24,0
        BYTE    102,102,102,102,102,102,60,0
        BYTE    102,102,102,102,102,60,24,0
        BYTE    99,99,99,107,127,119,99,0
        BYTE    102,102,60,24,60,102,102,0
        BYTE    102,102,102,60,24,24,24,0
        BYTE    126,6,12,24,48,96,126,0
        BYTE    60,48,48,48,48,48,60,0
        BYTE    12,18,48,124,48,98,252,0
        BYTE    60,12,12,12,12,12,60,0
        BYTE    0,24,60,126,24,24,24,24
        BYTE    0,16,48,127,127,48,16,0
        BYTE    0,0,0,0,0,0,0,0
        BYTE    24,24,24,24,0,0,24,0
        BYTE    102,102,102,0,0,0,0,0
        BYTE    102,102,255,102,255,102,102,0
        BYTE    24,62,96,60,6,124,24,0
        BYTE    98,102,12,24,48,102,70,0
        BYTE    60,102,60,56,103,102,63,0
        BYTE    6,12,24,0,0,0,0,0
        BYTE    12,24,48,48,48,24,12,0
        BYTE    48,24,12,12,12,24,48,0
        BYTE    0,102,60,255,60,102,0,0
        BYTE    0,24,24,126,24,24,0,0
        BYTE    0,0,0,0,0,24,24,48
        BYTE    0,0,0,126,0,0,0,0
        BYTE    0,0,0,0,0,24,24,0
        BYTE    0,3,6,12,24,48,96,0
        BYTE    60,102,110,118,102,102,60,0
        BYTE    24,24,56,24,24,24,126,0
        BYTE    60,102,6,12,48,96,126,0
        BYTE    60,102,6,28,6,102,60,0
        BYTE    6,14,30,102,127,6,6,0
        BYTE    126,96,124,6,6,102,60,0
        BYTE    60,102,96,124,102,102,60,0
        BYTE    126,102,12,24,24,24,24,0
        BYTE    60,102,102,60,102,102,60,0
        BYTE    60,102,102,62,6,102,60,0
        BYTE    0,0,24,0,0,24,0,0
        BYTE    0,0,24,0,0,24,24,48
        BYTE    14,24,48,96,48,24,14,0
        BYTE    0,0,126,0,126,0,0,0
        BYTE    112,24,12,6,12,24,112,0
        BYTE    60,102,6,12,24,0,24,0
        BYTE    0,0,0,255,255,0,0,0
        BYTE    8,28,62,127,127,28,62,0
        BYTE    24,24,24,24,24,24,24,24
        BYTE    0,0,0,255,255,0,0,0
        BYTE    0,0,255,255,0,0,0,0
        BYTE    0,255,255,0,0,0,0,0
        BYTE    0,0,0,0,255,255,0,0
        BYTE    48,48,48,48,48,48,48,48
        BYTE    12,12,12,12,12,12,12,12
        BYTE    0,0,0,224,240,56,24,24
        BYTE    24,24,28,15,7,0,0,0
        BYTE    24,24,56,240,224,0,0,0
        BYTE    192,192,192,192,192,192,255,255
        BYTE    192,224,112,56,28,14,7,3
        BYTE    3,7,14,28,56,112,224,192
        BYTE    255,255,192,192,192,192,192,192
        BYTE    255,255,3,3,3,3,3,3
        BYTE    0,60,126,126,126,126,60,0
        BYTE    0,0,0,0,0,255,255,0
        BYTE    54,127,127,127,62,28,8,0
        BYTE    96,96,96,96,96,96,96,96
        BYTE    0,0,0,7,15,28,24,24
        BYTE    195,231,126,60,60,126,231,195
        BYTE    0,60,126,102,102,126,60,0
        BYTE    24,24,102,102,24,24,60,0
        BYTE    6,6,6,6,6,6,6,6
        BYTE    8,28,62,127,62,28,8,0
        BYTE    24,24,24,255,255,24,24,24
        BYTE    192,192,48,48,192,192,48,48
        BYTE    24,24,24,24,24,24,24,24
        BYTE    0,0,3,62,118,54,54,0
        BYTE    255,127,63,31,15,7,3,1
        BYTE    0,0,0,0,0,0,0,0
        BYTE    240,240,240,240,240,240,240,240
        BYTE    0,0,0,0,255,255,255,255
        BYTE    255,0,0,0,0,0,0,0
        BYTE    0,0,0,0,0,0,0,255
        BYTE    192,192,192,192,192,192,192,192
        BYTE    204,204,51,51,204,204,51,51
        BYTE    3,3,3,3,3,3,3,3
        BYTE    0,0,0,0,204,204,51,51
        BYTE    255,254,252,248,240,224,192,128
        BYTE    3,3,3,3,3,3,3,3
        BYTE    24,24,24,31,31,24,24,24
        BYTE    0,0,0,0,15,15,15,15
        BYTE    24,24,24,31,31,0,0,0
        BYTE    0,0,0,248,248,24,24,24
        BYTE    0,0,0,0,0,0,255,255
        BYTE    0,0,0,31,31,24,24,24
        BYTE    24,24,24,255,255,0,0,0
        BYTE    0,0,0,255,255,24,24,24
        BYTE    24,24,24,248,248,24,24,24
        BYTE    192,192,192,192,192,192,192,192
        BYTE    224,224,224,224,224,224,224,224
        BYTE    7,7,7,7,7,7,7,7
        BYTE    255,255,0,0,0,0,0,0
        BYTE    255,255,255,0,0,0,0,0
        BYTE    0,0,0,0,0,255,255,255
        BYTE    3,3,3,3,3,3,255,255
        BYTE    0,0,0,0,240,240,240,240
        BYTE    15,15,15,15,0,0,0,0
        BYTE    24,24,24,248,248,0,0,0
        BYTE    240,240,240,240,0,0,0,0
        BYTE    240,240,240,240,15,15,15,15
        BYTE    195,153,145,145,159,153,195,255
        BYTE    231,195,153,129,153,153,153,255
        BYTE    131,153,153,131,153,153,131,255
        BYTE    195,153,159,159,159,153,195,255
        BYTE    135,147,153,153,153,147,135,255
        BYTE    129,159,159,135,159,159,129,255
        BYTE    129,159,159,135,159,159,159,255
        BYTE    195,153,159,145,153,153,195,255
        BYTE    153,153,153,129,153,153,153,255
        BYTE    195,231,231,231,231,231,195,255
        BYTE    225,243,243,243,243,147,199,255
        BYTE    153,147,135,143,135,147,153,255
        BYTE    159,159,159,159,159,159,129,255
        BYTE    156,136,128,148,156,156,156,255
        BYTE    153,137,129,129,145,153,153,255
        BYTE    195,153,153,153,153,153,195,255
        BYTE    131,153,153,131,159,159,159,255
        BYTE    195,153,153,153,153,195,241,255
        BYTE    131,153,153,131,135,147,153,255
        BYTE    195,153,159,195,249,153,195,255
        BYTE    129,231,231,231,231,231,231,255
        BYTE    153,153,153,153,153,153,195,255
        BYTE    153,153,153,153,153,195,231,255
        BYTE    156,156,156,148,128,136,156,255
        BYTE    153,153,195,231,195,153,153,255
        BYTE    153,153,153,195,231,231,231,255
        BYTE    129,249,243,231,207,159,129,255
        BYTE    195,207,207,207,207,207,195,255
        BYTE    243,237,207,131,207,157,3,255
        BYTE    195,243,243,243,243,243,195,255
        BYTE    255,231,195,129,231,231,231,231
        BYTE    255,239,207,128,128,207,239,255
        BYTE    255,255,255,255,255,255,255,255
        BYTE    231,231,231,231,255,255,231,255
        BYTE    153,153,153,255,255,255,255,255
        BYTE    153,153,0,153,0,153,153,255
        BYTE    231,193,159,195,249,131,231,255
        BYTE    157,153,243,231,207,153,185,255
        BYTE    195,153,195,199,152,153,192,255
        BYTE    249,243,231,255,255,255,255,255
        BYTE    243,231,207,207,207,231,243,255
        BYTE    207,231,243,243,243,231,207,255
        BYTE    255,153,195,0,195,153,255,255
        BYTE    255,231,231,129,231,231,255,255
        BYTE    255,255,255,255,255,231,231,207
        BYTE    255,255,255,129,255,255,255,255
        BYTE    255,255,255,255,255,231,231,255
        BYTE    255,252,249,243,231,207,159,255
        BYTE    195,153,145,137,153,153,195,255
        BYTE    231,231,199,231,231,231,129,255
        BYTE    195,153,249,243,207,159,129,255
        BYTE    195,153,249,227,249,153,195,255
        BYTE    249,241,225,153,128,249,249,255
        BYTE    129,159,131,249,249,153,195,255
        BYTE    195,153,159,131,153,153,195,255
        BYTE    129,153,243,231,231,231,231,255
        BYTE    195,153,153,195,153,153,195,255
        BYTE    195,153,153,193,249,153,195,255
        BYTE    255,255,231,255,255,231,255,255
        BYTE    255,255,231,255,255,231,231,207
        BYTE    241,231,207,159,207,231,241,255
        BYTE    255,255,129,255,129,255,255,255
        BYTE    143,231,243,249,243,231,143,255
        BYTE    195,153,249,243,231,255,231,255
        BYTE    255,255,255,0,0,255,255,255
        BYTE    247,227,193,128,128,227,193,255
        BYTE    231,231,231,231,231,231,231,231
        BYTE    255,255,255,0,0,255,255,255
        BYTE    255,255,0,0,255,255,255,255
        BYTE    255,0,0,255,255,255,255,255
        BYTE    255,255,255,255,0,0,255,255
        BYTE    207,207,207,207,207,207,207,207
        BYTE    243,243,243,243,243,243,243,243
        BYTE    255,255,255,31,15,199,231,231
        BYTE    231,231,227,240,248,255,255,255
        BYTE    231,231,199,15,31,255,255,255
        BYTE    63,63,63,63,63,63,0,0
        BYTE    63,31,143,199,227,241,248,252
        BYTE    252,248,241,227,199,143,31,63
        BYTE    0,0,63,63,63,63,63,63
        BYTE    0,0,252,252,252,252,252,252
        BYTE    255,195,129,129,129,129,195,255
        BYTE    255,255,255,255,255,0,0,255
        BYTE    201,128,128,128,193,227,247,255
        BYTE    159,159,159,159,159,159,159,159
        BYTE    255,255,255,248,240,227,231,231
        BYTE    60,24,129,195,195,129,24,60
        BYTE    255,195,129,153,153,129,195,255
        BYTE    231,231,153,153,231,231,195,255
        BYTE    249,249,249,249,249,249,249,249
        BYTE    247,227,193,128,193,227,247,255
        BYTE    231,231,231,0,0,231,231,231
        BYTE    63,63,207,207,63,63,207,207
        BYTE    231,231,231,231,231,231,231,231
        BYTE    255,255,252,193,137,201,201,255
        BYTE    0,128,192,224,240,248,252,254
        BYTE    255,255,255,255,255,255,255,255
        BYTE    15,15,15,15,15,15,15,15
        BYTE    255,255,255,255,0,0,0,0
        BYTE    0,255,255,255,255,255,255,255
        BYTE    255,255,255,255,255,255,255,0
        BYTE    63,63,63,63,63,63,63,63
        BYTE    51,51,204,204,51,51,204,204
        BYTE    252,252,252,252,252,252,252,252
        BYTE    255,255,255,255,51,51,204,204
        BYTE    0,1,3,7,15,31,63,127
        BYTE    252,252,252,252,252,252,252,252
        BYTE    231,231,231,224,224,231,231,231
        BYTE    255,255,255,255,240,240,240,240
        BYTE    231,231,231,224,224,255,255,255
        BYTE    255,255,255,7,7,231,231,231
        BYTE    255,255,255,255,255,255,0,0
        BYTE    255,255,255,224,224,231,231,231
        BYTE    231,231,231,0,0,255,255,255
        BYTE    255,255,255,0,0,231,231,231
        BYTE    231,231,231,7,7,231,231,231
        BYTE    63,63,63,63,63,63,63,63
        BYTE    31,31,31,31,31,31,31,31
        BYTE    248,248,248,248,248,248,248,248
        BYTE    0,0,255,255,255,255,255,255
        BYTE    0,0,0,255,255,255,255,255
        BYTE    255,255,255,255,255,0,0,0
        BYTE    252,252,252,252,252,252,0,0
        BYTE    255,255,255,255,15,15,15,15
        BYTE    240,240,240,240,255,255,255,255
        BYTE    231,231,231,7,7,255,255,255
        BYTE    15,15,15,15,255,255,255,255
        BYTE    15,15,15,15,240,240,240,240


finCars