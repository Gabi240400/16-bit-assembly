assume cs:code, ds:data
data segment
	s dd 12345678h, 1A2B3C4Dh, 0FE98DC76h, 0AE432111h
	lung_s equ ($-s)/4
	d db lung_s dup (?)
data ends

code segment
start:
	mov ax,data
	mov ds,ax
	mov es,ax
	
	mov si,offset s
	add si,3
	mov di,offset d
	mov cx,lung_s
	cld
	repeta:
		lodsb ;al=[si],inc si
		dec si
		mov ah,0
		mov bl,3
		div bl ;in ah am restul, in al am restul
		cmp ah,0
		JNE nu_adauga
		movsb ;[di]=[si],inc si,inc di
		add si,3
		JMP fin
		nu_adauga:
			add si,4
		fin:
		loop repeta

	mov ax,4C00h
	int 21h
code ends
end start