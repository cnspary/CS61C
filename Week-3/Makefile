CC=gcc
LD=gcc
CFLAGS=-ggdb -Wall -std=c99
LDFLAGS=
BIN=hello

FUNC_OBJ=func.o
MAIN_OBJ=main.o


all: $(BIN)

$(BIN): $(FUNC_OBJ) $(MAIN_OBJ)
	@$(CC) -g -o $(BIN) $(FUNC_OBJ) $(MAIN_OBJ) $(LDFLAGS)

$(MAIN_OBJ): main.c
	@$(CC) $(CFLAGS)  -c -o $(MAIN_OBJ) main.c	

$(FUNC_OBJ): func.c
	@$(CC) $(CFLAGS)  -c -o $(FUNC_OBJ) func.c

func.c: func.h

clean:
	@rm *.o $(BIN)
