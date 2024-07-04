deltaY_case:			;$8122
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

	;ATTENTION
	;error, for some reason line_x1 is getting changed  by odd values
	
	;seems like something odd happening to D of DE
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;plot a pixel x1, y1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	call Plot_a_Pixel
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;plot a pixel x1, y1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	call compareX1X2	;call $8062
	;break out of loop if the two match

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
	;ld A, 00
	;xor A
	;ld D, A
	;ld A, (stepX)
	;ld E, A
	;ld HL, (line_x1)
	;add HL, DE
	;ld (line_x1), HL

	;ATTENTION, I believe the above routine is a problem
	
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
	;ld HL, (line_y1)
	;ld A, 00
	;ld D, A
	;ld A, (stepY)
	;ld E, A
	;add HL, DE
	;ld (line_y1), HL

	;ATTENTION, I believe the above routine is a problem
	
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
	
	