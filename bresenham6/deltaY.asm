deltaY_case:			;08118H

	; this moves along the X axis
	
	; errors
	; when y1 = 0 and y2 = 5 OK
	; when y1 = 0 and y2 = 191 OK
	; when y1 = 5 and y2 = 0 ERROR
	
	;when x1 = 0 and x2 = 5 OK
	;when x1 = 0 and x2 = 255 OK

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;error1 += deltaY;
; error1 = error1 + deltaY
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	ld HL, (error1)
	ld DE, (deltaY)
	add HL, DE
	ld (error1), HL
;<-------------------------------------------------
; error1 is the answer found in HL
;<-------------------------------------------------

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;x1 += stepX;
	;x1 = x1 + stepX;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	ld HL, (line_x1)
;	ld DE, (stepX)
;	add HL, DE
;	ld (line_x1), HL
;<-------------------------------------------------
; stepX is the answer found in HL
;<-------------------------------------------------	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;x += stepx;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	ld A, (stepX)
	ld HL, (line_x1)
	add A, L
	ld L, A
	ld (line_x1), HL
;;answer in HL and pass to variable









	jp check_deltaX

	;OK