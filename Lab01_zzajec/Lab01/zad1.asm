.386
.MODEL FLAT,STDCALL

 GetStdHandle PROTO, nStdHandle: DWORD 
 WriteConsoleA PROTO, handle: DWORD, lpBuffer:PTR BYTE, nNumberOfBytesToWrite:DWORD, lpNumberOfBytesWritten:PTR DWORD, lpReserved:DWORD
 ReadConsoleA PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
 ExitProcess PROTO, dwExitCode: DWORD 
 wsprintfA PROTO C :VARARG
 fillRegister PROTO
 ScanInt PROTO
 atoi PROTO :DWORD



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
 wiadomosc Db "Podaj 1 liczbe: ", 10d
 wiadomosc2 Db "Suma podanych liczb to %i", 10d
 Buffer DD 8 dup(?)
 iloscLiter dd 16d
 zmiennaZnakow dd ?

 wczytanych DD ?
 inBuffer DD 8 dup(?)
.data

.code
 ReturnDescryptor MACRO handleConstantIn :REQ, handleOut :REQ
	push handleConstantIn
	call GetStdHandle
	mov handleOut, Eax
 ENDM

 ZeroPusher MACRO
	push 0
 ENDM
main proc

	;push STD_OUTPUT_HANDLE
	;call GetStdHandle
	;mov outputHandle, EAX
	;push	STD_INPUT_HANDLE
	;call	GetStdHandle	; wywo³anie funkcji GetStdHandle
	;mov	inputHandle, EAX	; deskryptor wejœciowego bufora konsoli


	ReturnDescryptor STD_OUTPUT_HANDLE, outputHandle
	ReturnDescryptor STD_INPUT_HANDLE, inputHandle
										;piersza liczba
	;push 0
	;push offset zmiennaZnakow
	;push iloscLiter
	;push offset wiadomosc
	;push outputHandle
	INVOKE WriteConsoleA, outputHandle, ADDR wiadomosc, iloscLiter, ADDR zmiennaZnakow, 0
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
	add EAX, zmienna3
	add EAX, zmienna4
	mov wynik, EAX


	push wynik
	push offset wiadomosc2
	push offset Buffer
	CALL wsprintfA

	push 0
	push offset zmiennaZnakow
	push 26d
	push offset Buffer
	push outputHandle
	call WriteConsoleA



	ZeroPusher
	invoke ExitProcess, 0 

main endp
END