;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
negativeDX:
    ld A, -1
    ld (stepX), A
    ;jp dx_step_end		;10 t, 3 bytes
	jr DX_step_end		;12 t, 2 bytes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
negativeDY:
    ld A, -1
    ld (stepY), A
    ;jp dy_step_end		;10 t, 3 bytes
	jr DY_step_end		;12 t, 2 bytes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;from http://z80-heaven.wikidot.com/math#toc12
absHL:
    bit 7,h
    ret z
    
    xor A
    sub L
    ld L, A
    sbc A, A
    sub H
    ld H, A
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;optimized by andy dansby
;using DE/HL
PUBLIC _joffa_pixel2
_joffa_pixel2:

    ;ld de, (_gfx_xy)
	ld A, (plot_x)
	ld E, A
	ld A, (plot_y)
	ld D, A

    rrca
    rrca
    rrca

    and %00011000   ;24 = 0x18
    or  %01000000   ;64 = 0x40

    ld H, A
    ld A, D
    and 7
    or H
    ld H, A

    ld A, D
    add A, A
    add A, A
    and %11100000
    ld L, A

    ld A, E
    rrca
    rrca
    rrca
	and %00011111

    or L
    ld L, A  ; hl = screen address.

    ld A, E
    and 7

    ld de, X_PositionBits
    add A, E
    ld E, A
    ld A, (DE)

    ;output to screen
    or (HL)
    ld (HL), A
	
	;jp end_Plot		
	;was ret
	;replaced because the plot is only called once
	
ret

endJoffa:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


Plot_a_Pixel:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;plot a pixel x1, y1
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
	
	jr _joffa_pixel2
ret



















