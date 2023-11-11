#include "gameoflife.h"
#include <stdio.h>

/// @brief     Any live cell with fewer than two live neighbours dies, as if by underpopulation.
///    Any live cell with two or three live neighbours lives on to the next generation.
///    Any live cell with more than three live neighbours dies, as if by overpopulation.
///    Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction
/// @param current 
/// @param next 
/// @return 
unsigned getNextState(gameboard_t *gameboard, int x, int y)
{
    int neighborCount = 0;
    // Get neighbors above
    neighborCount += getcell(gameboard, x-1, y-1);
    neighborCount += getcell(gameboard, x, y-1);
    neighborCount += getcell(gameboard, x+1, y-1);

    // Get neighbors in same row (but skip self)
    neighborCount += getcell(gameboard, x-1, y);
    neighborCount += getcell(gameboard, x+1, y);

    // Get neigbors below
    neighborCount += getcell(gameboard, x-1, y+1);
    neighborCount += getcell(gameboard, x, y+1);
    neighborCount += getcell(gameboard, x+1, y+1);
   
    if (CELL_LIVE == getcell(gameboard, x, y))
    {
        // Any live cell with fewer than two live neighbours dies, as if by underpopulation.
        if (neighborCount < 2)
        {
            return CELL_DEAD;
        }
        else if (neighborCount == 2 || neighborCount == 3)
        // Any live cell with two or three live neighbours lives on to the next generation.
        {
            return CELL_LIVE;
        }
        else
        // Any live cell with more than three live neighbours dies, as if by overpopulation.
        {
            return CELL_DEAD;
        }
    }
    else
    {
        //Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction
        if (neighborCount == 3)
        {
            return CELL_LIVE;
        }
        else
        {
            return CELL_DEAD;
        }
    }
}

bool getNextGeneration(gameboard_t *current, gameboard_t *next)
{
    initgameboard(next, CELL_DEAD);
    for (int row = 0; row < current->height; row++)
    {
        for (int col = 0; col < current->width; col++)
        {
            int cellIndex = getCellIndex(current, col, row);
            next->cells[cellIndex] = getNextState(current, col, row);
        }
    }   
}

/// @brief Print the gameboard in CSV style
/// @param gameboard 
void printgameboard(gameboard_t *gameboard)
{
    for (int row = 0; row < gameboard->height; row++)
    {
        for (int col = 0; col < gameboard->width; col ++)
        {
            unsigned char cellVal = getcell(gameboard, col, row);
            if (cellVal == CELL_DEAD)
            {
                printf("   ");
            }
            else
            {
                printf(" X ");
            }
        }
        printf("\n");
    }
}