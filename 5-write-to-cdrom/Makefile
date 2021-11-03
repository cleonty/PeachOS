boot.iso:	boot.bin
	mkisofs -R -b $^ -no-emul-boot -boot-load-size 4 -o $@ .

boot.bin:	../4-prepare-for-harddrive/boot.bin
	cp -v $^ $@

clean:	
	rm -fv *.iso *.bin