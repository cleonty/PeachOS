./bin/boot.iso:	./bin/boot.bin
	mkisofs -R -b $^ -no-emul-boot -boot-load-size 4 -o $@ .

./bin/boot.bin:	./src/boot/boot.asm
	nasm -f bin -o $@ $<

	
disasm:	./bin/boot.bin
	ndisasm $^

run:	./bin/boot.bin
	qemu-system-x86_64 -hda ./bin/boot.bin

clean:	
	rm -f ./bin/*.bin ./bin/*.iso ./buid/*.o

gdb:	
	gdb target remote | qemu-system-x86_64 -hda ./boot.bin -S -gdb stdio