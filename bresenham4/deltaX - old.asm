deltaX_case:

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
	
	
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;if (error2 <= deltaX)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;if (y1 == y2) 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;don't really need this check, saves 71 t states and 9 bytes
;	ld HL, (line_y1)		;load X1
;	ld DE, (line_y2)		;load X2
;	sbc HL, DE
;	jp z, finished_Delta_check		;if Zero flag is ON, then both are equal and break loop



	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;error1 = error1 += deltaY;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ld HL, (error1)
	ld DE, (deltaY)
	add HL, DE
	ld (error1), HL
;<-------------------------------------------------
; error1 is the answer found in HL
;<-------------------------------------------------
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;y1 = y1 + stepY;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ld HL, (line_y1)
	ld DE, (stepY)
	add HL, DE
	ld (line_y1), HL
;<-------------------------------------------------
; y1 is the answer found in HL
;<-------------------------------------------------	

	jp finished_Delta_check
	