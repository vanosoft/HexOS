#ifndef STDLIB_H
#define STDLIB_H

typedef enum bool {
	false = 0,
	true = 1
} bool;

#define NULL ((void*)0)

typedef unsigned char uint8_t;
typedef signed char int8_t;

typedef unsigned short uint16_t;
typedef signed short int16_t;

typedef unsigned long uint32_t;
typedef signed long int32_t;

typedef unsigned long long uint64_t;
typedef signed long long int64_t;

#ifdef __x86_64__
	typedef uint64_t size_t;
#else
	typedef uint32_t size_t;
#endif

#define min(a, b) (((a) > (b)) ? (b) : (a))
#define max(a, b) (((a) > (b)) ? (a) : (b))

#define outportb(port, value) asm("outb %b0, %w1"::"a"(value),"d"(port));
#define outportw(port, value) asm("outw %w0, %w1"::"a"(value),"d"(port));
#define outportl(port, value) asm("outl %0, %w1"::"a"(value),"d"(port));

#define inportb(port, out_value) asm("inb %w1, %b0":"=a"(out_value):"d"(port));
#define inportw(port, out_value) asm("inw %w1, %w0":"=a"(out_value):"d"(port));
#define inportl(port, out_value) asm("inl %w1, %0":"=a"(out_value):"d"(port));

void *memset(void *mem, char value, size_t count);
void *memset_word(void *mem, uint16_t value, size_t count);
void *memcpy(void *dest, const void *src, size_t count);
int memcmp(const void *mem1, const void *mem2, size_t count);
void *memchr(const void *mem, char value, size_t count);

size_t strlen(const char *str);
void strcpy(char *dest, const char *src);
void strncpy(char *dest, const char *src, size_t max_count);
int strcmp(const char *str1, const char *str2);
char *strchr(const char *str, char value);

#endif 