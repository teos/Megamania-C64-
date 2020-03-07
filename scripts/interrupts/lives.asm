LIVES:{

	Value: .byte 3, 3

	.label HeartCharacter = 29
	.label BlankCharacter = 1

	.label MaxLives = 7
	.label StartLives = 3

	.label LivesRow = 21
	.label LivesCol = 15

	Columns:	.byte 0, 15, 17, 19, 21, 23, 25
	Hearts:		.byte 29, 31, 31, 32


	Reset:{

		lda #StartLives
		sta Value
		sta Value + 1

		jsr Draw
//
		rts
	}



	LoseLife: {

		ldx SHIP.CurrentPlayer

		lda Value, x
		beq Finish

		dec Value, x
		jsr Draw


		Finish:


		rts
	}

	GainLife: {

		ldx SHIP.CurrentPlayer

		inc Value, x
		lda Value, x
		cmp MaxLives
		bcc Okay

		dec Value, x

		Okay:

		jsr Draw

		rts

	}



	Draw:{

		ldx SHIP.CurrentPlayer
		lda Value, x
		sta LivesLeft
		ldx #6
		
		Loop:

			stx CurrentID

			ldy #0
			sty CharOffset

			lda Columns, x
			sta Column

			cpx LivesLeft
		
			bne DrawBlank

			DrawHeart:


				dec LivesLeft

				lda Hearts, y 
				ldx Column
				ldy #LivesRow

				jsr PLOT.PlotCharacter

				// ldy CharOffset
				// iny
				// sty CharOffset

				// lda Hearts, y
				// ldy #LivesRow
				// iny

				// jsr PLOT.PlotCharacter

				ldy CharOffset
				iny
				sty CharOffset

				lda Hearts, y
				inx

				ldy #LivesRow


				jsr PLOT.PlotCharacter

				// ldy CharOffset
				// iny
				// sty CharOffset

				// lda Hearts, y

				// ldy #LivesRow
				// iny

				// jsr PLOT.PlotCharacter

				jmp EndLoop


			
			DrawBlank:

				
				lda #BlankCharacter
				ldx Column
				ldy #LivesRow

				jsr PLOT.PlotCharacter

				// ldy #LivesRow
				// iny

				// jsr PLOT.PlotCharacter

				inx
				ldy #LivesRow

				jsr PLOT.PlotCharacter

				// ldy #LivesRow
				// iny

				// jsr PLOT.PlotCharacter

		

		EndLoop:	

			
			ldx CurrentID

			dex
			cpx #ZERO
			bne Loop
			rts


	
	}

}