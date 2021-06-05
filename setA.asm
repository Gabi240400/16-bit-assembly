assume cs:code, ds:data
data segment
	s db 1,2,3,4,5
	lung_s equ $-s
	d dw lung_s-1 dup (?)
data ends

code segment
start:
	mov ax,data
	mov ds,ax

	mov si,0
	mov di,0
	mov cx, lung_s-1

	repeta:
		mov al,s[si]
		inc si
		mov bl,s[si]
		mul bl ;ax=s[si]*s[si+1]
		mov d[di],ax
		add di,2	
	loop repeta
	mov ax,4C00h
	int 21h
code ends
end start