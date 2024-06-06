start:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; in variables.asm
; you will find x1, y1, x2 and y2
; as
; line_x1, line_y1, line_x2, line_y1
; gfx_x, gfx_y as used exclusively for
; _joffa_pixel2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


DX_step_start:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;int stepX = (x1 < x2) ? 1 : -1;
;if x1 larger stepX = -1
;if x2 larger stepX = 1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ld HL, (line_x2)	; load point X2
    ld DE, (line_x1)	; load point X1
	xor A				; clear flags
    sbc HL, DE			; x2 - x1 answer in HL
	
	;if carry flag is set, then X2 is larger
	jr c, negativeDX	;12/7 t, 2 bytes

	;fall through if positive
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
positiveDX:
    ld A, 1
    ld (stepX), A
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
DX_step_end:
;<-------------------------------------------------
; stepX has answer -1 if X2 is larger
; stepX has answer  1 if X1 is larger or equal
;<-------------------------------------------------


DY_step_start:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;int stepY = (y1 < y2) ? 1 : -1;
;if y1 larger stepY = -1
;if y2 larger stepY = 1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ld HL, (line_y2)	; load point X2
    ld DE, (line_y1)	; load point X1
	xor A				; clear flags
    sbc HL, DE          ; x2 - x1 answer in HL

	;if carry flag is set, then Y2 is larger
	jr c, negativeDY	;12/7 t, 2 bytes

	;fall through if positive
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
positiveDY:
    ld A, 1
    ld (stepY), A
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DY_step_end:
;<-------------------------------------------------
; stepY has answer -1 if Y2 is larger
; stepY has answer  1 if Y1 is larger or equal
;<-------------------------------------------------

dx_abs_start:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; int dx = abs(x2 - x1);
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ld HL, (line_x2)	; load point X2
    ld DE, (line_x1)	; load point X1
	xor A				; clear flags
    sbc HL, DE          ; x2 - x1 answer in HL
	
	call absHL
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; dx = abs(dx);
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ld (deltaX),HL

;<-------------------------------------------------
; dxABS is the answer int dx = Math.Abs(x2 - x1);
;<-------------------------------------------------

dy_abs_start:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; int dy = abs(y2 - y1);
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ld HL, (line_y2)	; load point Y2
    ld DE, (line_y1)	; load point Y1
	xor A				; clear flags
    sbc HL, DE			; y2 - y1 answer in HL

	call absHL
;<-------------------------------------------------
; deltaY is the answer int dy = Math.Abs(y2 - y1);
;<-------------------------------------------------

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; deltaY = -abs(deltaY);
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
invert_deltaY:
	; number is already in HL
	ex DE, HL			;swap  HL & DE
	ld HL, 0000
	sbc HL, DE
	ld (deltaY), HL


calculate_error1:		;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;int error1 = deltaX + deltaY;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ld DE, (deltaY)
	ld HL, (deltaX)
	
	add HL, DE			;dx + dy answer in HL
	ld (error1), HL
;<-------------------------------------------------
; error1 is the answer
;<-------------------------------------------------

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;finished initializing variables
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;lets start our loop
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	jp DXDY_loop


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Line is now complete
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
end_bresenham:

ret
	
