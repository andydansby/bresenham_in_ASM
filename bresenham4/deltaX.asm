deltaX_case:			;080FFH

	; this moves along the Y axis
	
	; errors
	; when y1 = 0 and y2 = 5 OK
	; when y1 = 0 and y2 = 191 OK
	; when y1 = 5 and y2 = 0 ERROR
	
	;when x1 = 0 and x2 = 5 OK
	;when x1 = 0 and x2 = 255 OK
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;error1 += deltaX;
;error1 = error1 + deltaX;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ld HL, (error1)
	ld DE, (deltaX)
	add HL, DE
	ld (error1), HL
;<-------------------------------------------------
; error1 is the answer found in HL
;<-------------------------------------------------
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;y1 += stepY;
;y1 = y1 + stepY;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	ld HL, (line_y1)
;	ld DE, (stepY)
;	add HL, DE
;	ld (line_y1), HL
;<-------------------------------------------------
; y1 is the answer found in HL
;<-------------------------------------------------	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;x += stepx;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	ld A, (stepY)
	ld HL, (line_y1)
	add A, L
	ld L, A
	ld (line_y1), HL
;;answer in HL and pass to variable














	jp finished_Delta_check
	
	;NOT OK