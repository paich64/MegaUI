mouse_delta_adjust:
		.byte $01, $01, $02, $02, $03, $04, $06, $08
		.byte $09, $0b, $0d, $0f, $11, $13, $15, $19
		.byte $1d, $20, $23, $26, $29, $2c, $2f, $32
		.byte $35, $38, $3c, $41, $4b, $50, $5a, $64

		;.byte $01, $02, $03, $05, $08, $0a, $0d, $11
		;.byte $14, $18, $1c, $21, $25, $29, $2c, $2f
		;.byte $35, $38, $3c, $41, $4b, $50, $5a, $64
		;.byte $64, $64, $64, $64, $64, $64, $64, $64

mouse_temp1					.byte $00
mouse_temp2					.byte $00

mouse_d419					.byte $00
mouse_d41a					.byte $00

mouse_paddlex				.byte $00
mouse_paddley				.byte $00

mouse_xpos_plusborder		.word $0080
mouse_xpos					.word $0080
mouse_prevxpos				.word $0080
mouse_xpos_pressed			.word $0080
mouse_ypos_plusborder		.word $0080
mouse_ypos					.word $0080
mouse_prevypos				.word $0080
mouse_ypos_pressed			.word $0080

mouse_pressed_timer			.word $00

mouse_pressed			; this will be 1 for every frame that the button is pressed, not just 1 frame
		.byte $00

mouse_held
		.byte $00

mouse_released			; this will only be 1 in the frame in which the button was released
		.byte $00


; ----------------------------------------------------------------------------------------------------

mouse_init

		rts

; ----------------------------------------------------------------------------------------------------

mouse_update

		; $dc00 = data port A
		;	read/write:	bit 0...7 keyboard matrix columns
		;	read:		joystick port 2:	bit 0..3 direction, but 4 fire button, 0 = activated
		;	read:		lightpen:			bit 4 (as fire button), connected also with '/LP' (pin 9) of the vic
		;	read:		paddles:			bit 2..3 fire buttons, bit 6..7 switch control port 1 (%01=Paddles A) or 2 (%10=Paddles B)
		; $dc01 = data port B
		;	read/write:	bit 0...7 keyboard matrix columns
		;	read:		joystick port 1:	bit 0..3 direction, but 4 fire button, 0 = activated
		;	read:		bit 6:				Timer A: Toggle/Impulse output (see register 14 bit 2)
		;	read:		bit 7:				Timer B: Toggle/Impulse output (see register 15 bit 2)
		; $dc02 = Data Direction Port A
		; 	Bit X: 0=Input (read only), 1=Output (read and write)
		; $dc03 = Data Direction Port B
		; 	Bit X: 0=Input (read only), 1=Output (read and write)


		lda #$00										; set data direction to  0=input (read only) for all 8 data lines
		sta $dc02
		lda #$40
		sta $dc00

;		ldx #$66
;:		nop
;		nop
;		nop
;		dex
;		bne :-

		lda $d419										; read paddle port and store mouse pos
		sta mouse_d419
		ldy mouse_paddlex
		jsr mouse_count_delta
		sty mouse_paddlex

		clc
		adc mouse_xpos_plusborder+0
		sta mouse_xpos_plusborder+0
		txa												; x = 0/ff after mouse_count_delta
		adc mouse_xpos_plusborder+1
		sta mouse_xpos_plusborder+1

		lda $d41a
		sta mouse_d41a
		ldy mouse_paddley
		jsr mouse_count_delta
		sty mouse_paddley

		sec
		eor #$ff
		adc mouse_ypos_plusborder+0
		sta mouse_ypos_plusborder+0
		txa												; x = 0/ff after mouse_count_delta
		eor #$ff
		adc mouse_ypos_plusborder+1
		sta mouse_ypos_plusborder+1

		lda #$ff
		sta $dc02
	
		lda mouse_xpos+0								; store previous positions
		sta mouse_prevxpos+0
		lda mouse_xpos+1
		sta mouse_prevxpos+1
		lda mouse_ypos+0
		sta mouse_prevypos+0
		lda mouse_ypos+1
		sta mouse_prevypos+1

		sec												; subtract upper left corner position
		lda mouse_xpos_plusborder+0
		sbc #$50
		sta mouse_xpos+0
		lda mouse_xpos_plusborder+1
		sbc #$00
		sta mouse_xpos+1

		sec
		lda mouse_ypos_plusborder+0
		sbc #$67 ; $d048
		sta mouse_ypos+0
		lda mouse_ypos_plusborder+1
		sbc #$00
		sta mouse_ypos+1

		jsr mouse_constrain_x
		jsr mouse_constrain_y

		clc												; mouse is constraint. calculate new plusborder values
		lda mouse_xpos+0
		adc #$50
		sta mouse_xpos_plusborder+0
		lda mouse_xpos+1
		adc #$00
		sta mouse_xpos_plusborder+1
		clc												; mouse is constraint. calculate new plusborder values
		lda mouse_ypos+0
		adc #$67 ; $d048
		sta mouse_ypos_plusborder+0
		lda mouse_ypos+1
		adc #$00
		sta mouse_ypos_plusborder+1

		lda #$00										; check if mouse button was pressed/released/etc.
		sta mouse_released
		lda #$00
		sta mouse_pressed

        lda $dc01										; read gameport 1. assumes paddle one is selected in bit 6/7 of $dc00
        and #$10										; isolate button bit
        beq mouse_event_pressed
		
		lda mouse_held									; mouse is not pressed, check if it was pressed before
		bne :+
		bra mouse_check_end
:		lda #$01
		sta mouse_released
		lda #$00
		sta mouse_held
		bra mouse_check_end

mouse_event_pressed

		lda mouse_held									; mouse is pressed, check if it was pressed before
		beq :+
		bra mouse_check_end								; mouse was pressed before, so leave mouse_pressed at 0 and continue

:		lda #$01										; mouse was not pressed before. record everything and send pressed event
		sta mouse_pressed
		sta mouse_held
		lda mouse_xpos
		sta mouse_xpos_pressed
		lda mouse_ypos
		sta mouse_ypos_pressed

mouse_check_end

		rts

; -------------------------------------------		

mouse_constrain_x
		lda mouse_xpos+1
		cmp #$ff
		beq mcxnegative
		cmp #$02
		bne :+
		lda mouse_xpos+0
		cmp #$7d
		bmi :+
		lda #$7c
		sta mouse_xpos+0

:		rts		

mcxnegative
		lda #$00
		sta mouse_xpos+0
		sta mouse_xpos+1
		rts

; -------------------------------------------		

mouse_constrain_y
		lda mouse_ypos+1
		cmp #$ff
		beq mcynegative
		cmp #$01
		bne :+
		lda mouse_ypos+0
		cmp #$8d
		bmi :+
		cmp #$00
		bpl :+
		lda #$8c
		sta mouse_ypos+0

:		rts		

mcynegative
		lda #$00
		sta mouse_ypos+0
		sta mouse_ypos+1
		rts

; -------------------------------------------		

mouse_count_delta

		sty mouse_temp1									; old value
		sta mouse_temp2									; current value
		ldx #0											; assume 0/positive
		sec
		sbc mouse_temp1									; subtract old value from current value
		and #%01111111									; remove highest bit
		cmp #%01000000
		bcs mcd_negative
		lsr
		beq mcd_zero
		tay
		lda mouse_delta_adjust-1,y
		ldy mouse_temp2
		rts

mcd_negative
		ora #%11000000
		cmp #%11111111
		beq mcd_zero
		sec
		ror
		eor #%11111111
		tay
		lda mouse_delta_adjust,y
		eor #%11111111
		clc
		adc #$01
		ldx #%11111111
		ldy mouse_temp2
		rts

mcd_zero		
		lda #0
		rts

; ----------------------------------------------------------------------------------------------------