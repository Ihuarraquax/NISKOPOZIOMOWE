.386
.MODEL FLAT, STDCALL


.data 

.code
potateiro proc

	mov EAX,100
	ret
potateiro endp

testeiro proc param1:DWORD 


	mov EAX,100
	mov EBX, param1
	ret
testeiro endp

END