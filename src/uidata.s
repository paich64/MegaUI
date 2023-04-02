
.align 256

; ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ main windows

root
		UIELEMENT_ADD ui_root1,				root,				windows,				0,  0, 80, 50,  0,		$ffff,					uidefaultflags
		UIELEMENT_END

; ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ main windows

windows
		UIELEMENT_ADD ui_windows1,			debugelement,		window1area,			 1,  0, 38, 45,  0,		$ffff,					uidefaultflags
		UIELEMENT_ADD ui_windows2,			debugelement,		window2area,			40,  0, 39, 45, 20,		$ffff,					uidefaultflags
		UIELEMENT_ADD ui_logo,				image,				$ffff,					68, 47, 11,  2,  0,		uilogo_data,			uidefaultflags
		UIELEMENT_END

; ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ child windows

window1area
		UIELEMENT_ADD debugelement3,		debugelement,		filearea1,				 1,  1, 20, 16,  0,		$ffff,					uidefaultflags
		UIELEMENT_ADD debugelement4,		debugelement,		cbuttonarea1,			22,  1, 15,  9,  0,		$ffff,					uidefaultflags
		UIELEMENT_ADD debugelement5,		debugelement,		checkboxarea1,			22, 10, 15,  7,  0,		$ffff,					uidefaultflags
		UIELEMENT_ADD debugelement6,		debugelement,		radiobtnarea1,			22, 17, 15,  9,  0,		$ffff,					uidefaultflags
		UIELEMENT_ADD debugelement7,		debugelement,		mousedebugarea1,		22, 26, 15,  7,  0,		$ffff,					uidefaultflags
		UIELEMENT_END

window2area
		UIELEMENT_ADD playbutton,			button,				$ffff,					 2,  2,  2,  2,  0,		playbutton_data,		uidefaultflags
		;UIELEMENT_ADD debugelement2,		debugelement,		$ffff,					 1,  1, 37, 19,  0,		$ffff,					uidefaultflags
		UIELEMENT_END

; ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ scrollbar elements

filearea1
		UIELEMENT_ADD nineslice1,			nineslice,			nineslice1elements,		 1,  1, -2, -2,  0,		$ffff,					uidefaultflags
		UIELEMENT_END

; ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ scrollbar elements

cbuttonarea1
		UIELEMENT_ADD ctextbutton1,			ctextbutton,		$ffff,					 1,  1, -2,  3,  0,		ctextbutton1_data,		uidefaultflags
		UIELEMENT_ADD ctextbutton2,			ctextbutton,		$ffff,					 1,  3, -2,  3,  0,		ctextbutton2_data,		uidefaultflags
		UIELEMENT_ADD ctextbutton3,			ctextbutton,		$ffff,					 1,  5, -2,  3,  0,		ctextbutton3_data,		uidefaultflags
		UIELEMENT_END

; ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ scrollbar elements

checkboxarea1
		UIELEMENT_ADD checkboxlabel1,		label,				$ffff,					 2,  2,  8,  1,  0,		checkboxlabel_data,		uidefaultflags
		UIELEMENT_ADD checkboxlabel2,		label,				$ffff,					 2,  4,  8,  1,  0,		checkboxlabel_data,		uidefaultflags
		UIELEMENT_ADD checkbox1,			checkbox,			$ffff,					-4,  2,  2,  1,  0,		checkbox1_data,			uidefaultflags
		UIELEMENT_ADD checkbox2,			checkbox,			$ffff,					-4,  4,  2,  1,  0,		checkbox2_data,			uidefaultflags
		UIELEMENT_END

; ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ scrollbar elements

radiobtnarea1
		UIELEMENT_ADD radiolabel1,			label,				$ffff,					 2,  2,  8,  1,  0,		radiobuttonlabel_data,	uidefaultflags
		UIELEMENT_ADD radiolabel2,			label,				$ffff,					 2,  4,  8,  1,  0,		radiobuttonlabel_data,	uidefaultflags
		UIELEMENT_ADD radiolabel3,			label,				$ffff,					 2,  6,  8,  1,  0,		radiobuttonlabel_data,	uidefaultflags
		UIELEMENT_ADD radiobutton1,			radiobutton,		$ffff,					-3,  2,  1,  1,  0,		radiobutton1_data,		uidefaultflags
		UIELEMENT_ADD radiobutton2,			radiobutton,		$ffff,					-3,  4,  1,  1,  0,		radiobutton2_data,		uidefaultflags
		UIELEMENT_ADD radiobutton3,			radiobutton,		$ffff,					-3,  6,  1,  1,  0,		radiobutton3_data,		uidefaultflags
		UIELEMENT_END

; ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ scrollbar elements

mousedebugarea1
		UIELEMENT_ADD paddlexlabel,			label,				$ffff,					 2,  2,  8,  1,  0,		paddlexlabel_data,		uidefaultflags
		UIELEMENT_ADD paddleylabel,			label,				$ffff,					 2,  4,  8,  1,  0,		paddleylabel_data,		uidefaultflags
		UIELEMENT_ADD hexlabel1,			hexlabel,			$ffff,					-4,  2,  2,  1,  0,		hexlabel1_data,			uidefaultflags
		UIELEMENT_ADD hexlabel2,			hexlabel,			$ffff,					-4,  4,  2,  1,  0,		hexlabel2_data,			uidefaultflags
		UIELEMENT_END

; ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ scrollbar elements

scrollbar1elements
		UIELEMENT_ADD scrollbar1button1,	button,				$ffff,					 0,  0,  2,  2,  0,		scrollbuttonup_data,	uidefaultflags
		UIELEMENT_ADD scrollbar1button2,	button,				$ffff,					 0, -2,  2,  2,  0,		scrollbuttondown_data,	uidefaultflags
		UIELEMENT_ADD scrollbar1track,		scrolltrack,		$ffff,					 0,  2,  2, -4,  0,		scrollbar_data,			uidefaultflags
		UIELEMENT_END

; ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ data

nineslice1elements
		UIELEMENT_ADD filebox1,				filebox,			$ffff,					 1,  1, -5, -2,  0,		filebox1_data,			uidefaultflags
		UIELEMENT_ADD scrollbar1,			scrollbar,			scrollbar1elements,		-3,  1,  2, -2,  0,		scrollbar_data,			uidefaultflags
		UIELEMENT_END

; ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ data

paddlexlabel_data			.word $ffff,							uitxt_paddlex
hexlabel1_data				.word $ffff,							mouse_d419
paddleylabel_data			.word $ffff,							uitxt_paddley
hexlabel2_data				.word $ffff,							mouse_d41a

uilogo_data					.word $ffff,							((14*16+ 0) | (14*16+ 0)<<8)

scrollbar_data				.word scrollbar_functions, 				0, 0, 30	; start position, selection index, number of entries

checkboxlabel_data			.word $ffff,							uitxt_checkbox
radiobuttonlabel_data		.word $ffff,							uitxt_radiobutton

ctextbutton1_data			.word ctextbutton1_functions,			uitxt_button0
ctextbutton2_data			.word ctextbutton2_functions,			uitxt_button1
ctextbutton3_data			.word ctextbutton3_functions,			uitxt_button2

scrollbuttonup_data			.word scrollbuttonup_functions,			((4*16+ 0) | (4*16+ 4)<<8)
scrollbuttondown_data		.word scrollbuttondown_functions,		((4*16+ 8) | (4*16+12)<<8)

filebox1_data				.word scrollbar_functions,				scrollbar_data, listboxtxt
checkbox1_data				.word $ffff,							1, ((3*16+ 8) | (3*16+10)<<8)
checkbox2_data				.word $ffff,							0, ((3*16+ 8) | (3*16+10)<<8)

radiobuttongroupindex		.word 1
radiobutton1_data			.word radiobutton_functions,			0, radiobuttongroupindex
radiobutton2_data			.word radiobutton_functions,			1, radiobuttongroupindex
radiobutton3_data			.word radiobutton_functions,			2, radiobuttongroupindex

playbutton_data				.word $ffff,							((8*16+0) | (8*16+4)<<8)

; ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ listeners

scrollbuttonup_functions	.word scrollbar1track,					uiscrollbar_decrease
							.word scrollbar1track,					uiscrolltrack_draw
							.word filebox1,							uifilebox_draw
							.word $ffff

scrollbuttondown_functions	.word scrollbar1track,					uiscrollbar_increase
							.word scrollbar1track,					uiscrolltrack_draw
							.word filebox1,							uifilebox_draw
							.word $ffff

scrollbar_functions			.word scrollbar1track,					uiscrolltrack_draw
							.word filebox1,							uifilebox_draw
							.word $ffff

radiobutton_functions		.word radiobutton1,						uiradiobutton_draw
							.word radiobutton2,						uiradiobutton_draw
							.word radiobutton3,						uiradiobutton_draw
							.word $ffff

ctextbutton1_functions		.word ctextbutton1,						custom_colourborder_pink
							.word $ffff

ctextbutton2_functions		.word ctextbutton2,						custom_colourborder_lightblue
							.word $ffff

ctextbutton3_functions		.word ctextbutton3,						custom_colourborder_cyan
							.word $ffff

; ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

custom_colourborder_pink
		lda #$60
		DEBUG_COLOUR
		rts

custom_colourborder_lightblue
		lda #$a0
		DEBUG_COLOUR
		rts

custom_colourborder_cyan
		lda #$c0
		DEBUG_COLOUR
		rts

; ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
