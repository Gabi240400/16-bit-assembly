assume cs:code, ds:data
data segment
	s dw -10,21,-3,4
	lung_s equ ($-s)/2
	d db lung_s dup (?)
	contor db ?

data ends

code segment
start:
	mov ax,data
	mov ds,ax

	mov si,0
	mov di,0
	mov cx,lung_s

	repeta:
		mov ax,s[si]
		shl ax,1 ;in cf am bitul de semn	
		JNC nr_pozitiv
		JC nr_negativ
		nr_pozitiv:
			mov ax,s[si]
			mov dx,cx ;mut valoare lui cx in dx ca sa pot face alt loop
			mov cx,16
			mov contor,0
			repeta_poz:
				rol ax,1
				JNC bitul_este_0
				add contor,1
				bitul_este_0:
				loop repeta_poz
			mov bl,contor
			mov d[di],bl
			JMP final_loop
		nr_negativ:
			mov ax,s[si]
			mov dx,cx ;mut valoare lui cx in dx ca sa pot face alt loop
			mov cx,16
			mov contor,0
			repeta_neg:
				rol ax,1
				JC bitul_este_1
				add contor,1
				bitul_este_1:
				loop repeta_neg
			mov bl,contor
			mov d[di],bl
		final_loop:
			mov cx,dx ;pun inapoi in cx valoarea pt loop-ul mare
			add si,2
			inc di
		loop repeta
	mov ax,4C00h
	int 21h
code ends
end start