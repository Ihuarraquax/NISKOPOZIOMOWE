.386
.MODEL flat, stdcall
 
 GetStdHandle PROTO, nStdHandle: DWORD 
 WriteConsoleA PROTO, handle: DWORD, lpBuffer:PTR BYTE, nNumberOfBytesToWrite:DWORD, lpNumberOfBytesWritten:PTR DWORD, lpReserved:DWORD
 ReadConsoleA PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
 ExitProcess PROTO, dwExitCode: DWORD 
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

 wiadomosc Db "Podaj 1 liczbe!", 10d
 iloscLiter dd 16d
 zmiennaZnakow dd ?

 wczytanych DD ?
 inBuffer DD 8 dup(?)
 .code
 main PROC
	push STD_OUTPUT_HANDLE
	call GetStdHandle
	mov outputHandle, EAX
	push	STD_INPUT_HANDLE
	call	GetStdHandle	; wywo³anie funkcji GetStdHandle
	mov	inputHandle, EAX	; deskryptor wejœciowego bufora konsoli

	push 0
	push offset wczytanych
	push 10
	push offset zmienna1
	push inputHandle
	call ReadConsoleA
	mov EBX, offset zmienna1
	add EBX, wczytanych
	mov [EBX-2], BYTE PTR 0

	mov EBX, wczytanych-2
	lejbel:
	
	

	mov EBX, offset zmienna1
	call ScanInt
	



	push 0
	call ExitProcess
main ENDP
 
END main


