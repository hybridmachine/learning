CFLAGS+=-O0 -g 
INCLUDE=../include

GAMEOFLIFE_LIB:
	mkdir -p build
	gcc ${CFLAGS} -I${INCLUDE} -c -o gameboard.o gameboard.c
	gcc ${CFLAGS} -I${INCLUDE} -c -o gameoflife.o gameoflife.c
	ar rcs gol_lib.a *.o
	
clean:
	rm -f *.o
	rm -rf build
