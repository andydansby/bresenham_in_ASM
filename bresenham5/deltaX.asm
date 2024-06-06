deltaX_case:			;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;error1 += deltaX;		;error1 = error1 + deltaX;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ld HL, (error1)
	ld DE, (deltaX)
	add HL, DE
	ld (error1), HL
;<-------------------------------------------------
; error1 is the answer found in HL
;<-------------------------------------------------

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;y += stepy;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	ld A, (stepY)
	ld HL, (line_y1)
	add A, L
	ld L, A
	ld (line_y1), HL
;;answer in HL and pass to variable

	jp finished_Delta_check
