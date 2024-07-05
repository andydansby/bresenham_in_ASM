;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; in variables.asm
; you will find x1, y1, x2 and y2
; as
; line_x1, line_y1, line_x2, line_y2
; gfx_x, gfx_y as used exclusively for
; _joffa_pixel2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

start:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;    delta_x1 = xx2 - xx1;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ld HL, (line_x2)	; load point X2
    ld DE, (line_x1)	; load point X1
    sbc HL, DE          ; x2 - x1 
	ld (deltaX), HL		; answer in HL

DX_step_start:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	stepx = (delta_x1 < 0) ? -1 : 1;
;if delta_x1 less   than 0 stepX = -1
;if delta_x1 larger than 0 stepX = 1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ld DE, 0000		; load 0 to check 
					; if deltaX is less
	xor A			; clear flags
    sbc HL, DE		; x2 - x1 
					; answer in HL
	
	jp m, negativeDX; if sign flag is set
	;sign flag is set if deltaX is negative

	;otherwise deltaX is positive
	;fall through if positive
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
positiveDX:
    ld A, 1
    ld (stepX), A
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DX_step_end:
;<------------------------------------------
; stepX has answer  1 if deltaX > 0
; stepX has answer -1 if deltaX <= 0
;<------------------------------------------

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;    delta_y1 = yy2 - yy1;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ld HL, (line_y2)	; load point Y2
    ld DE, (line_y1)	; load point Y1
    sbc HL, DE          ; y2 - y1 
	ld (deltaY), HL		; answer in HL

DY_step_start:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	stepy = (delta_y1 < 0) ? -1 : 1;
;if delta_y1 less than 0 stepX = -1
;if delta_y1 larger than 0 stepX = 1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ld DE, 0000			; load 0 to check 
	xor A				; clear flags
    sbc HL, DE          ; y2 - y1 
						; answer in HL

	jp m, negativeDY; if sign flag is set
	;sign flag is set if deltaX is negative

	;fall through if positive
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
positiveDY:
    ld A, 1
    ld (stepY), A
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DY_step_end:
;<------------------------------------------
; stepY has answer  1 if deltaY > 0
; stepY has answer -1 if deltaY <= 0
;<------------------------------------------

dx_abs_start:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	delta_x1 = Math.Abs(delta_x1);
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ld HL, (deltaX)		; load deltaX
	call absHL
	ld (deltaX), HL
;<------------------------------------------
; deltaX is the answer
;<------------------------------------------


dy_abs_start:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	delta_y1 = Math.Abs(delta_y1);
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ld HL, (deltaY)	; load point Y2
	call absHL
	ld (deltaY), HL
;<------------------------------------------
; deltaY is the answer
;<------------------------------------------

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
	
