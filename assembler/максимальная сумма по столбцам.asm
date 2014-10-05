	.model small
	.stack 100h
	.data
A	DB	9,2,3,1
	DB	4,5,6,2
	DB	7,8,9,3
N	EQU	3
M	EQU	4
;b	DB	m dup(?)
max	DB	0
column	DB	0
	.code
	.startup
	xor bx,bx
	;lea di,b
	mov cx,m
M2:	push cx
	xor al,al
	mov cx,n
	xor si,si
M1:	add al,a[bx+si]
	add si,m
	loop M1
	;mov [di],al


	cmp max,al
	ja m3
	mov max,al
	mov column,bl


m3:	inc di
	inc bx
	pop cx
	loop M2
	mov ah,4ch
	int 21h
	end
