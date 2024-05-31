;org $8110

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; if (dx > dy)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PUBLIC dxLarger
dxLarger:
;80BD
;;;;;;;;;;;;;;;;;;

DX_loop1:				;$9200
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;int fraction = 2 * dy - dx
;(2 * dy) - dx
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ld HL, (dyABS)
	add HL, HL			; multiply dyABS by 2
	ld DE, (dxABS)	
	sbc HL, DE			; subtract DX
	ld (fraction), HL
						;;answer in HL and pass to variable
end_inital_fraction_calculation1:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;while (x != x2)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DX_while:					;$920D
	ld HL, (line_x2)	;grab value of x2
	ld DE, (gfx_x)		;grab value of X
	sbc HL, DE			;check to see if X == X2
	
	jp z, end_DX_larger		;check to see if equal
							;if equal, break out of loop
							;10 t, 3 bytes
	;attention
	;jr z, end_DX_larger	;unfortunately, this is in a loop, 
							;so slower this way
						
	; if not then fall through
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;x += stepx;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
stepX_func:				;$9219

	ld A, (stepx)
	ld HL, (gfx_x)
	add A, L
	ld L, A
	ld (gfx_x), HL
	;;answer in HL and pass to variable

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;if (fraction >= 0)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DX_fraction_funct:			;$9224
	xor A					;reset flags
	ld DE, (fraction)
	ld HL, 0000
	sbc HL, DE				;check to see if greater or equal

	;attention
	;instead, lets only check for lesser
	;and less anything other than less fall through
	;if not less, then it is greater or equal
	;save 6 bytes and 20 t states per loop
	jp p, DX_fraction_lesser	;check to see if less than 0
								; sign flag is NOT set

	;attention
	; don't need this at all, why keep it and save 3 bytes
	;jp DX_fraction_lesser		;just in case
								;not really needed

DX_fraction_equal:				;$9237
DX_fraction_greater:			;$9237

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
;y += stepy; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
stepY_DX:					;$9237
	;ld HL, (stepy)
	
	ld A, (stepy)
	ld H, $00
	ld L, A
	
	ld DE, (gfx_y)
	
	add HL, DE				;add Y + stepY
	ld (gfx_y), HL			;store the answer 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	;fraction -= 2 * dx;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DX_fraction:				;$9242
	ld HL, (dxABS)
	add HL, HL				;answer 2 * DX
	
	;attention
	;move this to DE
	;push HL		;11t
	;pop DE			;10t
	;save some t states
	ld D, H			;4t
	ld E, L			;4t
	
	
	
	ld HL, (fraction)
	sbc HL, DE
	ld (fraction), HL
	
	;attention
	;jp DX_fraction_funct	;loop back to test if fraction 
							;is greater of equal to 0
							;10 t, 3 bytes
	;jr DX_fraction_funct	;12 t, 2 bytes
	;downside is that the loop runs slower
	; we spend more time in loop than anywhere else
	

end_DX_fraction:

	;attention
	jp DX_fraction_funct	;10 t, 3 bytes
	;loop back to test if fraction 
	
	
	;jr DX_fraction_funct	;12 t, 2 bytes
	;downside is that the loop runs slower
	; we spend more time in loop than anywhere else

DX_fraction_lesser:		;$9255 will change

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	;fraction += 2 * dy;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ld HL, (dyABS)
	add HL, HL			;answer 2 * DY
	ld DE, (fraction)
	
	add HL, DE			; add fraction answer in HL

	ld (fraction), HL

	; insert PLOT function here
	; loading a 16 bit variable into 8 bits
	; only because buffer will be 16 bits
	; for right now nothing over 191
	ld A, (gfx_y)
	ld (plot_y), A
	
	; loading a 16 bit variable into 8 bits
	; only because buffer will be 16 bits
	; for right now nothing over 191
	ld A, (gfx_x)
	ld (plot_x), A
	call _joffa_pixel2
	
	jp DX_while				;loop around again to check 
							;if x = x2

end_DX_larger:
	jp end_bresenham

fin1: