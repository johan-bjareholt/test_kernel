OBJ=start.o kmain.o

CFLAGS=-m32 -ffreestanding -nostdlib -mno-mmx -mno-sse2 -mno-red-zone

.PHONY: all
all: kernel

kernel: start.o kmain.o
	ld -m elf_i386 -T link.ld -o kernel $< kmain.o

start.o: start.asm
	as $< -o $@ --32

kmain.o: kmain.c
	gcc $(CFLAGS) -c $< -o $@

.PHONY: clean
clean:
	rm *.o
	rm kernel

.PHONY: run
run:
	qemu-system-i386 -kernel kernel
