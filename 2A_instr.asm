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
	mov es,ax

	mov si,offset s1
	mov di,offset d
	mov cx, lung_s1
	cld
	repeta_s1:
		movsb ;[di] = [si], inc si, inc di
		loop repeta_s1
	mov si, offset s2
	add si, lung_s2-1
	mov cx, lung_s2
	repeta_s2:
		std
		lodsb ;al = [si], dec si
		cld
		stosb ;[di] = al, inc di
		loop repeta_s2
	
	mov ax,4C00h
	int 21h
code ends
end start