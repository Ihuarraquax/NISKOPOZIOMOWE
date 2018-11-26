.386
.MODEL flat, stdcall
 GetStdHandle PROTO, nStdHandle: DWORD 
 WriteConsoleA PROTO, handle: DWORD, lpBuffer:PTR BYTE, nNumberOfBytesToWrite:DWORD, lpNumberOfBytesWritten:PTR DWORD, lpReserved:DWORD
 ReadConsoleA PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
 ExitProcess PROTO, dwExitCode: DWORD 
 fillRegister PROTO
 GetCurrentDirectoryA PROTO :DWORD, :DWORD
 ScanInt PROTO
 atoi PROTO :DWORD
 lstrcatA PROTO :DWORD, :DWORD
 CreateFileA PROTO :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
 CreateDirectoryA PROTO :DWORD,:DWORD

 STD_OUTPUT_HANDLE equ -11
 STD_INPUT_HANDLE equ -10
	GENERIC_READ equ 80000000h
	GENERIC_WRITE equ 40000000h
	CREATE_NEW equ 1
	CREATE_ALWAYS equ 2
	OPEN_EXISTING equ 3
	OPEN_ALWAYS equ 4

 .data
 
 outputHandle DD ?
 inputHandle DD ?

 zmienna1 DD ?
 zmienna2 DD ?
 zmienna3 DD 6d
 zmienna4 DD ?

 iloscLiter dd 16d
 zmiennaZnakow dd ?
 
 bufferSciezki DD 30 dup(?)
 nazwaFolderu BYTE "\Grupa5",0
 twojeNazwisko BYTE "\Zablocki.dat", 0
 .code
 main PROC
	
	INVOKE GetCurrentDirectoryA,0,0
	INVOKE GetCurrentDirectoryA,EAX,offset bufferSciezki
	
	INVOKE lstrcatA,offset bufferSciezki,offset nazwaFolderu
	INVOKE CreateDirectoryA,offset bufferSciezki,0

	INVOKE GetCurrentDirectoryA,0,0
	INVOKE GetCurrentDirectoryA,EAX,offset bufferSciezki

	INVOKE lstrcatA,offset bufferSciezki,offset twojeNazwisko
	;
	INVOKE CreateFileA, offset bufferSciezki,GENERIC_READ OR GENERIC_WRITE,0,0,CREATE_ALWAYS,0,0

	

	push 0
	call ExitProcess
main ENDP
 
END main


