
DXDY_loop:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	if (delta_x1 > delta_y1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;check for DeltaX
	ld HL, (deltaX)
	ld DE, (deltaY)
	xor A				; clear flags
    sbc HL, DE			; deltaX - deltaY 
	
	;if deltaX > deltaY
	jp p, deltaX_case
	
end_deltaX:
	
;check for DeltaY	
	;jp m, deltaY_larger_loop
	jp m, deltaY_case
	; if sign flag is set
	; then deltaY > deltaX
	
	;jp z, deltaY_larger_loop
	jp z, deltaY_case
	
	; if Zero flag is set
	; then deltaY == deltaX
end_deltaY:	
