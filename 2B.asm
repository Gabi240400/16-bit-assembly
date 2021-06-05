assume cs:code, ds:data
data segment
	s dd 12345678h, 1A2B3C4Dh, 0FE98DC76h
	lung_s equ ($-s)/4
	d db lung_s dup (?)
data ends

code segment
start:
	mov ax,data
	mov ds,ax

	mov si,3
	mov di,0
	mov cx, lung_s
	repeta:
		mov al,byte ptr s[si]
		mov ah,0
		mov bl,3
		div bl ;in ah am restul, in al am catul
		cmp ah,0
		JNE nu_adauga
		mov al,byte ptr s[si]
		mov d[di],al
		inc di
		nu_adauga:
			add si,4
		loop repeta

	mov ax,4C00h
	int 21h
code ends
end start