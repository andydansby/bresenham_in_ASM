
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; in variables.asm
; you will find x1, y1, x2 and y2
; as
; line_x1, line_y1, line_x2, line_y2
; gfx_x, gfx_y as used exclusively for
; _joffa_pixel2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

start:
DX_step_start:
	ld HL, (line_x2)	; load point X2
    ld DE, (line_x1)	; load point X1
	xor A				; clear flags
    sbc HL, DE			; x2 - x1 answer in HL
	
	jr c, negativeDX	;if carry flag is set, then X2 is larger

	;fall through if positive
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
positiveDX:
    ld A, 1
    ld (stepX), A
	;DX_step_end:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
DY_step_start:
	ld HL, (line_y2)	; load point X2
    ld DE, (line_y1)	; load point X1
	xor A				; clear flags
    sbc HL, DE          ; x2 - x1 answer in HL
	
	jr c, negativeDY	;if carry flag is set, then Y2 is larger

	;fall through if positive
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
positiveDY:
    ld A, 1
    ld (stepY), A
	;DY_step_end:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

dx_abs_start:
	ld HL, (line_x2)	; load point X2
    ld DE, (line_x1)	; load point X1
	xor A				; clear flags
    sbc HL, DE          ; x2 - x1 answer in HL
	call absHL

	ld (deltaX),HL

dy_abs_start:
	ld HL, (line_y2)	; load point Y2
    ld DE, (line_y1)	; load point Y1
	xor A				; clear flags
    sbc HL, DE			; y2 - y1 answer in HL

	call absHL
	
invert_deltaY:
	; number is already in HL
	ex DE, HL			;swap  HL & DE
	ld HL, 0000
	sbc HL, DE
	ld (deltaY), HL


calculate_error1:
	ld DE, (deltaY)
	ld HL, (deltaX)
	
	add HL, DE			;dx + dy answer in HL
	ld (error1), HL

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;lets start our loop
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	jp DXDY_loop

end_bresenham:

ret
	
