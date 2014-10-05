	.MODEL SMALL
	.STACK 100h
	.DATA
Message	DB	'Hello world!!! All right!',13,10,'$'
	.CODE
start:m:	mov ax,@Data
	mov ds,ax ; установить регистр DS таким
                  ; образом, чтобы он указывал
                  ; на сегмент данных
	mov ah,9 ; функция DOS вывода строки
	mov dx,OFFSET Message    ; ссылка на сообщение "Привет!"
	int 21h ; вывести "Привет!" на экран
	mov ah,4ch ; функция DOS завершения
                   ; программы
	int 21h ; завершить программу
end start
	END
