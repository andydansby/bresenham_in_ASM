DXDY_loop:

;	NOTE: since this is a loop
; 	avoid using jr

while1:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;plot the pixel x1, y1
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
	
	;call _joffa_pixel2
	; was call, but since plot is only called once
	; switch to jump
	jp _joffa_pixel2
end_Plot:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;if (x1 == x2 && y1 == y2)
;break
; suggested by Clive Townsend
; of the Z80 Assembly Programming On The 
; ZX Spectrum facebook group
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
compareX1X2:
	; if x1 == x2
	ld DE, (line_x1)
	ld HL, (line_x2)
	xor A ;clear carry flag
	sbc HL, DE
	jp nz, X1X2_Y1Y2_no_match
	;if x1 & X2 match, fall through

	; if y1 == y2
	ld DE, (line_y1)
	ld HL, (line_y2)
	; No need to clear carry, as previous result was zero (so no carry)
	sbc HL, DE
	;jp nz, X1X2_Y1Y2_no_match
	
	
	jp z, end_bresenham	;X1X2_Y1Y2_match: 
	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Line is now complete
;since both x1 & x2  and Y1 & y2 match
;the line is now finished drawing
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
X1X2_Y1Y2_no_match:		;
	;if the two do not match, then we are not finished we need the next position

error2_calc:
	ld HL, (error1)
	add HL, HL			;multiply HL by 2
	ld (error2), HL

check_deltaY:
	ld HL, (error2)
	ld DE, (deltaY)
	;xor A			;clear flags
	sbc HL, DE
	
	;if sign flag is OFF, then error2 is larger
	jp p, deltaY_case			;sign flag is OFF
	
	;if Zero flag is ON, then error2 is equal to deltaY
    jp z, deltaY_case
	
check_deltaX:
	;if not deltaY_case, then must be deltaX_case
	jp deltaX_case

finished_Delta_check:

	jp while1



