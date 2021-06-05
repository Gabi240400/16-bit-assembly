assume cs:code, ds:data
data segment
	s1 db 1,2,3,4
	lung_s1 equ $-s1
	s2 db 5,6,7
	lung_s2 equ $-s2
	d db lung_s1+lung_s2 dup (?)
data ends

code segment
start:
	mov ax,data
	mov ds,ax

	mov si,0
	mov di,0
	mov cx, lung_s1
	repeta_s1:
		mov al,s1[si]
		mov d[di], al
		inc di
		inc si
		loop repeta_s1
	mov si, lung_s2-1
	mov cx, lung_s2
	repeta_s2:
		mov al,s2[si]
		mov d[di], al
		inc di
		dec si
		loop repeta_s2

	mov ax,4C00h
	int 21h
code ends
end start