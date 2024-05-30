;org $8080

line_x1:	defw 0000	;$8080	line start point X
line_y1:	defw 0000	;$8082	line start point Y
line_x2:	defw 0255 	;$8084	line end point X
line_y2:	defw 0171	;$8086	line end point Y

PUBLIC dx
	dx:			defw 0000;$8088
PUBLIC dy
	dy:			defw 0000;$808A
PUBLIC dxABS
	dxABS:      defw 0000;$808C
PUBLIC dyABS
	dyABS:      defw 0000;$808E

PUBLIC fraction			;$8094
fraction:	defw 0000

x1:	defw 0000			;$8094
x2:	defw 0000			;$8096
y1:	defw 0000			;$8098
y2:	defw 0000			;$809A

PUBLIC plot_x			;$809C
plot_x:		defb 00

PUBLIC plot_y			;$809D
plot_y:		defb 00


;fraction:	defw 0000
stepy:		defb 00		;$80A2
stepx:		defb 00		;$80A3

PUBLIC gfx_x			;$9264
gfx_x:		defw 0000

PUBLIC gfx_y			;$9266
gfx_y:		defw 0000





PUBLIC X_PositionBits	;$80A4
X_PositionBits:
defb 128,64,32,16,8,4,2,1
