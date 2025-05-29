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
# CFLAGS += -Wmissing-declarations

.PHONY: all
all: mydb.out

.PHONY: run
run: mydb.out
	@echo "Running $@"
	@./mydb.out

mydb.out: mydb.c
	@echo Compiling $@
	@$(CC) $(CFLAGS) mydb.c -o mydb.out $(LIBS)

.PHONY: clean
clean:
	rm -rf *.o *.out *.out.dSYM

