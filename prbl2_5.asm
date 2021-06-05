assume cs:code, ds:data
data segment
	my_buffer db 100 dup (?)
	linie_noua db 10,13,'$'
data ends

code segment
start:
	mov ax,data
	mov ds,ax

	mov si,0 ;pentru adaugarea caracterelor in buffer
	citeste:
		mov ah,08h
		int 21h
		;al = codul ascii al caracterului citit
		cmp al,48
		JB adauga_buffer
		cmp al,57
		JA adauga_buffer
		;daca caracterul citit este cifra, il tiparesc
		mov dl,al
		mov ah,02h
		int 21h
		;daca caracterul citit nu este cifra il adaug in buffer
		JMP citeste
		adauga_buffer:
			mov my_buffer[si],al
			inc si
			cmp al,36
			JE end_citire
			JMP citeste
	;afisez bufferul
	end_citire:
		mov dx,offset linie_noua
		mov ah,09h
		int 21h
		mov dx,offset my_buffer
		int 21h
	mov ax,4C00h
	int 21h
code ends
end start