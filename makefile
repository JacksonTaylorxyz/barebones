ASM="/home/jackson/opt/cross/bin/i686-elf-as"
CC="/home/jackson/opt/cross/bin/i686-elf-gcc"
VIRTUALIZER="qemu-system-i386"

all: boot.s kernel.c linker.ld
	$(ASM) boot.s -o boot.o
	$(CC) -c kernel.c -o kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra
	$(CC) -T linker.ld -o myos.bin -ffreestanding -O2 -nostdlib boot.o kernel.o -lgcc
iso: all isodir
	cp myos.bin isodir/boot/
	grub-mkrescue -o myos.iso isodir/
isodir: all
	mkdir -p isodir/boot/grub
	cp grub.cfg isodir/boot/grub/grub.cfg
	cp myos.bin isodir/boot/myos.bin
run: iso
	$(VIRTUALIZER) -cdrom myos.iso
clean:
	rm *.o *.bin *.iso
	rm -rf isodir

