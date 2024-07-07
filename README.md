# bresenham_in_ASM

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

This is a 16 bit version of Bresenham Line routine

To be used on screens larger that 256 pixels wide or tall

If your screen size is 256 pixels or less, then there are more efficient and smaller routines available.

still looking for additional optimizations, and if any additional are found, please let me know.

** I know that I could save some bytes and Tstates by "in-lining" the plot routine, 
but for my purposes, I'd rather not. This is because I'm going to substute with a
point routine to read pixels.

** Futher note, some of these routines have bugs in them, I'll be working them out eventually.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




conversion of Bresenham routine from C to Z80 ASM

Versions 1 to 3 are the same algorythm with each higher version a more optimized version of the prior

** Version 1 is 489 bytes.

** Version 2 is 456 bytes

** Version 3 is 443 bytes

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Versions 4 and 5 is a different algorythm altogether which are considerbly smaller than Versions 1-3

** Version 4 is 406 bytes

** Version 5 is 396 bytes

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


Versions 6 to 8 is a different algorythm altogether which are considerbly smaller than Versions 1-3

** Version 6 is 339 bytes

** Version 7 is 323 bytes

** Version 8 is 312 bytes
