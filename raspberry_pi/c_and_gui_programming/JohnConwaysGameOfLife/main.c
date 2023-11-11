#include <stdio.h>
#include <stdlib.h>
#include "gameboard.h"

int main(int argc, char **argv)
{
    int width = 8;
    int height = 8;

    gameboard_t *gameboard = creategameboard(width, height);
    setcell(gameboard, 4, 2, 1);
    setcell(gameboard, 4, 3, 1);
    setcell(gameboard, 4, 4, 1);
    printgameboard(gameboard);
    return 0;
}