cls

del 1output.tap

bas2tap -a10 -sloader loader.bas basloader.tap

pasmo -v --tap main.asm bresenham.tap bresenham.sym


copy /b basloader.tap + bresenham.tap  1output.tap

@del bresenham.tap
@del basloader.tap

pasmo --bin main.asm del_me.bin del_me.sym

rem forfiles /S /M del_me.bin /C "cmd /c echo @fsize"

@del del_me.bin
@del del_me.sym
