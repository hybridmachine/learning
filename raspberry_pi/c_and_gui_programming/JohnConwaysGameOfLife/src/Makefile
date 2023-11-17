CFLAGS=`pkg-config --cflags gtk+-3.0`
CFLAGS+=-O0 -g 
LIBS= `pkg-config --libs gtk+-3.0`
LIBS+='lib/gol_lib.a'
INCLUDE='include'
DEPENDENCIES := lib/gameoflife.c lib/gameboard.c lib/gol_lib.a main.c

build/gameOfLife: $(DEPENDENCIES)
	mkdir -p build
	gcc ${CFLAGS} -I${INCLUDE} -o build/gameOfLife main.c ${LIBS}
	
clean:
	rm -f *.o
	rm -rf build
