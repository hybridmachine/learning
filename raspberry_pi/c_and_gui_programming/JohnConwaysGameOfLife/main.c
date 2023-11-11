#include <stdio.h>
#include <stdlib.h>
#include "gameboard.h"
#include "gameoflife.h"
#include<unistd.h>

void printGens(gameboard_t *gameboard_1, gameboard_t *gameboard_2)
{
    gameboard_t *temp;
    gameboard_t *current;
    gameboard_t *next;

    current = gameboard_1;
    next = gameboard_2;

    for (int idx = 0; idx < 100; idx++)
    {
        system("clear");         
        printgameboard(current);
        getNextGeneration(current, next);
        temp = current;
        current = next;
        next = temp;
        usleep(250000);
    }
}

int main(int argc, char **argv)
{
    int width = 32;
    int height = 32;

    gameboard_t *gameboard_1 = creategameboard(width, height);
    gameboard_t *gameboard_2 = creategameboard(width, height);
    if (gameboard_1 == NULL || gameboard_2 == NULL)
    {
        return -1;
    }

    initgameboard(gameboard_1, CELL_DEAD);
    initgameboard(gameboard_2, CELL_DEAD);

    setcell(gameboard_1, width/2, height/2 - 1, CELL_LIVE);
    setcell(gameboard_1, width/2 + 1, height/2 - 1, CELL_LIVE);
    setcell(gameboard_1, width/2, height/2, CELL_LIVE);
    setcell(gameboard_1, width/2 - 1, height/2, CELL_LIVE);
    setcell(gameboard_1, width/2, height/2 + 1, CELL_LIVE);
    printGens(gameboard_1, gameboard_2);
    
    return 0;
}