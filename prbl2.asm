;2/(a+b*c-9)+e-d
;a,b,c - byte
;d,e - doubleword

assume cs:code, ds:data

data segment
a db 11
b db -5
c db 8
d dd 15
e dd -20
rez dd ?
data ends

code segment
start:
	mov ax, data
	mov ds,ax

	mov al,b
	imul c ;ax=b*c
	mov bx,ax ;bx=b*c
	mov al,a
	cbw ;ax=a
	add ax,bx ;ax=a+b*c
	sub ax,9 ;ax=a+b*c-9
	mov bx,ax ;bx=a+b*c-9
	mov ax,2
	mov dx,0
	idiv bx 
	;in dx am restul si in ax catul
	cwd ;dx:ax=2/(a+b*c-9)
	;mut e in cx:bx
	mov bx,word ptr e+0
	mov cx,word ptr e+2 ;cx:bx=e
	clc
	add ax,bx
	adc dx,cx ;dx:ax=dx:ax+cx:bx=2/(a+b*c-9)+e
	;mut d in cx:bx
	mov bx,word ptr d+0
	mov cx,word ptr d+2 ;cx:bx=d
	clc
	sub ax,bx
	sbb dx,cx ;dx:ax=dx:ax-cx:bx=2/(a+b*c-9)+e-d
	;mut dx:ax in rez
	mov word ptr rez+0,ax
	mov word ptr rez+2,dx ;rez=2/(a+b*c-9)+e-d

	mov ax,4C00h
	int 21h
code ends
end start