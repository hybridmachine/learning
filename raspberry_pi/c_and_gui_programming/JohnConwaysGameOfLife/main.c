#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <unistd.h>
#include <getopt.h>
#include "gameboard.h"
#include "gameoflife.h"

void printGens(gameboard_t *gameboard_1, gameboard_t *gameboard_2)
{
    gameboard_t *temp;
    gameboard_t *current;
    gameboard_t *next;

    current = gameboard_1;
    next = gameboard_2;

    for (int idx = 0; idx < 150; idx++)
    {
        system("clear");         
        printgameboard(current);
        getNextGeneration(current, next);
        temp = current;
        current = next;
        next = temp;
        usleep(100000);
    }
}

int main(int argc, char **argv)
{
    int width = 64;
    int height = 64;

    int opt;
    char *patternFile = "glidergun.txt"; // Default
    opterr = 0;

    while ((opt = getopt(argc, argv, "w:h:f:")) != -1)
    {
        switch (opt)
        {
        case 'w':
            width = atoi(optarg);
            break;
        case 'h':
            height = atoi(optarg);
            break;
        case 'f':
            patternFile = optarg;
            break;
        default:
            fprintf(stderr, "Usage: %s [-w width] [-h height] [-f patternFile]\n", argv[0]);
            exit(EXIT_FAILURE);
        }
    }
    gameboard_t *gameboard_1 = creategameboard(width, height);
    gameboard_t *gameboard_2 = creategameboard(width, height);
    if (gameboard_1 == NULL || gameboard_2 == NULL)
    {
        return -1;
    }

    initgameboard(gameboard_1, CELL_DEAD);
    initgameboard(gameboard_2, CELL_DEAD);

    loadPatternFile(patternFile, gameboard_1);
    // setcell(gameboard_1, width/2, height/2 - 1, CELL_LIVE);
    // setcell(gameboard_1, width/2 + 1, height/2 - 1, CELL_LIVE);
    // setcell(gameboard_1, width/2, height/2, CELL_LIVE);
    // setcell(gameboard_1, width/2 - 1, height/2, CELL_LIVE);
    // setcell(gameboard_1, width/2, height/2 + 1, CELL_LIVE);
    printGens(gameboard_1, gameboard_2);
    
    return 0;
}