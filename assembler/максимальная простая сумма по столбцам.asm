;Лабораторная работа №1
;Тема №1 - номер столбца с мах суммой простых чисел
;Выполнили студенты ДКО-201 Захарченко, Снегина
;A	исходный массив
;N	количество строк
;M	количество столбцов
;max	максимальная найденная сумма
;column	номер столбца с максимальной суммой, отсчет с 0
;two	2

	.model small
	.stack 100h
	.data
A	DB	29,2,3,17
	DB	4,5,6,2
	DB	7,8,9,3
N	EQU	3
M	EQU	4
max	DB	0
column	DB	0
two	EQU	2
	.code
	.startup
	xor bx,bx
	mov cx,m
M2:	push cx
	xor al,al
	mov cx,n
	xor si,si
M1:	;before adding we must to check is numer prime
	;let's check it here
	;if number is 2, it's prime
	cmp a[bx+si],two
	jne notwo
	add al,a[bx+si] ;accumulating sum
	jmp ok

	;if it isn't 2
	;preparing
notwo:	push CX
	xor CX,CX
	push DX
	xor DX,DX

	push AX
	xor AX,AX
	mov al, a[bx+si] ; cheching for the prime

	push BX
	xor BX,BX


	Mov	dl, al
	Xor	ch,ch	
	mov	cl, al
	Shr	cx,1
	Mov	bl, 2
ckl: 	Mov	al, dl
	Cbw
	Div	bl
	Cmp	ah, 0
	Je	no
	Inc	bl
	Cmp	bl, cl
	jle	ckl
	;if number is prime
	pop BX
	pop AX
	add al,a[bx+si] ;accumulating sum
	pop DX
	pop CX
	jmp ok
	
	;if isnt't prime
no:	pop BX
	pop AX
	pop DX
	pop CX

ok:	add si,m
	loop M1

	cmp max,al
	ja M3
	mov max,al
	mov column,bl


M3:	inc bx
	pop cx
	loop M2
	mov ah,4ch
	int 21h
	end
