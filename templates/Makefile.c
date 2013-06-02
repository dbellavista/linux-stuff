# Compiler
CC=gcc
# Arguments
CFLAGS=-c -Wall -Wextra
LSFLAGS=-lm

vpath %.c src/
SOURCES=source.c
OBJECTS=$(patsubst %.c, build/%.o, $(SOURCES))
TEST_OBJS=$(patsubst %.c, build/%.o, $(TESTS))
EXECUTABLE=bin/out

all: $(SOURCES) $(EXECUTABLE)

$(EXECUTABLE): bin $(OBJECTS)
	@$(CC) $(LSFLAGS) $(OBJECTS) -o $@

$(OBJECTS) : | build

build:
	@mkdir -p $@

bin:
	@mkdir -p $@

build/%.o : %.c
	@echo $<
	@$(CC) $(CFLAGS) -c $< -o $@

clean:
		rm -f $(EXECUTABLE)
		rm -rf bin
		rm -rf build
