import array
import time
import machine
from cosmic import CosmicUnicorn
from picographics import PicoGraphics, DISPLAY_COSMIC_UNICORN as DISPLAY

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


def GoL_FindNeighborCount(TwoDBitContext):
    nextGenRowMask = 0b111

    ngRowTop = currentTop & nextGenRowMask

    ngRowMid = currentMid & nextGenRowMask
    bitUnderConsideration = (ngRowMid >> 1) & 1
    ngRowMid = ngRowMid & 0b101

    ngRowBottom = currentBottom & nextGenRowMask
  

def GoL_InitR_Pentomino(playbrd):
    playbrd[15] = 0b00000000000000011000000000000000
    playbrd[16] = 0b00000000000000110000000000000000
    playbrd[17] = 0b00000000000000010000000000000000


def GoL_DisplayOnCosmicUnicorn(playbrd):
    # render the heat values to the graphics buffer
    for y in range(CosmicUnicorn.HEIGHT):
        for x in range(CosmicUnicorn.WIDTH):
            bitVal = (playbrd[y] >> x) & 1
            
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

currentTop =    0b000000
currentMid =    0b001111
currentBottom = 0b110110

nextGenRowMask = 0b111

ngRowTop = currentTop & nextGenRowMask

ngRowMid = currentMid & nextGenRowMask
bitUnderConsideration = (ngRowMid >> 1) & 1
ngRowMid = ngRowMid & 0b101

ngRowBottom = currentBottom & nextGenRowMask

currentTop = currentTop >> 3
currentMid = currentMid >> 3
currentBottom = currentBottom >> 3

neighborCount = 0
for idx in range(0,3,1):
    neighborCount = neighborCount + ((ngRowTop >> idx) & 1)
    neighborCount = neighborCount + ((ngRowMid >> idx) & 1)
    neighborCount = neighborCount + ((ngRowBottom >> idx) & 1)
    
print("Neighborcount {0}".format(neighborCount))
print("bitUnderConsideration {0}".format(bitUnderConsideration))
print("bitFuture {0}".format(GoL_FindNextBitState(bitUnderConsideration, neighborCount)))
print("playboardSize {0}".format(len(playBoard[currentIdx])))
print("playboard {0}".format(playBoard[currentIdx]))

while True:
    GoL_DisplayOnCosmicUnicorn(playBoard[currentIdx])
    time.sleep(2)

