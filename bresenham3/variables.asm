;org $8080

line_x1:	defw 0000	;	line start point X
line_y1:	defw 0015	;	line start point Y
line_x2:	defw 0255 	;	line end point X
line_y2:	defw 0165	;	line end point Y


PUBLIC dxABS
	dxABS:      defw 0000
PUBLIC dyABS
	dyABS:      defw 0000;

PUBLIC fraction			;
fraction:	defw 0000

PUBLIC plot_x			;
plot_x:		defb 00

PUBLIC plot_y			;
plot_y:		defb 00

stepy:		defb 00		;
stepx:		defb 00		;

PUBLIC gfx_x			;
gfx_x:		defw 0000

PUBLIC gfx_y			;
gfx_y:		defw 0000


PUBLIC X_PositionBits	;
X_PositionBits:
defb 128,64,32,16,8,4,2,1

;not used
;dx:
;dy:

;x1:	defw 0000
;x2:	defw 0000
;y1:	defw 0000
;y2:	defw 0000


end_of_everything:
