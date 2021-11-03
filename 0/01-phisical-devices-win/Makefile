devtool.exe:	devtool.cpp
	g++ -o $@ $^

logical:	devtool.exe
	devtool.exe C:

all:	devtool.exe
	devtool.exe

clean:	
	rm -fv devtool.exe