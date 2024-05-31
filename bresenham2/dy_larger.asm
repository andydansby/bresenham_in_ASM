;org $8190

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; if (dy >= dx)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PUBLIC dyLarger
dyLarger:
;812D
;;;;;;;;;;;;;;;;;; 

DY_loop1:				;$9300
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;int fraction = 2 * dx - dy
;(2 * dx) - dy
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ld HL, (dxABS)
	add HL, HL			; multiply HL by 2
	ld DE, (dyABS)	
	sbc HL, DE			;subtract DX
	ld (fraction), HL
						;;answer in HL and pass to variable
end_inital_fraction_calculation2:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;while (y != y2)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DY_while:					;$920D
	ld HL, (line_y2)	;grab value of x2
	ld DE, (gfx_y)		;grab value of X
	sbc HL, DE			;check to see if X == X2
	
	jp z, end_DY_larger		;check to see if equal
							;if equal, break out of loop
							;10 t, 3 bytes
	
	;attention
	;jr z, end_DX_larger	;check to see if equal
							;if equal, break out of loop
							;12 t, 2 bytes
							;unfortunately, this is in a loop, 
							;so slower this way
						
	; if not then fall through
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;y += stepy;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
stepY_func:				;$9219

	ld A, (stepy)
	ld HL, (gfx_y)
	add A, L
	ld L, A
	ld (gfx_y), HL
	;;answer in HL and pass to variable
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;if (fraction >= 0)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
DY_fraction_funct:			;$9224
	xor A					;reset flags
	ld DE, (fraction)
	ld HL, 0000
	sbc HL, DE				;check to see if greater or equal

	;DO NOT store Fraction, only for comparasion against 0
	;Greater / Lesser or Equal
	
	;attention
	;jp z, DY_fraction_equal	;check to see if equal to 0
	;jp m, DY_fraction_greater	;jump if greater than 0
								; sign flag IS set
	;jp p, DY_fraction_lesser	;check to see if less than 0
								; sign flag is NOT set
								
	;instead, lets only check for lesser
	;and less anything other than less fall through
	;if not less, then it is greater or equal
	;save 6 bytes and 20 t states per loop
	jp p, DY_fraction_lesser	;check to see if less than 0
								; sign flag is NOT set
								
	;attention
	; don't need this at all, why keep it and save 3 bytes
	;jp DY_fraction_lesser		;just in case
								;not really needed

DY_fraction_equal:				;$9237
DY_fraction_greater:			;$9237
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
;x += stepx;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
stepY_DY:					;$9237
	;ld HL, (stepx)
	
	ld A, (stepx)
	ld H, $00
	ld L, A
	
	ld DE, (gfx_x)
	
	add HL, DE				;add Y + stepY
	ld (gfx_x), HL			;store the answer
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	;fraction -= 2 * dy;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DY_fraction:				;$9242
	ld HL, (dyABS)
	add HL, HL				;answer 2 * DY
	
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
	;jp DY_fraction_funct	;loop back to test if fraction 
							;is greater of equal to 0
							;10 t, 3 bytes
	;jr DY_fraction_funct	;12 t, 2 bytes
	;downside is that the loop runs slower
	; we spend more time in loop than anywhere else


end_DY_fraction:

	;attention moved
	jp DY_fraction_funct	;10 t, 3 bytes
	;loop back to test if fraction
	

	;jr DX_fraction_funct	;12 t, 2 bytes
	;downside is that the loop runs slower
	; we spend more time in loop than anywhere else
	
DY_fraction_lesser:		;$9255 will change

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	;fraction += 2 * dx;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ld HL, (dxABS)
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
	
	jp DY_while
	
	
end_DY_larger:
	jp end_bresenham

fin2: