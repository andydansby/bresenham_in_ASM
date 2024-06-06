deltaY_case:			;0810EH
;moves via the X Axis
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;error1 += deltaY;		; error1 = error1 + deltaY
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	ld HL, (error1)
	ld DE, (deltaY)
	add HL, DE
	ld (error1), HL
;<-------------------------------------------------
; error1 is the answer found in HL
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
