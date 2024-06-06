
line_x1:	defw 0	;$8080	line start point X
line_y1:	defw 0	;$8082	line start point Y
line_x2:	defw 5 	;$8084	line end point X
line_y2:	defw 1	;$8086	line end point Y


	
deltaX:		defw 0000;
deltaY:		defw 0000;

error1:		defw 0000;
error2:		defw 0000;

stepX:		defb 00;	was defb
stepY:		defb 00;	was defb


;	deltaX_case		80F5H
;	deltaY_case		810EH

;case 1		0	0	0	5		deltaX_case
;case 2		0	0	5	0		deltaY_case
;case 3		0	0	5	5		deltaX_case & deltaY_case
;case 4		0	5	0	0		deltaX_case
;case 5		0	5	0	5		goes no where
;case 6		0	5	5	0		deltaY_case & deltaX_case
;case 7		0	5	5	5		deltaY_case
;case 8		5	0	0	0		deltaY_case
;case 9		5	0	0	5		deltaY_case & deltaX_case
;case 10	5	0	5	0		goes no where
;case 11	5	0	5	5		deltaX_case 
;case 12	5	5	0	0		deltaY_case & deltaX_case
;case 13	5	5	0	5		deltaY_case
;case 14	5	5	5	0		deltaX_case



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;used for Joffa Pixel
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PUBLIC plot_x			;
plot_x:		defb 00

PUBLIC plot_y			;
plot_y:		defb 00

;gfx_x:		defw 0000
;gfx_y:		defw 0000

PUBLIC X_PositionBits	;
X_PositionBits:
defb 128,64,32,16,8,4,2,1




end_of_everything:


