;d*(d+2*a)/(b*c)
;a,b,c - byte
;d - word

assume cs:code, ds:data

data segment
a db 11
b db -5
c db 8
d dw 14
rez dw ?
data ends

code segment
start:
	mov ax, data
	mov ds,ax

	mov al,a
	mov bl,2
	imul bl ;ax = 2*a
	add ax,d ;ax = d+2*a
	imul d ;dx:ax = d*(d+2*a)
	;mut din dx:ax in cx:bx
	mov cx,dx
	mov bx,ax ;cx:bx = d*(d+2*a)
	mov al,b
	imul c ;ax = b*c
	mov si,ax ;si = b*c
	;mut din cx:bx in dx:ax
	mov dx,cx
	mov ax,bx ;dx:ax = d*(d+2*a)
	;impart ce am in dx:ax la ce e in si
	idiv si
	;dx am restul si in ax am catul
	mov rez,ax;

	mov ax,4C00h
	int 21h
code ends
end start