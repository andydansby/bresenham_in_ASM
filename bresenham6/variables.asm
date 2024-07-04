
;fails at DX majority
;line_x1 = 20
;line_y1 = 30
;line_x2 = 10
;line_y2 = 21

;fails at DY majority
;line_x1 = 30
;line_y1 = 20
;line_x2 = 21
;line_y2 = 10



line_x1:	defw 20	;$8080 line start pointX
line_y1:	defw 30	;$8082 line start pointY
line_x2:	defw 17	;$8084 line end point X
line_y2:	defw 27	;$8086 line end point Y

	
deltaX:		defw 0000;
deltaY:		defw 0000;
stepX:		defb 00;	was defb
stepY:		defb 00;	was defb
error1:		defw 0000;
error2:		defw 0000;


gfx_x:		defw 0000
gfx_y:		defw 0000

fraction:	defw 0000

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;used for Joffa Pixel
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PUBLIC plot_x			;
plot_x:		defb 00

PUBLIC plot_y			;
plot_y:		defb 00

PUBLIC X_PositionBits	;
X_PositionBits:
defb 128,64,32,16,8,4,2,1




end_of_everything:




;pasmo --bin main.asm del_me.bin del_me.sym
;forfiles /S /M del_me.bin /C "cmd /c echo @fsize"

;@del del_me.bin
;@del del_me.sym