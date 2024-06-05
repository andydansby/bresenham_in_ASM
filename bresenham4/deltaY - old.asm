deltaY_case:

	; this moves along the Y axis
	
	; errors
	; when y1 = 0 and y2 = 5 OK
	; when y1 = 0 and y2 = 128 OK
	; when y1 = 0 and y2 = 129 locks up
	; seems to max out at 136 pixels and locks
	
	; when y1 = 0 and y2 = 171, only goes 96 pixels
	; when y1 = 5 and y2 = 0 ERROR
	
	;when x1 = 0 and x2 = 5, only shows first and last pixel exit OK
	;when x1 = 5 and x2 = 0, only shows first and last pixel exit OK
	;very slow on X axis when you use 255, why
	;speed ok at 254 and less



;tempStop:
;	jp tempStop


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;if (error2 >= deltaY)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;if (x1 == x2) 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	ld HL, (line_x1)		;load X1
	ld DE, (line_x2)		;load X2
	sbc HL, DE
	jp z, check_deltaX		;if Zero flag is ON, then both are equal and break loop

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;error1 = error1 + deltaY;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	ld HL, (error1)
	ld DE, (deltaY)
	add HL, DE
	ld (error1), HL
;<-------------------------------------------------
; error1 is the answer found in HL
;<-------------------------------------------------

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;x1 = x1 + stepX;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ld HL, (line_x1)
	ld DE, (stepX)
	add HL, DE
	ld (line_x1), HL
;<-------------------------------------------------
; stepX is the answer found in HL
;<-------------------------------------------------	
	
	jp check_deltaY			;loop back again to check if error2 is greater than deltaY
