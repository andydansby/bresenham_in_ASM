# bresenham_in_ASM

conversion of Bresenham routine from C to Z80 ASM

Versions 1 to 3 are the same algorythm with each higher version a more optimized version of the prior

** Version 1 is 489 bytes.

** Version 2 is 456 bytes

** Version 3 is 443 bytes

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Versions 4 and 5 are different algorythms altogether which are considerbly smaller than Versions 1-3

** Version 4 is 339 bytes

** Version 5 is 323 bytes

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Version 6 is a different algorythm

** Version 6 is 416 bytes
<ATTENTION> version 6 is buggy.  
line_x1:	defw 20	;$8080 line start pointX
line_y1:	defw 30	;$8082 line start pointY
line_x2:	defw 10	;$8084 line end point X
line_y2:	defw 21	;$8086 line end point Y
crashes
