assume cs:code, ds:data
data segment
	a dw 55CAh
	b dw 0F0Fh
	c dw ?
data ends

code segment
start:
	mov ax,data
	mov ds,ax

	mov ax,a 
	and ax,0000000111100000b ;ax=0000.000a8.a7a6a50.0000
	shr ax,2 ;ax=0000.0000.0a8a7a6.a5000

	mov bx,b
	and bx,0000000000000111b ;bx=0000.0000.0000.0b2b1b0
	shl bx,7 ;bx=0000.00b2b1.b0000.0000
	
	mov cx,b
	and cx,0000001111100000b ;cx=0000.00b9b8.b7b6b50.0000
	shl cx,6 ;cx=b9b8b7b6.b5000.0000.0000
	
	or ax,bx ;ax=0000.00b2b1.b0a8a7a6.a5000
	or ax,cx ;ax=b9b8b7b6.b50b2b1.b0a8a7a6.a5000
	mov c,ax ;c=b9b8b7b6.b50b2b1.b0a8a7a6.a5000

	mov ax,4C00h
	int 21h
code ends
end start