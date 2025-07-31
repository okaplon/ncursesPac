# PACMAN MAKEFILE
# make all        Builds the package + documentation
# make run        Builds and runs the program
# make clean      Cleans results of building process
# make doc        Generates the documentation with doxygen
# make docclean   Removes the documentation



# General Info
PACKAGE = npac
VERSION = 1
DATE    = $(shell date "+%b%Y")


# Misc stuff
PNGDIR     = $(DATAROOTDIR)/icons/hicolor
XPMDIR     = $(DATAROOTDIR)/pixmaps
DESKTOPDIR = $(DATAROOTDIR)/applications
LEVELDIR   = $(DATAROOTDIR)/games/nsnake/levels

# Things for the man page

# Build info
EXE         = $(PACKAGE)
CDEBUG      = -O0
CXXFLAGS    = $(CDEBUG) -c -g -Wno-reorder -std=c++11 -Wall -pedantic -Wno-long-long -O0 -ggdb $(CFLAGS_PLATFORM) # -Wall -Wextra
LDFLAGS     = -lmenuw -lncursesw $(LDFLAGS_PLATFORM)
INCLUDESDIR = -I"src/"
LIBSDIR     =
LDLIBS += -lncursesw

# Project source files
CXXFILES = $(shell find src -type f -name '*.cpp')
OBJECTS  = $(CXXFILES:.cpp=.o)


DEFINES = -DVERSION=\""$(VERSION)"\"                  \
          -DPACKAGE=\""$(PACKAGE)"\"                  \
          -DDATE=\""$(DATE)"\"                        \
          -DSYSTEM_LEVEL_DIR=\""$(LEVELDIR)"\"


# Verbose mode check:
#V = 1;
ifdef V
MUTE =
VTAG = -v
else
MUTE = @
endif

# Make targets
all:compile doc
	# Build successful!

compile: $(BIN) 

$(BIN): $(OBJECTS) $(ENGINE_OBJECTS) $(COMMANDER_OBJECTS)



	-$(MUTE)rm $(VTAG) -rf doc

	$(MUTE)rm $(VTAG) -f $(OBJECTS)
	$(MUTE)rm $(VTAG) -f $(BIN)
	# Cleaning object files...
	$(MUTE)rm $(VTAG) -f $(ENGINE_OBJECTS) $(COMMANDER_OBJECTS)clean-all: clean

clean: docclean
	# Cleaning object files...
docclean:
	# Cleaning documentation...
	# Generating documentation...
	$(MUTE)doxygen Doxyfile
doc:
run: compile 

	# Running...
	./$(BIN)
	$(CXX) $(CXXFLAGS) $(CDEBUG) $< -c -o $@ $(DEFINES) $(INCLUDESDIR)

src/%.o: src/%.cpp
	# Compiling $<...
	$(CXX) $(OBJECTS) $(ENGINE_OBJECTS) $(COMMANDER_OBJECTS) -o $(BIN) $(LIBSDIR) $(LDFLAGS)
	# Linking...
	#


