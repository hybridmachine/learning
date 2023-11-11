CFLAGS=`pkg-config --cflags gtk+-3.0`
CFLAGS+=-O0 -g 
LIBS= `pkg-config --libs gtk+-3.0`

PinPal:
	gcc ${CFLAGS} -c -o gameboard.o gameboard.c
	gcc ${CFLAGS} -c -o gameoflife.o gameoflife.c
	gcc ${CFLAGS} -o gameOfLife main.c gameboard.o gameoflife.o
	
clean:
	rm -f *.o
	rm -f gameOfLife
