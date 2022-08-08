#include "include/stdlib.h"

void *memset(void *mem, char value, size_t count) 
{
	for (size_t i = 0; i < count; i++)
	{
		((char*)mem)[i] = value;
	}
}

void *memset_word(void *mem, uint16_t value, size_t count) 
{
	for (size_t i = 0; i < count; i++)
	{
		((short*)mem)[i] = value;
	}	
}

void *memcpy(void *dest, void const *src, size_t count) 
{
	size_t n = count / sizeof(size_t);
	size_t i;
	if (dest < src)
	{
		for (i = 0; i < n; i++)
		{
			((size_t*)dest)[i] = ((size_t*)src)[i];
		}
		for (i = n * sizeof(size_t); i < count; i++)
		{
			((char*)dest)[i] = ((char*)src)[i];	
		}
	} 
	else
	{
		for (i = count; i > n * sizeof(size_t); i--)
		{
			((char*)dest)[i - 1] = ((char*)src)[i - 1];	
		}
		for (i = n; i > 0; i--)
		{
			((size_t*)dest)[i - 1] = ((size_t*)src)[i - 1];
		}
	}
}

int memcmp(const void *mem1, const void *mem2, size_t count) 
{
	for (size_t i = 0; i < count; i++)
	{
		if (((char*)mem1)[i] > ((char*)mem2)[i]) return 1;
		else if (((char*)mem1)[i] < ((char*)mem2)[i]) return -1;
	}
	return 0;
}

void *memchr(const void *mem, char value, size_t count) 
{
	for (size_t i = 0; i < count; i++)
	{
		if (((char*)mem)[i] == value) return &(((char*)mem)[i]);
	}
	return NULL;
}

size_t strlen(const char *str) 
{
	return (char*)memchr(str, '\0', -1) - str;
}

void strcpy(char *dest, char const *src) 
{
	memcpy(dest, src, strlen(src) + 1);
}

void strncpy(char *dest, char const *src, size_t max_count)
{
	size_t len = min(max_count - 1, strlen(src));
	memcpy(dest, src, len);
	dest[len] = '\0';
}

int strcmp(const char *str1, const char *str2) 
{
	for (;(*str1 != 0) && (*str2 != 0); str1++, str2++)
	{
		if (*str1 > *str2) return 1;
		else if (*str1 < *str2) return -1;
	}
	if ((*str1 == 0) && (*str2 != 0)) return 1;
	else if ((*str1 != 0) && (*str2 == 0)) return -1;
	else return 0;
}

char *strchr(const char *str, char value) 
{
	if (value == '\0') return (str + strlen(str));
	return memchr(str, value, strlen(str));
} 


