       .globl _tswitch
       .globl _main,_running,_scheduler,_proc0,_procSize
	
start:  mov  ax,cs
	  mov  ds,ax
	  mov  ss,ax
        mov  sp,#_proc0
	  add  sp,_procSize
	  call _main
        hlt
	
_tswitch:
SAVE: push ax
      push bx
      push cx
      push dx
      push bp
      push si
      push di
      pushf
      mov  bx,_running
      mov  2[bx],sp

FIND:	call _scheduler

RESUME: mov  bx,_running
	  mov  sp,2[bx]
        popf
        pop  di
        pop  si
        pop  bp
        pop  dx
        pop  cx
        pop  bx
        pop  ax
        ret
