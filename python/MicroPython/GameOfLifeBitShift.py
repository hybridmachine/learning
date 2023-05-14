###########
# Implementation of John Conway's game of life using bit shifting in Python, targeting MicroPython
# The intention is to use this to drive a Pimoroni Cosmic LED grid
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

