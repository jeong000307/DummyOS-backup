#ifndef __TYPE_H__
#define __TYPE_H__

// ��ũ��

#define INT_SIZEOF(type)			((sizeof(type) + sizeof(UINTN) - 1) & ~(sizeof(UINTN) - 1))
#define VA_START(marker, parameter)	(marker = (VA_LIST)((UINTN) & (parameter) + INT_SIZEOF(parameter)))
#define VA_ARG(marker, type)		(*(type*)((marker += INT_SIZEOF(type)) - INT_SIZEOF(type)))
#define VA_END(marker)				(marker = (VA_LIST)0)
#define VA_COPY(destination, start)	((VOID)((destination) = (start)))

// ������

#define CONST		const
#define STATIC		static
#define EXTERN		extern
#define VOID		void

#define IN 
#define OUT 
#define OPTIONAL 

#define EFIAPI		__cdecl
#define NORETURN	__declspec(noreturn)

// ��� ����

#define TRUE	((BOOLEAN)1)
#define FALSE	((BOOLEAN)0)

#define NUL		'\0'
#define NULL	((VOID*)0)

#define OR		||
#define AND		&&

// �ֿ� �ڷ��� ������

typedef char				BYTE;
typedef unsigned char		BOOLEAN;

typedef char				CHAR8;
typedef unsigned short		CHAR16;

typedef unsigned char		UINT8;
typedef unsigned short		UINT16;
typedef unsigned __int32	UINT32;
typedef unsigned __int64	UINT64;

typedef signed char			INT8;
typedef short				INT16;
typedef __int32				INT32;
typedef __int64				INT64;

typedef UINT64				UINTN;
typedef INT64				INTN;

// EFI �ڷ��� ����

typedef UINTN	EFI_STATUS;

typedef UINT64	EFI_PHYSICAL_ADDRESS;
typedef UINT64	EFI_VIRTUAL_ADDRESS;

typedef struct {
	UINT32	Data1;
	UINT16	Data2;
	UINT16	Data3;
	UINT8	Data4[8];
} EFI_GUID;

typedef VOID*	EFI_HANDLE;
typedef VOID*	EFI_EVENT;

// ���� ���� ����

typedef UINT8* VA_LIST;

#endif