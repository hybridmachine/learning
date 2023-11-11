/* John Conway's Game of Life playing field */
#include <stdbool.h>

#define MAX_BOARD_WIDTH 255
#define MAX_BOARD_HEIGHT 255

typedef struct struct_gameboard {
    int width;
    int height;
    unsigned char *cells;
} gameboard_t;

gameboard_t *creategameboard(int width, int height);
bool initgameboard(gameboard_t board);
int getCellIndex(gameboard_t *gameboard, int x, int y);
bool setcell(gameboard_t *gameboard, int x, int y, unsigned char value);
unsigned char getcell(gameboard_t *gameboard, int x, int y);
void printgameboard(gameboard_t *gameboard);