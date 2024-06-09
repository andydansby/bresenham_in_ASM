
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;while (1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DXDY_loop:				;$80C1

while1:


;plot(x1, y1)
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
	xor a ;clear carry flag
	sbc HL, DE
	jp nz, X1X2_Y1Y2_no_match
	;if x1 & X2 match, fall through

	; if y1 == y2
	ld DE, (line_y1)
	ld HL, (line_y2)
	; No need to clear carry, as previous result was zero (so no carry)
	sbc HL, DE
	jp nz, X1X2_Y1Y2_no_match
	
X1X2_Y1Y2_match:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;break
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	jp end_bresenham

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
X1X2_Y1Y2_no_match:		;
	;if the two do not match, then we are not finished we need the next position
	;fall through



error2_calc:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;error2 = 2 * error1;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ld HL, (error1)
	add HL, HL			;multiply HL by 2
	ld (error2), HL
;<-------------------------------------------------
; error2 is the answer
;<-------------------------------------------------


check_deltaY:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;if (error2 >= deltaY)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
	ld HL, (error2)
	ld DE, (deltaY)
	;xor A			;clear flags
	sbc HL, DE
	
	;if sign flag is OFF, then error2 is larger
	jp p, deltaY_case			;sign flag is OFF
	
	;if Zero flag is ON, then error2 is equal to deltaY
    jp z, deltaY_case
	
	;is sign flag is ON, then deltaY is larger
	;jp m, deltaY_larger		;sign flag is ON
	;optimized out, just fall through
	

deltaY_larger:
check_deltaX:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;if (error2 <= deltaX)
;if (deltaX >= error2)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ld HL, (deltaX)
	ld DE, (error2)
	;xor A			;clear flags
	sbc HL, DE

	;if sign flag is OFF, then error2 is larger
	jp p, deltaX_case			;sign flag is OFF
	
	;if Zero flag is ON, then error2 is equal to deltaY
    jp z, deltaX_case
	
	;is sign flag is ON, then deltaY is larger
	;jp m, finished_Delta_check		;sign flag is ON
	;optimized out, just fall through

finished_Delta_check:

	jp while1

