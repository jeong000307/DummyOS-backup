#ifndef __ERROR_H__
#define __ERROR_H__

#include "Type.h"

#define ENCODE_ERROR(StatusCode)	((STATUS)(0x8000000000000000ULL | (StatusCode)))
#define ENCODE_WARNING(StatusCode)	((STATUS)(StatusCode))
#define ERROR(StatusCode)			(((INTN)(STATUS)(StatusCode)) < 0)

#define SUCCESS						(STATUS)(0)

#define ERR_LOAD_ERROR				ENCODE_ERROR(1)
#define ERR_INVALID_PARAMETER		ENCODE_ERROR(2)
#define ERR_UNSUPPORTED				ENCODE_ERROR(3)
#define ERR_BAD_BUFFER_SIZE			ENCODE_ERROR(4)
#define ERR_BUFFER_TOO_SMALL		ENCODE_ERROR(5)
#define ERR_NOT_READY				ENCODE_ERROR(6)
#define ERR_DEVICE_ERROR			ENCODE_ERROR(7)
#define ERR_WRITE_PROTECTED			ENCODE_ERROR(8)
#define ERR_OUT_OF_RESOURCES		ENCODE_ERROR(9)
#define ERR_NOT_FOUND				ENCODE_ERROR(10)
#define ERR_ACCESS_DENIED			ENCODE_ERROR(11)
#define ERR_NO_RESPONSE				ENCODE_ERROR(12)
#define ERR_NO_MAPPING				ENCODE_ERROR(13)
#define ERR_TIMEOUT					ENCODE_ERROR(14)
#define ERR_ABORTED					ENCODE_ERROR(15)
#define ERR_INCOMPATIBLE_VERSION	ENCODE_ERROR(16)
#define ERR_SECURITY_VIOLATION		ENCODE_ERROR(17)
#define ERR_COMPROMISED_DATA		ENCODE_ERROR(18)

#define WARN_DELETE_FAILURE			ENCODE_WARNING(1)
#define WARN_WRITE_FAILURE			ENCODE_WARNING(2)
#define WARN_BUFFER_TOO_SMALL		ENCODE_WARNING(3)
#define WARN_STALE_DATA				ENCODE_WARNING(4)
#define WARN_RESET_REQUIRED			ENCODE_WARNING(5)

#endif