	.MODEL SMALL
	.STACK   100h
	.DATA
MAS	DW	5, 2, 4
	DW	3, 1, 6
M	DW	2
N	DW	3

	.CODE
start:	mov AX,@data
	mov DS,AX
	mov SI,N ; число столбцов
	SAL SI,1 ; N*2 – длина строки
	mov BX,0
	mov CX,M ; число строк
C1:	push CX
	mov DI,0
	mov CX,N ; число столбцов
C2:	mov AH,2h
	mov DX,'0' ; символ в DL
	add DX,MAS[BX][DI]           
	;(DX) = 0030h
	int 21h
	inc DI
	inc DI 
	mov DX,' '
	int 21h
	loop C2
	pop CX
	add BX,SI ; + длина строки
	mov DX,0Dh ; возврат каретки ..?..
	int 21h        
	mov DX,0Ah ; перевод строки
	int 21h
	loop C1
	mov AH,4Ch
	int 21h
end start
	end
