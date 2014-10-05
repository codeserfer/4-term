;Лабораторная работа №3
;Тема №1 - номер столбца с мах суммой простых чисел
;Выполнили студенты ДКО-201 Захарченко, Снегина


﻿	.MODEL SMALL
	.STACK   100h
	.DATA
MAS	DW	25 DUP (?)
M	DW	?
N	DW	?
Msg1	DB	'Input n',13,10,'$'
Msg2	DB	'Input m',13,10,'$'
Msg3	DB	' ',13,10,'$'
max	DB	0
column	DB	0
two	EQU	2
one	EQU	1
	.CODE
start:
	mov AX,@data
	mov DS,AX

	;printing "input n"
	mov ah,9
	mov dx,OFFSET Msg1
	int 21h 
	;printing "input n"


	;inputing n
	mov    DI,  0                  ; очистка регистра DI для результата
	; ввод числа
impt1:	mov   AH, 08h; ф-ция ввода символа без эха
	int      21h
	cmp    AL,  13               ; нажата ли клавиша <enter> ?
	je       done1                    ; да, ввод числа закончен
	cmp    AL, '9'               ; цифровой символ ?
	ja        impt1                    ; нет, на повторный ввод
	cmp    AL,  '0'              ; цифровой символ ?
	jb        impt1                    ; нет, на повторный ввод  
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
	jmp     impt1                     ; на ввод следующей цифры
done1:	                
	mov m,DI ; результат в DI

	mov   AH,  02h
	mov   DL,  0Ah ;перевод строки 
	int      21h
	;inputing n

	;printing "input m"
	mov ah,9
	mov dx,OFFSET Msg2
	int 21h 
	;printing "input m"


	;inputing m
	mov    DI,  0                  ; очистка регистра DI для результата
	; ввод числа
impt2:	mov   AH, 08h; ф-ция ввода символа без эха
	int      21h
	cmp    AL,  13               ; нажата ли клавиша <enter> ?
	je       done2                    ; да, ввод числа закончен
	cmp    AL, '9'               ; цифровой символ ?
	ja        impt2                    ; нет, на повторный ввод
	cmp    AL,  '0'              ; цифровой символ ?
	jb        impt2                    ; нет, на повторный ввод  
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
	jmp     impt2                     ; на ввод следующей цифры
done2:	                
	mov n,DI ; результат в DI

	mov   AH,  02h
	mov   DL,  0Ah ;перевод строки 
	int      21h
	;inputing m



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
	mov DX, 09 ;\t
	int 21h
	loop C2
	pop CX
	add BX,SI ; + длина строки
	mov DX,0Dh ; возврат каретки ..?..
	int 21h        
	mov DX,0Ah ; перевод строки
	int 21h
	loop C1

;working with matrix
	xor bx,bx
	mov cx,m
M2:	push cx
	xor al,al
	mov cx,n
	xor si,si
M1:	;before adding we must to check is numer prime
	;let's check it here
	;if number is 2, it's prime
	;if number is 1, it isn't prime

	cmp mas[bx+si],one
	jne noone
	mov mas[bx+si],4
	


noone:	cmp mas[bx+si],two
	jne notwo
	add ax,mas[bx+si] ;accumulating sum
	jmp ok

	;if it isn't 2
	;preparing
notwo:	push CX
	xor CX,CX
	push DX
	xor DX,DX

	push AX

	xor AX,AX
	mov ax, mas[bx+si] ; cheching for the prime

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
	add ax,mas[bx+si] ;accumulating sum
	pop DX
	pop CX
	jmp ok
	
	;if isnt't prime
no:	pop BX
	pop AX
	pop DX
	pop CX

ok:	add si,m
	add si,m
	loop M1

	cmp max,al
	ja M3
	mov max,al
	mov column,bl


M3:	inc bx
	inc bx
	pop cx
	loop M2


;;
	;printing max
	xor ax,ax
	mov	al,max	;Выводимое число в регисте AX
	push	-1	;Сохраним признак конца числа
	mov	cx,10	;Делим на 10
lmax:	mov	dx,0	;Очистим регистр dx (xor dx,dx - оптимальнее)
	div	cx	;Делим 
	push	dx	;Сохраним цифру
	cmp	ax,0	;Остался 0? (оптимальнее or ax,ax)
	jne	lmax	;нет -> продолжим
	mov	ah,2h
l2max:	pop	dx	;Восстановим цифру
	cmp	dx,-1	;Дошли до конца -> выход {оптимальнее: or dx,dx jl ex}
	je	exmax
	add	dl,'0'	;Преобразуем число в цифру
	int	21h	;Выведем цифру на экран
	jmp	l2max	;И продолжим
exmax:	mov	ax,4c00h;Выход 
	;printing max


	;printing " "
	mov ah,9
	mov dx,OFFSET Msg3
	int 21h 
	;printing " "

	shr column,1
	;printing column
	xor ax,ax
	mov	al,column	;Выводимое число в регисте AX
	push	-1	;Сохраним признак конца числа
	mov	cx,10	;Делим на 10
lcolumn:	mov	dx,0	;Очистим регистр dx (xor dx,dx - оптимальнее)
	div	cx	;Делим 
	push	dx	;Сохраним цифру
	cmp	ax,0	;Остался 0? (оптимальнее or ax,ax)
	jne	lcolumn	;нет -> продолжим
	mov	ah,2h
l2column:	pop	dx	;Восстановим цифру
	cmp	dx,-1	;Дошли до конца -> выход {оптимальнее: or dx,dx jl ex}
	je	excolumn
	add	dl,'0'	;Преобразуем число в цифру
	int	21h	;Выведем цифру на экран
	jmp	l2column	;И продолжим
excolumn:	mov	ax,4c00h;Выход 
	;printing column




	mov AH,4Ch
	int 21h
end start
	end
