org	$8000

include "bresenham.asm"
include "routines.asm"
include "DXDY.asm"
include "deltaX.asm"
include "deltaY.asm"
include "variables.asm"

;before optimization 1 491 bytes

;	"bresenham.asm"	starts @ $8000
;	"routines.asm"	starts @ $806D
;	"dx_larger.asm"	starts @ $80C7
;	"dy_larger.asm"	starts @ $8144
;	"variables.asm"	starts @ $81C1

; end_of_everything $81EB before optimization 1
; 491 bytes

; end_of_everything $81BB after optimization 3
; 443 bytes

;now at 431 bytes