; KEYBOARD MATRIX
;
;         0        1        2         3       4         5       6        7        8
; +---+--------+--------+--------+--------+--------+--------+--------+--------+--------+
; | 0 | INST   | 3      | 5      | 7      | 9      | +      | £      | 1      | NO     |
; |   | DEL    |        |        |        |        |        |        |        | SCROLL |
; +---+--------+--------+--------+--------+--------+--------+--------+--------+--------+
; | 1 | RETURN | W      | R      | Y      | I      | P      | *      | ←      | TAB    |
; |   |        |        |        |        |        |        |        |        |        |
; +---+--------+--------+--------+--------+--------+--------+--------+--------+--------+
; | 2 | →      | A      | D      | G      | J      | L      | ;      | CTRL   | ALT    |
; |   |        |        |        |        |        |        |        |        |        |
; +---+--------+--------+--------+--------+--------+--------+--------+--------+--------+
; | 3 | F7     | 4      | 6      | 8      | 0      | -      | CLR    | 2      | HELP   |
; |   |        |        |        |        |        |        | HOME   |        |        |
; +---+--------+--------+--------+--------+--------+--------+--------+--------+--------+
; | 4 | F1     | Z      | C      | B      | M      | .      | SHIFT  | SPC    | F9     |
; |   |        |        |        |        |        |        | right  |        |        |
; +---+--------+--------+--------+--------+--------+--------+--------+--------+--------+
; | 5 | F3     | S      | F      | H      | K      | :      | =      | MEGA   | F11    |
; |   |        |        |        |        |        |        |        |        |        |
; +---+--------+--------+--------+--------+--------+--------+--------+--------+--------+
; | 6 | F5     | E      | T      | U      | O      | @      | ↑      | Q      | F13    |
; |   |        |        |        |        |        |        |        |        |        |
; +---+--------+--------+--------+--------+--------+--------+--------+--------+--------+
; | 7 | ↓      | SHIFT  | X      | V      | N      | ,      | /      | RUN    | ESC    |
; |   |        | left   |        |        |        |        |        | STOP   |        |
; +---+--------+--------+--------+--------+--------+--------+--------+--------+--------+

; row/columns inverted

;         0        1        2         3       4         5       6        7
; +---+--------+--------+--------+--------+--------+--------+--------+--------+
; | 0 | INST   | RETURN | CURS → | F7     | F1     | F3     | F5     | CURS ↓ |
; |   | DEL    |        |        |        |        |        |        |        |
; +---+--------+--------+--------+--------+--------+--------+--------+--------+
; | 1 | 3      | W      | A      | 4      | Z      | S      | E      | SHIFT  |
; |   |        |        |        |        |        |        |        | left   |
; +---+--------+--------+--------+--------+--------+--------+--------+--------+
; | 2 | 5      | R      | D      | 6      | C      | F      | T      | X      |
; |   |        |        |        |        |        |        |        |        |
; +---+--------+--------+--------+--------+--------+--------+--------+--------+
; | 3 | 7      | Y      | G      | 8      | B      | H      | U      | V      |
; |   |        |        |        |        |        |        |        |        |
; +---+--------+--------+--------+--------+--------+--------+--------+--------+
; | 4 | 9      | I      | J      | 0      | M      | K      | O      | N      |
; |   |        |        |        |        |        |        |        |        |
; +---+--------+--------+--------+--------+--------+--------+--------+--------+
; | 5 | +      | P      | L      | -      | .      | :      | @      | ,      |
; |   |        |        |        |        |        |        |        |        |
; +---+--------+--------+--------+--------+--------+--------+--------+--------+
; | 6 | £      | *      | ;      | CLR    | SHIFT  | =      | ↑      | /      |
; |   |        |        |        | HOME   | right  |        |        |        |
; +---+--------+--------+--------+--------+--------+--------+--------+--------+
; | 7 | 1      | ←      | CTRL   | 2      | SPC    | MEGA   | Q      | RUN    |
; |   |        |        |        |        |        |        |        | STOP   |
; +---+--------+--------+--------+--------+--------+--------+--------+--------+
; | 8 | NO     | TAB    | ALT    | HELP   | F9     | F11    | F13    | ESC    |
; |   | SCROLL |        |        |        |        |        |        |        |
; +---+--------+--------+--------+--------+--------+--------+--------+--------+

.define KEYBOARD_RETURN			#1
.define KEYBOARD_CURSORRIGHT	#2
.define KEYBOARD_CURSORDOWN		#7
.define KEYBOARD_CURSORLEFT		#$80 + 2
.define KEYBOARD_CURSORUP		#$80 + 7

; ----------------------------------------------------------------------------------------------------

keyboard_matrix ; columns

		.byte $00, $00, $00, $00, $00, $00, $00, $00
		.byte $00, $00, $ff, $00, $00, $00, $00, $00
		.byte $00, $00, $00, $00, $00, $00, $00, $00
		.byte $00, $00, $00, $00, $00, $00, $00, $00
		.byte $00, $00, $00, $00, $00, $00, $00, $00
		.byte $00, $00, $00, $00, $00, $00, $00, $00
		.byte $00, $00, $00, $00, $00, $00, $00, $00
		.byte $00, $00, $00, $00, $00, $00, $00, $00
		.byte $00, $00, $00, $00, $00, $00, $00, $00

; ----------------------------------------------------------------------------------------------------

keyboard_update

		ldx #$00    									; column
keyboard_testmatrixloop
		stx $d614										; put column into $d614
		lda $d613										; read back keys being pressed in column
		eor #$ff
		sta keyboard_columnkeys,x
		inx
		cpx #09
		bne keyboard_testmatrixloop

		lda keyboard_pressed
		sta keyboard_prevpressed

		lda #$ff
		sta keyboard_pressed
		sta keyboard_releasedeventarg

		ldx #$00
keyboard_testkeysloop
		lda keyboard_columnkeys,x
		lsr
		bcc :+
		ldy #$00
		jsr keyboard_set_keypressed
:		lsr
		bcc :+
		ldy #$01
		jsr keyboard_set_keypressed
:		lsr
		bcc :+
		ldy #$02
		jsr keyboard_set_keypressed
:		lsr
		bcc :+
		ldy #$03
		jsr keyboard_set_keypressed
:		lsr
		bcc :+
		ldy #$04
		jsr keyboard_set_keypressed
:		lsr
		bcc :+
		ldy #$05
		jsr keyboard_set_keypressed
:		lsr
		bcc :+
		ldy #$06
		jsr keyboard_set_keypressed
:		lsr
		bcc :+
		ldy #$07
		jsr keyboard_set_keypressed
:		inx
		cpx #$09
		bne keyboard_testkeysloop

		lda #$00
		sta keyboard_shouldsendpressevent
		sta keyboard_shouldsendreleaseevent

		lda $d60f										; handle special cases for cursorleft and cursorup
		and #%00000001
		beq :+
		lda KEYBOARD_CURSORLEFT
		sta keyboard_pressed
		bra :+
:		lda $d60f
		and #%00000010
		beq :+
		lda KEYBOARD_CURSORUP
		sta keyboard_pressed
		bra :+

:		lda keyboard_pressed
		cmp #$ff
		beq keyboard_nothingpressed

keyboard_somethingpressed								; something is pressed
		cmp keyboard_prevpressed
		beq keyboard_endchecks							; same key pressed, don't do anything
		lda #$01
		sta keyboard_shouldsendpressevent				; different key pressed, queue keypressed event
		lda keyboard_pressed
		sta keyboard_pressedeventarg
		bra keyboard_endchecks

keyboard_nothingpressed									; nothing is pressed
		lda keyboard_prevpressed
		cmp #$ff										; and nothing was previously pressed, do nothing
		beq keyboard_endchecks
		lda keyboard_prevpressed
		sta keyboard_releasedeventarg
		lda #$01										; something was pressed previously, queue keyreleased event
		sta keyboard_shouldsendreleaseevent

keyboard_endchecks

keyboard_update_end

		rts

keyboard_set_keypressed
		pha
		sty keyboard_pressed
		txa
		asl
		asl
		asl
		adc keyboard_pressed
		sta keyboard_pressed
		pla
		rts

; ----------------------------------------------------------------------------------------------------

keyboard_pressed
		.byte $ff

keyboard_prevpressed
		.byte $ff

keyboard_shouldsendpressevent
		.byte $00

keyboard_pressedeventarg
		.byte $00

keyboard_shouldsendreleaseevent
		.byte $00

keyboard_releasedeventarg
		.byte $00

keyboard_columnkeys
		.byte $00, $00, $00, $00, $00, $00, $00, $00, $00

; ----------------------------------------------------------------------------------------------------