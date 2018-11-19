.386
.MODEL flat, STDCALL

ExitProcess PROTO :DWORD


.data
buffor BYTE "666",0 ;liczba 666 jako kod asci, ciag zakonczony 0 na potrzeby procedury atoi

varA DWORD 0

.code
main proc

	push offset buffor 	;adres poczatku ciagu znakow przekazywany na stos
	call atoi			;wywolanie procedury atoi
	mov  varA, EAX 		;przeniesienie wyniku procedury atoi z rejestru EAX do zmiennej varA

	push 0
	call ExitProcess

main endp

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

END