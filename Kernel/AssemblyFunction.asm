EXTERN	systemStack : PTR BYTE
EXTERN	Main : PROC
EXTERN	TimerOnInterrupt : PROC

PUBLIC	Start
PUBLIC	Inspect
PUBLIC	Halt
PUBLIC	IOOut32
PUBLIC	IOIn32
PUBLIC	LoadGDT
PUBLIC	LoadIDT
PUBLIC	InitializeSegmentRegister
PUBLIC	GetCS
PUBLIC	GetSS
PUBLIC	GetCR3
PUBLIC	SetCR3
PUBLIC	SwitchContext
PUBLIC	SetInterruptFlag
PUBLIC	TimerInterruptHandler

.CODE

Start	PROC
	CLI
	LEA	RSP, systemStack + 1024 * 1024
	STI
	JMP	Main

	RET
Start	ENDP

Inspect	PROC
	CLI
	MOV RAX, RCX
	HLT
	JMP Inspect

	RET
Inspect ENDP

Halt	PROC
	CLI
	HLT
	JMP Halt

	RET
Halt	ENDP

IOOut32 PROC
	MOV EAX, EDX
	MOV DX, CX
	OUT DX, EAX

	RET
IOOut32 ENDP

IOIn32  PROC
	MOV DX, CX
	IN  EAX, DX

	RET
IOIn32  ENDP

LoadGDT PROC
	PUSH    RBP
	MOV     RBP, RSP

	SUB     RSP, 10
	MOV     [RSP], CX
	MOV     [RSP + 2], RDX
	LGDT    FWORD PTR [RSP]

	MOV		RSP, RBP
	POP		RBP
	
	RET
LoadGDT ENDP

LoadIDT	PROC
	PUSH	RBP
	MOV		RBP, RSP

	SUB		RSP, 10
	MOV		[RSP], CX
	MOV		[RSP + 2], RDX
	LIDT	FWORD PTR [RSP]

	MOV		RSP, RBP
	POP		RBP

	RET
LoadIDT	ENDP

InitializeSegmentRegister	PROC
	PUSH	RBP
	MOV		RBP, RSP

	MOV		DS, R8W
	MOV		ES, R8W
	MOV		FS, R8W
	MOV		GS, R8W
	MOV		SS, DX
	LEA		RAX, Next

	PUSH	RCX
	PUSH	RAX

	DB		48h
	RETF

	Next:
		MOV RSP, RBP
		POP RBP

		RET
InitializeSegmentRegister	ENDP

GetCS	PROC
	MOV	AX, CS

	RET
GetCS	ENDP

GetSS	PROC
	MOV	AX, SS

	RET
GetSS	ENDP

GetCR3	PROC
	MOV	RAX, CR3

	RET
GetCR3	ENDP

SetCR3	PROC
	MOV	CR3, RCX

	RET
SetCR3	ENDP

SwitchContext	PROC
	MOV		[RDX + 40h], RAX
	MOV		[RDX + 48h], RBX
	MOV		[RDX + 50h], RCX
	MOV		[RDX + 58h], RDX
	MOV		[RDX + 60h], RDI
	MOV		[RDX + 68h], RSI

	LEA		RAX, [RSP + 8]
	MOV		[RDX + 70h], RAX
	MOV		[RDX + 78h], RBP

	MOV		[RDX + 80h], R8
	MOV		[RDX + 88h], R9
	MOV		[RDX + 90h], R10
	MOV		[RDX + 98h], R11
	MOV		[RDX + A0h], R12
	MOV		[RDX + A8h], R13
	MOV		[RDX + B0h], R14
	MOV		[RDX + B8h], R15

	MOV		RAX, CR3
	MOV		[RDX + 00h], RAX
	MOV		RAX, [RSP]
	MOV		[RDX + 08h], RAX
	PUSHFQ
	POP		QWORD PTR [RDX + 10h]

	MOV		AX, CS
	MOV		[RDX + 20h], RAX
	MOV		BX, SS
	MOV		[RDX + 28h], RBX
	MOV		CX, FS
	MOV		[RDX + 30h], RCX
	MOV		DX, GS
	MOV		[RDX + 38h], RDX

	FXSAVE	[RDX + C0h]

	PUSH	QWORD PTR [RCX + 28h]
	PUSH	QWORD PTR [RCX + 70h]
	PUSH	QWORD PTR [RCX + 10h]
	PUSH	QWORD PTR [RCX + 20h]
	PUSH	QWORD PTR [RCX + 08h]

	FXRSTOR	[RCX + C0h]

	MOV		RAX, [RCX + 00h]
	MOV		CR3, RAX
	MOV		RAX, [RCX + 30h]
	MOV		FS, AX
	MOV		RAX, [RCX + 38h]
	MOV		GS, AX

	MOV		RAX, [RCX + 40h]
	MOV		RBX, [RCX + 48h]
	MOV		RDX, [RCX + 58h]
	MOV		RDI, [RCX + 60h]
	MOV		RSI, [RCX + 68h]
	MOV		RBP, [RCX + 78h]
	MOV		R8,  [RCX + 80h]
	MOV		R9,  [RCX + 88h]
	MOV		R10, [RCX + 90h]
	MOV		R11, [RCX + 98h]
	MOV		R12, [RCX + A0h]
	MOV		R13, [RCX + A8h]
	MOV		R14, [RCX + B0h]
	MOV		R15, [RCX + B8h]

	MOV		RCX, [RCX + 50h]

	IRET
SwitchContext	ENDP

SetInterruptFlag	PROC
	AND	RCX, 1b
	CMP RCX, 1b
	JE	Set
	JNE Clear
	Set:
		STI
	
		RET
	Clear:
		CLI
	
		RET
SetInterruptFlag	ENDP

NotifyEndOfInterrupt	PROC
	MOV ECX, FEE000B0h
	MOV EDX, 0
	MOV [ECX], EDX

	RET
NotifyEndOfInterrupt	ENDP

TimerInterruptHandler	PROC
	JMP		TimerOnInterrupt
	JMP		NotifyEndOfInterrupt

	IRETQ
TimerInterruptHandler	ENDP

END