	.MODEL SMALL
	.STACK   100h
	.DATA
MAS	DW	12 DUP (?)
M	DW	3
N	DW	4

	.CODE
start:	
	mov AX,@data
	mov DS,AX
	mov AX,n
	xor AH,AH
	mul m
	mov CX,AX ;=m*n
input:
	push CX

;;;
	mov    DI,  0                  ; очистка регистра DI для результата
	; ввод числа
impt:	mov   AH, 08h; ф-ция ввода символа без эха
	int      21h
	cmp    AL,  13               ; нажата ли клавиша <enter> ?
	je       done                    ; да, ввод числа закончен
	cmp    AL, '9'               ; цифровой символ ?
	ja        impt                    ; нет, на повторный ввод
	cmp    AL,  '0'              ; цифровой символ ?
	jb        impt                    ; нет, на повторный ввод  
	; введен очередной цифровой символ, выведем его на экран
	mov   AH,  02h             ; ф-ция вывода символа
	mov   DL,  AL              ; символ должен быть в DL
	int     21h
	sub    AL,  '0'                ; преобразуем символ в двоичное число
	xor   AH,  AH                ;  обнулим AH
	mov   CX,  AX              ; сохраним полученную цифру в CX
	mov   AX,  DI               ; результат преобразования предыдущих введенных цифр     
	mov   BX,  10                ; множитель 10
	mul    BX                       ; (AX) * 10
	add     AX,  CX              ; добавляем новую цифру
	mov    DI,  AX               ; сохраняем число в DI
	jmp     impt                     ; на ввод следующей цифры
done:	                
	mov MAS[SI],DI ; результат в DI
	inc SI
	inc SI

	mov   AH,  02h
	mov   DL,  0Ah ;перевод строки 
	int      21h

	pop CX
	LOOP input



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
