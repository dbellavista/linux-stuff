# Compiler
CXX=/usr/bin/env g++
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

vpath %.cpp src/
SOURCES=source.cpp

OBJECTS=$(patsubst %.cpp, build/%.o, $(SOURCES))
EXECUTABLE=$(ODIR)/out

all: $(EXECUTABLE)

debug: CXX += -DDEBUG -ggdb
debug: $(EXECUTABLE)

install:
	$(Q) $(INSTALL) $(EXECUTABLE) $(INSTALL_PREFIX)/

$(EXECUTABLE): $(OBJECTS) | dirs
	$(Q)$(CXX) $(LSFLAGS) $(OBJECTS) -o $@

$(OBJECTS) : | dirs

dirs:
	$(Q)mkdir -p $(ODIR) ; mkdir -p $(BDIR)

$(ODIR)/%.o : %.cpp
	$(Q)echo $<
	$(Q)$(CXX) $(CFLAGS) -c $< -o $@

clean:
	$(Q)rm -f $(ODIR)/*.o $(BDIR)/*
