boot.iso:	boot.bin
	mkisofs -R -b $^ -no-emul-boot -boot-load-size 4 -o $@ .

boot.bin:	boot.asm message.txt
	nasm -f bin -o $@ $<
	dd if=./message.txt >> ./boot.bin
	dd if=/dev/zero bs=512 count=1 >> ./boot.bin
	
disasm:	boot.bin
	ndisasm $^

run:	boot.bin
	qemu-system-x86_64 -hda ./boot.bin

clean:	
	rm -f *.bin *.iso