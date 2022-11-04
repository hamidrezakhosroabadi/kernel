.globl  _main,_prints,_NSEC
.globl  _getc,_putc,_readfd,_setes,_inces,_error
		BOOTSEG  =  0x9800
		OSSEG    =  0x1000
		SSP      =  32*1024
		BSECTORS =  2

_start:
		mov ax, #BOOTSEG
		mov es, ax
		
		xor dx, dx
		xor cx, cx
		
		incb cl
		
		xor bx, bx
		
		movb ah, #2
		movb al, #BSECTORS
		
		int 0x13
		
		jmpi next, BOOTSEG

next:
		mov ax, cs
		mov ds, ax
		mov ss, ax
		mov sp, #SSP
		
		call _main
		
		jmpi 0, OSSEG

_getc:
		xorb ah, ah
		
		int 0x16
		
		ret

_putc:
		push bp
		
		mov bp, sp
		
		movb al, 4[bp]
		movb ah, #14
		
		int 0x10
		
		pop bp
		
		ret

_readfd:
		push bp
		
		mov bp, sp
		
		movb dl, #0x00
		movb dh, 6[bp]
		movb cl, 8[bp]
		
		incb cl
		
		movb ch, 4[bp]
		
		xor bx, bx
		
		movb ah, #0x02
		movb al, _NSEC
		
		int 0x13
		
		jb  _error
		
		pop bp
		
		ret

_setes:
		push bp
		
		mov bp, sp
		mov ax, 4[bp]
		mov es, ax
		
		pop bp
		
		ret

_inces:
		mov bx, _NSEC
		
		shl bx, #5
		
		mov ax, es
		
		add ax, bx
		
		mov es, ax
		
		ret

_error:
		push #msg
		
		call _prints
		
		int 0x19
		
msg:	.asciz "Error"



