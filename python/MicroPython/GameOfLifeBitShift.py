import array
import time
import machine
from cosmic import CosmicUnicorn
from picographics import PicoGraphics, DISPLAY_COSMIC_UNICORN as DISPLAY
import random

graphics = None
palette = None

# create cosmic object and graphics surface for drawing
cosmic = CosmicUnicorn()
graphics = PicoGraphics(DISPLAY)

def init():
    # a palette of five firey colours (white, yellow, orange, red, smoke)
    global palette
    palette = [
        graphics.create_pen(0, 0, 0),
        graphics.create_pen(20, 20, 20),
        graphics.create_pen(180, 30, 0),
        graphics.create_pen(220, 160, 0),
        graphics.create_pen(255, 255, 180)
    ]
    
def GoL_FindNextBitState(currentBitState, neighborCount):
    # John Conway's Game Of Life
    # From Wikipedia
    #    Any live cell with two or three live neighbours survives.
    #    Any dead cell with three live neighbours becomes a live cell.
    #    All other live cells die in the next generation. Similarly, all other dead cells stay dead.
    if (currentBitState == 1):
        if (neighborCount == 2 or neighborCount == 3):
            return 1
        else:
            return 0
    else:
        if (neighborCount == 3):
            return 1
        else:
            return 0


def GoL_CalcNextGen(CurrentGen = [], NextGen = []):
    colCount = 32 # TODO make this dynamic
    rowCount = len(CurrentGen) # assumes CurrentGen is same size as NextGen
    # Top left is 0,0 growing to rowCount,colCount bottom right of playfield
    
    for row in range(rowCount):
        NextGen[row] = 0 #Blank out the future gen row
        for col in range(colCount):
            shiftCnt = colCount - col
            neighborBitCnt = 0
            currentBit = 1 if ((CurrentGen[row] & (1 << shiftCnt)) > 0) else 0
            
            for nbrRow in range(-1,2,1): # Check row above, current and below -> -1, 0, 1
                if ((row + nbrRow) > 0) and ((row + nbrRow) < rowCount):
                    for nbrCol in range (-1,2,1): # Check col left, current and right -> -1, 0, 1
                        if ((col - nbrCol)) > 0 and ((col + nbrCol) < colCount):
                            shiftCnt = (colCount - (col + nbrCol))
                            neighborBitCnt = neighborBitCnt + (1 if ((CurrentGen[row + nbrRow] & (1 << shiftCnt)) > 0) else 0)
                        
            neighborBitCnt = neighborBitCnt - currentBit # Remove current bit from count (noop if it was off)
            
                
            nextGenBit = GoL_FindNextBitState(currentBit, neighborBitCnt)
            #if (neighborBitCnt > 0):
            #   print("NbrCnt: {0}, {1}".format(neighborBitCnt, nextGenBit))
            shiftCnt = colCount - col
            NextGen[row] = NextGen[row] | (nextGenBit << shiftCnt)
            
def GoL_InitR_Pentomino(playbrd):
    for idx in range(len(playbrd)):
        playbrd[idx] = 0b0
        
    playbrd[15] = 0b00000000000000011000000000000000
    playbrd[16] = 0b00000000000000110000000000000000
    playbrd[17] = 0b00000000000000010000000000000000


def GoL_DisplayOnCosmicUnicorn(playbrd):
    # render the heat values to the graphics buffer
    for y in range(CosmicUnicorn.HEIGHT):
        for x in range(CosmicUnicorn.WIDTH):
            bitVal = 1 if ((playbrd[y] & (1 << x)) > 0) else 0
            
            if bitVal == 1:
                graphics.set_pen(palette[3])
                #print ("bitVal is {0},{1} -> {2}".format(x, y, bitVal))
            else:
                graphics.set_pen(palette[0])
            graphics.pixel((CosmicUnicorn.WIDTH - x), y)
            
    cosmic.set_brightness(0.75)
    cosmic.update(graphics)
     
init()

currentIdx = 0
futureIdx = 1

playBoard = [0,0]
playBoard[0] = array.array("I", 0 for x in range(0, 32))
playBoard[1] = array.array("I", 0 for x in range(0, 32))

GoL_InitR_Pentomino(playBoard[currentIdx])

frameCount = 0
while True:
    GoL_CalcNextGen(playBoard[currentIdx], playBoard[futureIdx])
    GoL_DisplayOnCosmicUnicorn(playBoard[currentIdx])
    #time.sleep(0.035)
    GoL_DisplayOnCosmicUnicorn(playBoard[futureIdx])
    #time.sleep(0.030)
    swapIdx = currentIdx
    currentIdx = futureIdx
    futureIdx = swapIdx
    frameCount = frameCount + 1
    
    if frameCount > 100:
        frameCount = 0
        GoL_InitR_Pentomino(playBoard[currentIdx])
        GoL_InitR_Pentomino(playBoard[futureIdx])
        palette[3] = graphics.create_pen(random.randint(0, 254), random.randint(0, 254), random.randint(0, 254))
