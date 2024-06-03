#ifndef __TASK_H__
#define __TASK_H__

#include "AssemblyFunction.h"
#include "Memory.h"
#include "Type.h"

#define STACK_BYTE 4096
#define STACK_SIZE (STACK_BYTE / sizeof(UINT64))

typedef struct _TASK_MANAGER TASK_MANAGER;

#pragma pack(push, 1)
typedef struct {
	UINT64  CR3, RIP, RFLAGS, reserved;
	UINT64  CS, SS, FS, GS;
	UINT64  RAX, RBX, RCX, RDX, RDI, RSI, RSP, RBP;
	UINT64  R8, R9, R10, R11, R12, R13, R14, R15;
	BYTE    FXSAVE[512];
} CONTEXT;
#pragma pack(pop)

typedef struct {
							UINT64  id;

							BYTE	stack[STACK_SIZE];
	__declspec(align(16))   CONTEXT context;
} TASK;

struct _TASK_MANAGER {
	UINTN	latestID;
	TASK*	tasks;

	VOID	(*CreateTask)(
				OUT			TASK_MANAGER*	_this,
				IN CONST	ADDRESS			_function,
				IN CONST	INT64			_data
			);
	VOID	(*SwitchTask)(
				OUT	TASK_MANAGER*	_this
			);
};

TASK_MANAGER* 
DUMMYAPI GetTaskManager(
	VOID
);

STATUS 
DUMMYAPI InitializeTaskManager(
	VOID
);

STATIC VOID 
DUMMYAPI InitializeTask(
	OUT			TASK*	_this,
	IN CONST	ADDRESS	_function, 
	IN CONST	INT64	_data
);

STATIC VOID 
DUMMYAPI _CreateTask(
	OUT			TASK_MANAGER*	_this,
	IN CONST	ADDRESS			_function,
	IN CONST	INT64			_data
);

STATIC VOID 
DUMMYAPI _SwitchTask(
	OUT	TASK_MANAGER* _this
);

#endif