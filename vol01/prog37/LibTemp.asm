; Librería de rutinas para manejar el tiempo

; Rutina para meter un retardo

retardoLo       byte $00
retardoHi       byte $00

meteRetardo

        dec retardoLo
        bne meteRetardo

        dec retardoHi
        bne meteRetardo

        rts
