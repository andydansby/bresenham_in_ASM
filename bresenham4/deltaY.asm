deltaY_case:			;$8126
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	if (delta_y >= delta_x)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	fraction = delta_x - (delta_y >> 1);
; >> 1 is the same as dividing by 2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; non Loop
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;delta_y >> 1
;DIVIDE BY 2
	ld DE, (deltaY)		;deltaY is 16 bit
	srl D
	rr E
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	xor A				;reset Flags
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ld HL, (deltaX)		;deltaX is 16 bit
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
deltaYWhile:	;$8151

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
	ld HL, (line_y1)
	ld DE, (line_y2)
	sbc HL, DE
	jp z, endless_F

fractionYLoop:
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;if (fraction >= 0)
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ld HL, (fraction)	;fraction is 16 bit
	ld DE, 0000
	xor A
	sbc HL, DE				;compare the 2
	jp m, fractionY_smaller	;HL is smaller
	;sign flag ON
	
	
	;jp p, fractionX_larger	;HL is larger
	;sign flag OFF
	
	fractionY_larger:
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;xx1 += stepx;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	ld A, (stepX)
	ld HL, (line_x1)
	add A, L
	ld L, A
	ld (line_x1), HL
	

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;fraction -= delta_y;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;deltaY
	ld HL, (fraction)
	ld DE, (deltaY)	
	sbc HL, DE
	ld (fraction), HL
	
	jr fractionYLoop
fractionYLoop_end:

fractionY_smaller:

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;yy1 += stepy;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ld A, (stepY)
	ld HL, (line_y1)
	add A, L
	ld L, A
	ld (line_y1), HL

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;fraction += delta_y1;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ld HL, (fraction)
	ld DE, (deltaX)
	add HL, DE
	ld (fraction), HL

	jr deltaYWhile
	
	