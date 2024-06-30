deltaX_case:		;$80B7
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
	ld DE, (deltaX)
	srl D
	rr E
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	xor A				;reset Flags
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ld HL, (deltaY)
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
deltaXWhile:	;$810B
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;	while (xx1 != xx2)
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;ld HL, (line_x1)
	;ld DE, (line_x2)
	ld HL, (line_x2)
	ld DE, (line_x1)
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


fractionXLoop:
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;if (fraction >= 0)
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ld HL, (fraction)
	ld DE, 0000
	xor A
	sbc HL, DE				;compare the 2
	jp m, fractionX_smaller	;HL is smaller
	;jp p, fractionX_larger	;HL is larger

fractionX_larger:
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;yy1 += stepy;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ld A, 00
	ld D, A
	ld A, (stepY)
	ld E, A
	ld HL, (line_y1)
	add HL, DE
	ld (line_y1), HL

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;fraction -= delta_x;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;deltaX
	ld DE, (deltaX)
	ld HL, (fraction)
	sbc HL, DE
	ld (fraction), HL
	
	jr fractionXLoop
fractionXLoop_end:

fractionX_smaller:

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;xx1 += stepx;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ld HL, (line_x1)
	ld A, 00
	ld D, A
	ld A, (stepX)
	ld E, A
	add HL, DE
	ld (line_x1), HL

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;fraction += delta_y1;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ld HL, (fraction)
	ld DE, (deltaY)
	add HL, DE
	ld (fraction), HL



	jr deltaXWhile


;zee_test_point:		jr zee_test_point