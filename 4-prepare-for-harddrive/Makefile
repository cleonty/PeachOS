boot.bin:	boot.asm
	nasm -f bin -o $@ $^
	
disasm:	boot.bin
	ndisasm $^

run:	boot.bin
	qemu-system-x86_64 -hda ./boot.bin

clean:	
	rm -f *.bin