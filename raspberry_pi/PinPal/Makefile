CFLAGS= `pkg-config --cflags gtk+-3.0`
LIBS= `pkg-config --libs gtk+-3.0`

PinPal:
	gcc ${CFLAGS} main.c ${LIBS} -o PinPal

clean:
	rm -f *.o
	rm -f PinPal
