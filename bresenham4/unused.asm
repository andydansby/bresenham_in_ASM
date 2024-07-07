;if (x1 == x2 && y1 == y2)
;break
; suggested by Clive Townsend
; of the Z80 Assembly Programming On The 
; ZX Spectrum facebook group
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
compareX1X2:		;$8062
	; if x1 == x2
	ld DE, (line_x1)
	ld HL, (line_x2)
	xor a 			;clear carry flag
	sbc HL, DE
	;;;;;;;;jp nz, X1X2_Y1Y2_no_match
	
	
	
	;ATTENTION temporily disabled
;	ret nz			;no match
	;if x1 & X2 match, fall through

	; if y1 == y2
	ld DE, (line_y1)
	ld HL, (line_y2)
	; No need to clear carry, as previous result was zero (so no carry)
	sbc HL, DE
	;jp nz, X1X2_Y1Y2_no_match
 	ret nz			;no match
	
X1X2_Y1Y2_match:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;break
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;jp end_bresenham
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Line is now complete
;since both x1 & x2  and Y1 & y2 match
;the line is now finished drawing
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;ret
jp z, endless_F

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
X1X2_Y1Y2_no_match:		;
	;if the two do not match, then we are not finished we need the next position
	;fall through