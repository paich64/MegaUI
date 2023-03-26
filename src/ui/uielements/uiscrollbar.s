; ----------------------------------------------------------------------------------------------------

uiscrollbar_layout
        jsr uielement_layout
    	rts

uiscrollbar_focus
        jsr uielement_focus
	    rts

uiscrollbar_enter
        jsr uielement_enter
	    rts

uiscrollbar_leave
		jsr uielement_leave
		rts

uiscrollbar_draw
    	rts

uiscrollbar_press
    	rts

uiscrollbar_release
    	rts

uiscrollbar_move
		rts

uiscrollbar_keypress
		rts

uiscrollbar_keyrelease
		rts

; ----------------------------------------------------------------------------------------------------

uiscrollbar_increase
		jsr ui_getelementdataptr_tmp

		ldy #$00
		lda (zpptrtmp),y
		clc
		adc #$01
		sta (zpptrtmp),y

		jsr uiscrollbar_confine

		jsr uielement_listeners

		rts

uiscrollbar_decrease
		jsr ui_getelementdataptr_tmp

		ldy #$00
		lda (zpptrtmp),y
		sec
		sbc #$01
		sta (zpptrtmp),y

		jsr uiscrollbar_confine

		jsr uielement_listeners

		rts

uiscrollbar_setposition
		jsr ui_getelementdataptr_tmp

		ldy #$00
		sta (zpptrtmp),y

		jsr uiscrollbar_confine

		jsr uielement_listeners

		rts

; ----------------------------------------------------------------------------------------------------

uiscrollbar_confine

		ldy #$00										; get start pos
		lda (zpptrtmp),y
		bpl :+
		lda #$00										; smaller than 0, set to 0
		sta (zpptrtmp),y
		rts

:		ldy #$02										; get number of entries
		lda (zpptrtmp),y
		ldy #UIELEMENT::height							; subtract height
		sec
		sbc (zpptr0),y
		sec
		sbc #$02
		bpl :+											; smaller than 0 ? i.e. entries fit into box without scrolling
		lda #$00
		sta (zpptrtmp),y								; set scrolpos to 0

:		ldy #$00
		cmp (zpptrtmp),y								; compare with startpos
		bpl :+											; if bigger than ok
		sta (zpptrtmp),y

:		rts


; ----------------------------------------------------------------------------------------------------
