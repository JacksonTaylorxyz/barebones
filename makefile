ASM="/home/jackson/opt/cross/bin/i686-elf-as"
CC="/home/jackson/opt/cross/bin/i686-elf-gcc"

all: boot.s kernel.c linker.ld
	$(ASM) boot.s -o boot.o
	$(CC) -c kernel.c -o kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra
	$(CC) -T linker.ld -o myos.bin -ffreestanding -O2 -nostdlib boot.o kernel.o -lgcc
iso: all
	cp myos.bin isodir/boot/
	grub-mkrescue -o myos.iso isodir/
clean:
	rm *.o *.bin *.iso

