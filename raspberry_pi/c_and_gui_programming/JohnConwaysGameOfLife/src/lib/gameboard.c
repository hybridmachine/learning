#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "gameboard.h"

gameboard_t *creategameboard(int width, int height)
{
    gameboard_t *gameboard = NULL;
    if (width > MAX_BOARD_WIDTH || height > MAX_BOARD_HEIGHT)
    {
        return NULL;
    }

    int size = width * height;
    gameboard = (gameboard_t *)malloc(sizeof(gameboard_t));
    if (gameboard == NULL)
    {
        return NULL;
    }

    gameboard->width = width;
    gameboard->height = height;
    gameboard->cells = (unsigned char *)malloc(sizeof(unsigned char) * size);
    if (gameboard->cells == NULL)
    {
        free(gameboard);
        return NULL;
    }
 
    return gameboard;
}

int getCellIndex(gameboard_t *gameboard, int x, int y)
{
    return (gameboard->height) * y + x;
}

bool initgameboard(gameboard_t *gameboard, unsigned char value)
{
    int count = gameboard->height * gameboard->width;
    memset(gameboard->cells, value, count * sizeof(unsigned char));
    return true;
}
bool setcell(gameboard_t *gameboard, int x, int y,  unsigned char value)
{
    int cellArrayIndex = getCellIndex(gameboard, x, y);
    gameboard->cells[cellArrayIndex] = value;
}

unsigned char getcell(gameboard_t *gameboard, int x, int y)
{
    // Any out of bounds cells return 0
    if ((x < 0) || 
        (x >= gameboard->width) || 
        (y < 0) || 
        (y >= gameboard->height))
    {
        return 0;
    }

    int cellArrayIndex = getCellIndex(gameboard, x, y);
    return gameboard->cells[cellArrayIndex];
}

