
start:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; in variables.asm
; you will find x1, y1, x2 and y2
; as
; line_x1, line_y1, line_x2, line_y1
; gfx_x, gfx_y as used exclusively for
; _joffa_pixel2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;plot the first pixel x1, y1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	; loading a 16 bit variable into 8 bits
	; only because buffer will be 16 bits
	; for right now nothing over 191
	ld A, (line_y1)
	ld (plot_y), A
	
	; loading a 16 bit variable into 8 bits
	; only because buffer will be 16 bits
	; for right now nothing over 191
	ld A, (line_x1)
	ld (plot_x), A
	
	call _joffa_pixel2
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; int x = x1;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ld HL, (line_x1)
	ld (gfx_x), HL

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; int y = y1;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ld HL, (line_y1)
	ld (gfx_y), HL


dx_abs_start:		;#800F
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;int dx = Math.Abs(x2 - x1);
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;xor a				;clear flags
	ld HL, (line_x2)     ; load point X2
    ld DE, (line_x1)     ; load point X1
    sbc HL, DE          ; x2 - x1 answer in HL
	
	call absHL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;dx = abs(dx);
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ld (dxABS),HL
;<---------------------
; dxABS is the answer int dx = Math.Abs(x2 - x1);
dx_abs_end:

dy_abs_start:		;$8021
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;int dy = Math.Abs(y2 - y1);
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;xor a				;clear flags
	ld HL, (line_y2)     ; load point Y2
    ld DE, (line_y1)     ; load point Y1
    sbc HL, DE          ; y2 - y1 answer in HL

	call absHL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;dx = abs(dx);
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ld (dyABS),HL
;<---------------------
; dyABS is the answer int dy = Math.Abs(y2 - y1);



dx_step_start:		;$8033
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;int stepx = (x1 < x2) ? 1 : -1;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ld HL, (line_x2)     ; load point X2
    ld DE, (line_x1)     ; load point X1
    sbc HL, DE          ; x2 - x1 answer in HL
	
	;if carry flag is set, then X2 is larger
	;jp c, negativeDX	;10 t, 3 bytes
	jr c, negativeDX	;12/7 t, 2 bytes

	;else X1 is larger or equal
	;jp positiveDX		;10 t, 3 bytes
	;jr positiveDX		;12 t, 2 bytes
	;attention eliminated
	;fall through if positive

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;attention moved
positiveDX:
    ld A, 1
    ld (stepx), A
    ;jp dx_step_end		;10 t, 3 bytes
	;jr dx_step_end		;12 t, 2 bytes
	;attention eliminated, fall through
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	
dx_step_end:
;<-------------------------------------------------
; stepx has answer -1 if X2 is larger
; stepx has answer  1 if X1 is larger or equal
;<-------------------------------------------------

dy_step_start:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;int stepy = (y1 < y2) ? 1 : -1;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ld HL, (line_y2)     ; load point X2
    ld DE, (line_y1)     ; load point X1
    sbc HL, DE          ; x2 - x1 answer in HL

	;if carry flag is set, then Y2 is larger
	;jp c, negativeDY	;10 t, 3 bytes
	jr c, negativeDY	;12/7 t, 2 bytes

	;else Y1 is larger or equal
	;jp positiveDY		;10 t, 3 bytes
	;jr positiveDY		;12 t, 2 bytes
	;attention, eliminated
	;fall through
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
positiveDY:
    ld A, 1
    ld (stepy), A
    ;jp dy_step_end		;10 t, 3 bytes
	;jr dy_step_end		;12 t, 2 bytes
	;attention, eliminated
	;fall through
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	
	
	
dy_step_end:
;<-------------------------------------------------

DXorDY_start:		;$805D
	xor a				;clear flags
	ld HL, (dyABS)
	ld DE, (dxABS)
	sbc HL, DE          ; DX - DY answer in HL
	
	jp m, dxLarger		;check to see if greater
						; sign flag IS set
						;$9200
							
	jp p, dyLarger		;check to see if lesser
						; sign flag NOT set
						;$9300

	
	;jr z, dyLarger		;12/7 t, 2 bytes
	jp z, dyLarger		;check to see if equal
						;if so the DY larger
						;$9300


end_bresenham:
;	jr end_bresenham


ret
	
