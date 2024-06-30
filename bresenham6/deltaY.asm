deltaY_case:			;$811D
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
	ld DE, (deltaY)
	srl D
	rr E
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	xor A				;reset Flags
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ld HL, (deltaX)
	sbc HL, DE			; deltaY - deltaX 
	ld (fraction), HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; non Loop above
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Loop 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
deltaYWhile:	;$8151
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;	while (xx1 != xx2)
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;ld HL, (line_x1)
	;ld DE, (line_x2)
	ld HL, (line_y2)
	ld DE, (line_y1)
	xor A				;reset Flags
	sbc HL, DE			;compare the 2
	;jp z, end_deltaX
	;jp z, end_bresenham
	jp z, end_bresenham
	;break out of loop if the two match


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;plot a pixel x1, y1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	call Plot_a_Pixel
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;plot a pixel x1, y1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


fractionYLoop:
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;if (fraction >= 0)
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ld HL, (fraction)
	ld DE, 0000
	xor A
	sbc HL, DE				;compare the 2
	jp m, fractionY_smaller	;HL is smaller
	;jp p, fractionX_larger	;HL is larger
	
	fractionY_larger:
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;xx1 += stepx;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ld A, 00
	ld D, A
	ld A, (stepX)
	ld E, A
	ld HL, (line_x1)
	add HL, DE
	ld (line_x1), HL

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;fraction -= delta_y;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;deltaY
	ld DE, (deltaY)
	ld HL, (fraction)
	sbc HL, DE
	ld (fraction), HL
	
	jr fractionYLoop
fractionYLoop_end:

fractionY_smaller:

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;yy1 += stepy;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ld HL, (line_y1)
	ld A, 00
	ld D, A
	ld A, (stepY)
	ld E, A
	add HL, DE
	ld (line_y1), HL

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;fraction += delta_y1;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ld HL, (fraction)
	ld DE, (deltaX)
	add HL, DE
	ld (fraction), HL



	jr deltaYWhile