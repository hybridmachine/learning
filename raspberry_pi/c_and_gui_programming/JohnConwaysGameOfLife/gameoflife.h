#ifndef _GAMEOFLIFE_H
#define _GAMEOFLIFE_H
#include "gameboard.h"

/// @brief     Any live cell with fewer than two live neighbours dies, as if by underpopulation.
///    Any live cell with two or three live neighbours lives on to the next generation.
///    Any live cell with more than three live neighbours dies, as if by overpopulation.
///    Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction
/// @param current 
/// @param next 
/// @return 

#define CELL_LIVE 1
#define CELL_DEAD 0

unsigned getNextState(gameboard_t *gameboard, int x, int y);

bool getNextGeneration(gameboard_t *current, gameboard_t *next);
void printgameboard(gameboard_t *gameboard);
#endif