deltaX_case:		;$80D2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	if (delta_x > delta_y)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	fraction = delta_y1 - (delta_x1 >> 1);
; >> 1 is the same as dividing by 2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; non Loop
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;delta_x1 >> 1
;DIVIDE BY 2
	ld DE, (deltaX)		;deltaX is 16 bit
	srl D
	rr E
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	xor A				;reset Flags
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ld HL, (deltaY)		;deltaY is 16 bit
	sbc HL, DE			; deltaY - deltaX 
	ld (fraction), HL	;fraction is 16 bit
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; non Loop above
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Loop 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
deltaXWhile:	;$80DF

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;plot a pixel x1, y1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	call Plot_a_Pixel
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;plot a pixel x1, y1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	;call compareX1X2	;call $8062
	;break out of loop if the two match
	
	;added
	ld HL, (line_x1)
	ld DE, (line_x2)
	sbc HL, DE
	jp z, endless_F

fractionXLoop:			;$80E5
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;if (fraction >= 0)
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ld HL, (fraction)	;fraction is 16 bit
	ld DE, 0000
	xor A
	sbc HL, DE				;compare the 2
	jp m, fractionX_smaller	;HL is smaller
	;sign flag ON
	
	
	;jp p, fractionX_larger	;HL is larger
	;sign flag OFF

fractionX_larger:		;$80F1
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;yy1 += stepy;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	ld A, (stepY)		;stepY is 8 bit
	ld HL, (line_y1)	;line_y1 is 16 bit
	add A, L
	ld L, A
	ld (line_y1), HL	;line_y1 is 16 bit
	

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;fraction -= delta_x;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;deltaX
	ld HL, (fraction)	;fraction is 16 bit
	ld DE, (deltaX)		;deltaX is 16 bit	
	sbc HL, DE
	ld (fraction), HL	;fraction is 16 bit
	
	jr fractionXLoop
fractionXLoop_end:

fractionX_smaller:		;$810A

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;xx1 += stepx;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ld A, (stepX)		;stepX is 8 bit
	ld HL, (line_x1)	;line_x1 is 16 bit
	add A, L
	ld L, A
	ld (line_x1), HL	;line_x1 is 16 bit

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;fraction += delta_y1;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ld HL, (fraction)	;fraction is 16 bit
	ld DE, (deltaY)		;delta_y is 16 bit
	add HL, DE
	ld (fraction), HL	;fraction is 16 bit

	jr deltaXWhile

