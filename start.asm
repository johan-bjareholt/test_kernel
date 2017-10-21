# Declare constants for the multiboot header
.set ALIGN,    1<<0             # align loaded modules on page boundaries
.set MEMINFO,  1<<1             # provide memory map
.set FLAGS,    ALIGN | MEMINFO  # this is the Multiboot 'flag' field
.set MAGIC,    0x1BADB002       # 'magic number' lets bootloader find the header
.set CHECKSUM, -(MAGIC + FLAGS) # checksum of above, to prove we are multiboot

.bss

stack_bottom:
.skip 16384 # 16 KiB stack
stack_top:

.section .multiboot
.align 4
.long MAGIC
.long FLAGS
.long CHECKSUM

.section .text
.global kmain
.type start, @function
.global start
start:
    cli # block interrupts
    mov $stack_top, %esp # set stack pointer
    call kmain
1:  hlt # halt the CPU
    jmp 1b

.size start, . - start
