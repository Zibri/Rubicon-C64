; The following program writes sector 18 of track 18
; on a quickcopy of the original rubicon disk.


   .ORG $500

    BEQ START
    
    LDA $22
    BNE MAIN

    JSR $D005       ; we cleverly get ID and parameters from the disk and init everything in one shot.

MAIN

    JSR $C100       ; Turn LED on.

    LDA #$12        ; track 18
    STA $A          ; track for E0 command (move before start)
;   LDA #$12        ; sector 18
    STA $B          ; for E0

    LDA #$E0
    STA $2
WE0
    LDA $2
    BNE WE0

    JMP $D005

START

    JSR $F510       ; find block header.

    LDX #$08        ; Skip the GAP.
w1  BVC w1
    CLV
    DEX
    BNE w1

    LDA #$FF
    STA $1C03
    LDA #$CE        ; Write.
    STA $1C0C

    LDA #$FF
    LDX #$05        ; Write 5 FF (SYNC).


w2  BVC w2
    CLV
    STA $1C01
    DEX
    BNE w2

w3                  ; Write 24 bytes of data 
                    ; Extrapolated by reading the original track
                    ; An rearranged to save space :D
              
    LDA DATA,X
w4  BVC w4
    CLV
    STA $1C01
    INX
    CPX #$20 
    BNE w3

w5  BVC w5
    CLV

    LDA #$EC
    STA $1C0C

    LDY #$00
    STY $1C03 


    STY $02
    RTS

DATA:               ; Probably not the original but the bits are the same :D
                    ; So probably the original data is a shifted (left or right) version
                    ; of the following bytes.

;   .BYTE  $00, $00, $AA, $AA, $AA, $AA, $AA, $AA
;   .BYTE  $BE, $6E, $D4, $AA, $E5, $BB, $AE, $AB
;   .BYTE  $B7, $25, $AE, $6B, $B2, $B4, $A7, $99
;   .BYTE  $AA, $FA, $65, $AA, $AA, $AA, $AA, $AA

   .BYTE  $00, $00, $55, $55, $55, $55, $55, $55
   .BYTE  $5F, $37, $6A, $55, $72, $DD, $D7, $55
   .BYTE  $DB, $92, $D7, $35, $D9, $5A, $53, $CC
   .BYTE  $D5, $7D, $32, $D5, $55, $55, $55, $55
