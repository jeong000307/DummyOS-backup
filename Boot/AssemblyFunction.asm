.CODE

PUBLIC	Inspect
PUBLIC	Halt

Inspect  PROC
	CLI
	MOV RAX, RCX
	HLT
	JMP Inspect

	RET
Inspect  ENDP

Halt	PROC
	CLI
	HLT
	JMP Halt

	RET
Halt	ENDP

END