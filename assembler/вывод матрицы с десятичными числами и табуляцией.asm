	.MODEL SMALL
	.STACK   100h
	.DATA
MAS	DW	25, 62, 100, 67
	DW	31, 51, 46, 1
	DW	14, 6, 5, 56
M	DW	3
N	DW	4

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
C2:	
	mov AH,2h
	push ax
	push cx
	push dx

	mov ax,MAS[BX][DI]	;Выводимое число в регисте AX
	push -1	;Сохраним признак конца числа
	mov cx,10	;Делим на 10
l:	xor dx,dx	;Очистим регистр dx
	div cx	;Делим на 10
	push dx	;Сохраним цифру
	cmp ax,0	;Остался 0?
	jne l	;нет -> продолжим
	mov ah,2h
l2:	pop dx	;Восстановим цифру
	cmp dx,-1	;Дошли до конца -> выход
	je ex
	add dl,'0'	;Преобразуем число в цифру
	int 21h	;Выведем цифру на экран
	jmp l2	;И продолжим

ex:
	pop dx
	pop cx
	pop ax

	inc DI
	inc DI 
	;mov DX,'\t'
	mov DX, 09
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
