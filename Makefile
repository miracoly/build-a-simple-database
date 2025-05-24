### If you wish to use extra libraries (math.h for instance),
### add their flags here (-lm in our case) in the "LIBS" variable.

LIBS =

###
CFLAGS  = -std=c23
CFLAGS += -g
CFLAGS += -Wall
CFLAGS += -Wextra
CFLAGS += -pedantic
CFLAGS += -Werror
CFLAGS += -Wmissing-declarations

TLIBS =  -lgtest
TLIBS += -lgtest_main
TLIBS += -pthread

###
CXXFLAGS = -std=c++23
CXXFLAGS += -ggdb
CXXFLAGS += -Wall
CXXFLAGS += -Weffc++
CXXFLAGS += -Wextra
# CXXFLAGS += -Wconversion
# CXXFLAGS += -Wsign-conversion
CXXFLAGS += -pedantic
CXXFLAGS += -pedantic-errors
CXXFLAGS += -Werror
CXXFLAGS += -Wmissing-declarations

# Sources
TSRC = $(wildcard ./lib/*/*.test.cpp)
CSRC= $(wildcard ./lib/*/*.c)
MSRC = main.c
ALLSRC = $(MSRC) $(CSRC)

.PHONY: all
all: main.out

.PHONY: run
run: main.out
	@echo "Running $@"
	@./main.out

main.out: main.c $(CSRC)
	@echo Compiling $@
	@$(CC) $(CFLAGS) main.c  $(CSRC) -o main.out $(LIBS)

.PHONY: test
test: test.out
	@echo "Running tests"
	@./test.out

test.out: $(TSRC) $(CSRC)
	@echo Compiling tests: $@
	@$(CXX) $(CXXFLAGS) $(TSRC) $(CSRC) -o $@ $(TLIBS) $(LIBS) 

.PHONY: clean
clean:
	rm -rf *.o *.out *.out.dSYM

