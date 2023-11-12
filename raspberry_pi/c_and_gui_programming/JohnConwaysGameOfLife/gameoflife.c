#include "gameoflife.h"
#include <stdio.h>
#include <string.h>


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
                printf("  ");
            }
            else
            {
                printf("+ ");
            }
        }
        printf("\n");
    }
}

bool loadPatternFile(char *path, gameboard_t *board)
{
    // Open pattern file from path
    FILE *patternFile = fopen(path, "r");
    if (patternFile == NULL)
    {
        printf("Error opening file %s\n", path);
        return false;
    }
    // Read in pattern file and find how many columns and rows it has
    int maxRow = 0;
    int maxCol = 0;
    char line[256];
    
    int row = 10;
    while (fgets(line, sizeof(line), patternFile))
    {
        int col = 8;
        int lineLen = strlen(line);
        for (int idx = 0; idx < lineLen; idx++)
        {
            if (line[idx] == 'O')
            {
                setcell(board, col, row, CELL_LIVE);
            }
            else if (line[idx] == '.')
            {
                setcell(board, col, row, CELL_DEAD);
            }
            else
            {
                if (line[idx] == '\n')
                {
                    continue;
                }

                // Otherwise error
                printf("Invalid character in pattern file: %c\n", line[idx]);
                return false;
            }
            col++;
        }
        row++;
        if (col > maxCol)
        {
            maxCol = col;
        }
        if (row > maxRow)
        {
            maxRow = row;
        }
    }
    printf("maxCol: %d, maxRow: %d\n", maxCol, maxRow);

}