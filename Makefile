CC = gcc
LIBS =

CFLAGS  = -std=c23
CFLAGS += -g
# CFLAGS += -DNDEBUG
CFLAGS += -Wall
CFLAGS += -Wextra
CFLAGS += -pedantic
CFLAGS += -Werror

# Add your source files here
SRCS = mydb.c
OBJS = $(SRCS:.c=.o)

.PHONY: all
all: mydb.out

mydb.out: $(OBJS)
	@echo Linking $@
	@$(CC) $(CFLAGS) -o $@ $^ $(LIBS)

%.o: %.c
	@echo Compiling $<
	@$(CC) $(CFLAGS) -c $< -o $@

.PHONY: run
run: mydb.out
	@echo "Running $@"
	@./mydb.out

.PHONY: clean
clean:
	rm -f *.o *.out *.out.dSYM
