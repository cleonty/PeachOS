boot.iso:	boot.bin
	mkisofs -R -b $^ -no-emul-boot -boot-load-size 4 -o $@ .

boot.bin:	boot.asm
	nasm -f bin -o $@ $^
	
disasm:	boot.bin
	ndisasm $^

run:	boot.bin
	qemu-system-x86_64 -hda ./boot.bin

clean:	
	rm -f *.bin *.iso