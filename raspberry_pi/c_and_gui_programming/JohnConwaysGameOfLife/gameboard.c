#include <stdlib.h>
#include <stdio.h>
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

bool setcell(gameboard_t *gameboard, int x, int y,  unsigned char value)
{
    int cellArrayIndex = getCellIndex(gameboard, x, y);
    gameboard->cells[cellArrayIndex] = value;
}

unsigned char getcell(gameboard_t *gameboard, int x, int y)
{
    int cellArrayIndex = getCellIndex(gameboard, x, y);
    return gameboard->cells[cellArrayIndex];
}

/// @brief Print the gameboard in CSV style
/// @param gameboard 
void printgameboard(gameboard_t *gameboard)
{
    for (int row = 0; row < gameboard->height; row++)
    {
        for (int col = 0; col < gameboard->width; col ++)
        {
            printf("%d, ", getcell(gameboard, col, row));
        }
        printf("\n");
    }
}