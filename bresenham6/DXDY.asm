
DXDY_loop:				;$8093

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	if (delta_x1 > delta_y1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	ld HL, (deltaX)
	ld DE, (deltaY)
	xor A				; clear flags
    sbc HL, DE			; deltaX - deltaY 
	
	;if deltaX > deltaY
	jp p, deltaX_case
	
end_deltaX:
	
	
	;jp m, deltaY_larger_loop
	jp m, deltaY_case
	; if sign flag is set
	; then deltaY > deltaX
	
	;jp z, deltaY_larger_loop
	jp z, deltaY_case
	
	; if Zero flag is set
	; then deltaY == deltaX
end_deltaY:	



	; if sign flag is NOT set
	; then deltaX > deltaY


;deltaY_larger_loop:
;	jp deltaY_larger_loop

;deltaX_larger_loop:
;	jp deltaX_larger_loop
	
endless:
	jp endless

