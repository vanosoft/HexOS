#include "stdlib.h"

void memset(void *mem, char value, size_t count) 
{
	for (size_t i = 0; i < count; i++)
	{
		((char*)mem)[i] = value;
	}
}

void memset_word(void *mem, uint16 value, size_t count) 
{
	for (size_t i = 0; i < count; i++)
	{
		((short*)mem)[i] = value;
	}	
}

void memcpy(void *dest, void *src, size_t count) 
{
	if (dest < src)
	{
		for (size_t i = 0; i < count; i++)
		{
			((char*)dest)[i] = ((char*)src)[i];
		}
	} 
	else
	{
		for (size_t i = count; i > 0; i--)
		{
			((char*)dest)[i - 1] = ((char*)src)[i - 1];
		}
	}
}

int memcmp(void *mem1, void *mem2, size_t count) 
{
	for (size_t i = 0; i < count; i++)
	{
		if (((char*)mem1)[i] > ((char*)mem2)[i]) return 1;
		else if (((char*)mem1)[i] < ((char*)mem2)[i]) return -1;
	}
	return 0;
}

void *memchr(void *mem, char value, size_t count) 
{
	for (size_t i = 0; i < count; i++)
	{
		if (((char*)mem)[i] == value) return &(((char*)mem)[i]);
	}
	return NULL;
}

size_t strlen(char *str) 
{
	return (char*)memchr(str, '\0', -1) - str;
}

void strcpy(char *dest, char *src) 
{
	memcpy(dest, src, strlen(src) + 1);
}

void strncpy(char *dest, char *src, size_t max_count)
{
	size_t len = min(max_count - 1, strlen(src));
	memcpy(dest, src, len);
	dest[len] = '\0';
}

int strcmp(char *str1, char *str2) 
{
	return memcmp(str1, str2, min(strlen(str1), strlen(str2)));
}

char *strchr(char *str, char value) 
{
	return memchr(str, value, strlen(str));
} 


