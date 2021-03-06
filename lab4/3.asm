.386
.MODEL flat, stdcall
 
 GetStdHandle PROTO, nStdHandle: DWORD 
 WriteConsoleA PROTO, handle: DWORD, lpBuffer:PTR BYTE, nNumberOfBytesToWrite:DWORD, lpNumberOfBytesWritten:PTR DWORD, lpReserved:DWORD
 ReadConsoleA PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
 ExitProcess PROTO, dwExitCode: DWORD 
 wsprintfA PROTO C :VARARG

 STD_OUTPUT_HANDLE equ -11
 STD_INPUT_HANDLE equ -10
 .data
 
 outputHandle DD ?
 inputHandle DD ?

 zmienna1 DD ?
 zmienna2 DD ?
 zmienna3 DD ?
 zmienna4 DD ?
 wynik DD ?

 wiadomosc Db "Podaj A", 10d
 wiadomosc2 DB "Wynik obliczen dla funkcji y=(A+B)*C/D to: %i", 10d
 iloscLiter dd 8d
 iloscLiter2 dd 46d
 zmiennaZnakow dd ?

 wczytanych DD ?
 inBuffer DD 8 dup(?)
 .code
 main PROC
	
	push STD_OUTPUT_HANDLE
	call GetStdHandle
	mov outputHandle, EAX
	push	STD_INPUT_HANDLE
	call	GetStdHandle	; wywołanie funkcji GetStdHandle
	mov	inputHandle, EAX	; deskryptor wejściowego bufora konsoli

										;piersza liczba
	push 0
	push offset zmiennaZnakow
	push iloscLiter
	push offset wiadomosc
	push outputHandle
	call WriteConsoleA
	inc [wiadomosc+6]
	
	push 0
	push offset wczytanych
	push 10
	push offset zmienna1
	push inputHandle
	call ReadConsoleA

	mov EBX, offset zmienna1
	add EBX, wczytanych
	mov [EBX-2], BYTE PTR 0

	push offset zmienna1 	;adres poczatku ciagu znakow przekazywany na stos
	call atoi			;wywolanie procedury atoi
	mov  zmienna1, EAX 		;przeniesienie wyniku procedury atoi z rejestru EAX do zmiennej varA

										;druga liczba
	push 0
	push offset zmiennaZnakow
	push iloscLiter
	push offset wiadomosc
	push outputHandle
	call WriteConsoleA
	inc [wiadomosc+6]
	
	push 0
	push offset wczytanych
	push 10
	push offset zmienna2
	push inputHandle
	call ReadConsoleA

	mov EBX, offset zmienna2
	add EBX, wczytanych
	mov [EBX-2], BYTE PTR 0
	push offset zmienna2 	;adres poczatku ciagu znakow przekazywany na stos
	call atoi			;wywolanie procedury atoi
	mov  zmienna2, EAX 		;przeniesienie wyniku procedury atoi z rejestru EAX do zmiennej varA

										;trzecia liczba
	push 0
	push offset zmiennaZnakow
	push iloscLiter
	push offset wiadomosc
	push outputHandle
	call WriteConsoleA
	inc [wiadomosc+6]
	
	push 0
	push offset wczytanych
	push 10
	push offset zmienna3
	push inputHandle
	call ReadConsoleA

	mov EBX, offset zmienna3
	add EBX, wczytanych
	mov [EBX-2], BYTE PTR 0

	push offset zmienna3 	;adres poczatku ciagu znakow przekazywany na stos
	call atoi			;wywolanie procedury atoi
	mov  zmienna3, EAX 		;przeniesienie wyniku procedury atoi z rejestru EAX do zmiennej varA

										;czwarta liczba
	push 0
	push offset zmiennaZnakow
	push iloscLiter
	push offset wiadomosc
	push outputHandle
	call WriteConsoleA
	inc [wiadomosc+6]
	
	push 0
	push offset wczytanych
	push 10
	push offset zmienna4
	push inputHandle
	call ReadConsoleA

	mov EBX, offset zmienna4
	add EBX, wczytanych
	mov [EBX-2], BYTE PTR 0

	push offset zmienna4	;adres poczatku ciagu znakow przekazywany na stos
	call atoi			;wywolanie procedury atoi
	mov  zmienna4, EAX 		;przeniesienie wyniku procedury atoi z rejestru EAX do zmiennej varA

	mov EAX, zmienna1
	add EAX, zmienna2
	mul zmienna3
	div zmienna4
	mov wynik, EAX

	push wynik
	push offset wiadomosc2
	push offset wiadomosc2
	call wsprintfA

	push 0
	push offset zmiennaZnakow
	push EAX
	push offset wiadomosc2
	push outputHandle
	call WriteConsoleA

	




	push 0
	call ExitProcess
 main ENDP
 atoi proc uses esi edx inputBuffAddr:DWORD
	mov esi, inputBuffAddr
	xor edx, edx
	xor EAX, EAX
	mov AL, BYTE PTR [esi]
	cmp eax, 2dh
	je parseNegative

	.Repeat
		lodsb
		.Break .if !eax
		imul edx, edx, 10
		sub eax, "0"
		add edx, eax
	.Until 0
	mov EAX, EDX
	jmp endatoi

	parseNegative:
	inc esi
	.Repeat
		lodsb
		.Break .if !eax
		imul edx, edx, 10
		sub eax, "0"
		add edx, eax
	.Until 0

	xor EAX,EAX
	sub EAX, EDX
	jmp endatoi

	endatoi:
	ret
atoi endp
END main


