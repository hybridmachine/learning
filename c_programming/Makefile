# Makefile for explore_floating_point

CC = gcc
CFLAGS = -Wall -Wextra -std=c11
TARGET = explore_floating_point
LINKOPT = -lm
all: $(TARGET)

$(TARGET): $(TARGET).o
	$(CC) $(CFLAGS) -o $(TARGET) $(TARGET).o $(LINKOPT)

$(TARGET).o: $(TARGET).c
	$(CC) $(CFLAGS) -c $(TARGET).c

clean:
	rm -f $(TARGET) $(TARGET).o

.PHONY: all clean