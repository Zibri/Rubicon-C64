; rubicon read 18 18

   .ORG $500

    BEQ START
    LDA $24F
    ORA #$6
    STA $24F
    LDA $22
    BNE ISOK
    LDA #$12
    STA $22
ISOK
		JSR $D005       ; we cleverly get ID and parameters from the disk and init everything in one shot.

MAIN

		LDA #$12        ; track 35 ; POKE 2516  to change track (remember that the sync track will always be T+2)
		STA $A  				; track for E0 command (move before start)
;		LDA #$12				; sector number
		STA $B          ; for E0

    LDA #$E0
    STA $2
WE0
    LDA $2
    BNE WE0
    RTS

START

    SEI
    
    LDA $C0
    CMP #$5A
    BEQ DOWRITE

r1
    JSR $F50A  ; Find start of data block

w   BVC w
    CLV
    LDA $1C01
    STA $0400,Y
    INY
    BNE w
;    LDA $407
;    CMP #$AA
;    BNE r1

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
    STA $C0
    BNE END
    
; ----------------- write ------------------------

DOWRITE

r2
    JSR $F510 ; find block header

    LDX #$08
yy  BVC yy
    CLV
    DEX
    BNE yy
    LDA #$FF
    STA $1C03
    LDA #$CE
    STA $1C0C

    LDA #$FF
    LDX #$05


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

    STY $C0

    LDA $24F
    AND #$F9
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
    .BYTE "SUCK MY JOYSTICK"