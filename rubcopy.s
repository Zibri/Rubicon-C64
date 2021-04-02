; The following program copies sector 18 of track 18
; from the original Rubicon disk to another disk.
; Run this once for reading the sector and
; run it again to write it back.


   .ORG $500

    BEQ START
    LDA $24F
    ORA #$6         ; Allocate buffers 1 and 2.
    STA $24F
    LDA $22
    BNE ITSOK
    LDA #$12
    STA $22

ITSOK

    JSR $D005       ; we cleverly get ID and parameters from the disk and init everything in one shot.

MAIN

    LDA #$12        ; track 35 ; POKE 2516  to change track (remember that the sync track will always be T+2)
    STA $A          ; track for E0 command (move before start)
;   LDA #$12        ; sector number
    STA $B          ; for E0

    LDA #$E0
    STA $2
    JSR $C100       ; Turn LED on.
WE0
    LDA $2
    BNE WE0
    LDA $1C00
    AND #$F7        ; turn LED off.
    STA $1C00
    RTS

START

    SEI
    
    LDA $C0         ; Check write flag.
    CMP #$5A
    BEQ DOWRITE

DOREAD

    JSR $F50A       ; Find start of data block.

w   BVC w
    CLV
    LDA $1C01
    STA $0400,Y
    INY
    BNE w

; This was just a sanity check. Useless.
;
;    LDA $407
;    CMP #$AA
;    BNE DOREAD


; Note: it's useless to copy all $145 bytes. 
; Only the first $6A are really needed.

    LDY #$BB    
w2  BVC w2
    CLV
    LDA $1C01
    STA $0500,Y
    INY
    BNE w2

    LDA #$00
    LDX #$03
z
    STA $400,X
    DEX
    BNE z
    
    LDA #$5A
    STA $C0         ; Set write flag for the next run.

    BNE END
    
; ----------------- write ------------------------

DOWRITE

r2
    JSR $F510       ; find block header.

    LDX #$08
yy  BVC yy
    CLV
    DEX
    BNE yy          ; Skip the GAP.

    LDA #$FF
    STA $1C03
    LDA #$CE
    STA $1C0C       ; Write.

    LDA #$FF
    LDX #$05        ; 5x$FF SYNC.

; write data block

w3  BVC w3
    CLV
    STA $1C01
    DEX
    BNE w3

w1
    LDA $400,X
w4  BVC w4
    CLV
    STA $1C01
    INX
    BNE w1

    LDY #$BB
w6   
    LDA $500,Y
w5  BVC w5
    CLV
    STA $1C01
    INY
    BNE w6

    STY $C0          ; Reset write flag to read.

    LDA $24F
    AND #$F9         ; Free allocated buffers 1 and 2.
    STA $24F
    
END

    LDA #$EC
    STA $1C0C

    LDY #$00
    STY $1C03 

    CLI
    STY $02

    JMP $D005

.org $5BB
    .BYTE "SUCK MY JOYSTICK" ;)
    