# Compiler
CC=/usr/bin/env i686-w64-mingw32-gcc
STRIP=/usr/bin/env strip -s
INSTALL=/usr/bin/env install -C
# Arguments
CFLAGS=-c -Wall -Wextra
LSFLAGS=-lm
# Quiet
Q=@
# Dirs
ODIR=build
BDIR=bin
INSTALL_PREFIX=/path/to/install/

vpath %.c src/
SOURCES=source.c

OBJECTS=$(patsubst %.c, build/%.o, $(SOURCES))
EXECUTABLE=$(ODIR)/out

all: $(EXECUTABLE)

debug: CC += -DDEBUG -ggdb
debug: $(EXECUTABLE)

install:
	$(Q) $(INSTALL) $(EXECUTABLE) $(INSTALL_PREFIX)/

$(EXECUTABLE): $(OBJECTS) | dirs
	$(Q)$(CC) $(LSFLAGS) $(OBJECTS) -o $@

$(OBJECTS) : | dirs

dirs:
	$(Q)mkdir -p $(ODIR) ; mkdir -p $(BDIR)

$(ODIR)/%.o : %.c
	$(Q)echo $<
	$(Q)$(CC) $(CFLAGS) -c $< -o $@

clean:
	$(Q)rm -f $(ODIR)/*.o $(BDIR)/*
