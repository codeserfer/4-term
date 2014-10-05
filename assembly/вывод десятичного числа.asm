	.model	small
	.STACK   100h
	.code
start:	mov	ax,125	;Выводимое число в регисте AX
	push	-1	;Сохраним признак конца числа
	mov	cx,10	;Делим на 10
l:	mov	dx,0	;Очистим регистр dx (xor dx,dx - оптимальнее)
	div	cx	;Делим 
	push	dx	;Сохраним цифру
	cmp	ax,0	;Остался 0? (оптимальнее or ax,ax)
	jne	l	;нет -> продолжим
	mov	ah,2h
l2:	pop	dx	;Восстановим цифру
	cmp	dx,-1	;Дошли до конца -> выход {оптимальнее: or dx,dx jl ex}
	je	ex
	add	dl,'0'	;Преобразуем число в цифру
	int	21h	;Выведем цифру на экран
	jmp	l2	;И продолжим
ex:	mov	ax,4c00h;Выход
	int	21h
end	start	
	end
