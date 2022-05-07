# OS filesystem functions
ifeq ($(OS),Windows_NT)
	RM = del /F /Q
	RMDIR = -RMDIR /S /Q
	MKDIR = -mkdir
	ERRIGNORE = 2>NUL || true
	SEP=\\
else
	RM = rm -rf
	RMDIR = rm -rf
	MKDIR = mkdir -p
	ERRIGNORE = 2>/dev/null
	SEP=/
endif

VERBOSE = 0
ifeq ($(VERBOSE),0)
    HIDE = @
else
    HIDE = ""
endif

NAME = PROGRAMNAME

SDIR = src$(SEP)
ODIR = obj$(SEP)

INC = inc$(SEP)
SRC = $(shell find $(SDIR) -type f -name "*.c")
OBJ = $(patsubst $(SDIR)%, $(ODIR)%, $(SRC:.c=.o))
SSUBDIR = $(shell find $(SDIR) -type d -not -empty)

CC = gcc
CFLAGS = -Wall -Wextra -g

EXCMD = bash -c ./

# LIB = -L.$(SEP)libft$(SEP) -lft
# LIBINC = -I libft$(SEP)includes$(SEP)

TESTDIR = test$(SEP)
TESTFILES = main.c test.c test.h
TESTSRC = $(addprefix $(TESTDIR), $(TESTFILES))
TESTOBJ = $(TESTFILES%.c=.o)
TESTH = $(TESTDIR)test.h
TESTBIN = test.out

VALGRIND = valgrind --leak-check=full --show-leak-kinds=all -s

BUILD = bear
BUILDFILE = compile_commands.json

all: greatings $(NAME)

$(NAME): $(ODIR) $(OBJ)
	$(HIDE)$(CC) $(CFLAGS) $(OBJ) $(LIB) -o $(NAME)
	$(HIDE)echo "make   ->  $(NAME) created"

$(ODIR)%.o: $(SSUBDIR)%.c
	$(HIDE)$(CC) -c $(CFLAGS) -I $(INC) $(LIBINC) $< -o $@

$(ODIR):
	$(HIDE)$(MKDIR) $(ODIR)

clean: greatings
	$(HIDE)$(RMDIR) *.o obj
	$(HIDE)echo "clean  ->  objects deleted"

fclean: clean
	$(HIDE)$(RMDIR) $(NAME)
	$(HIDE)echo "fclean ->  $(NAME) deleted"

re : fclean all
	$(HIDE)echo "re     ->  $(NAME) reloaded"

$(TESTDIR)%.o: $(TESTDIR)%.c
	$(HIDE)$(CC) -c $(CFLAGS) $(pkg-config --libs libbsd) -I $(INC) $< -o $@
	$(HIDE)echo "test    ->  $@"

teststart: $(NAME) $(TESTDIR)*.o
	$(HIDE)echo
	$(HIDE)echo "--- Bin exec ---"
	$(HIDE)echo
	$(HIDE)$(CC) $(TESTH) $(TESTSRC) -I $(INC) -L. -lft -o $(TESTBIN)
	$(HIDE)chmod u+x $(TESTBIN)

$(TESTDIR)$(TESTBIN):
	$(HIDE)$(MKDIR) %@

test: teststart $(TESTDIR)$(TESTBIN)
	$(HIDE)./$(TESTBIN)

build: clean
	$(HIDE)$(BUILD) --output $(BUILDFILE) 2> /dev/null -- make

ex:
	$(HIDE)$(EXCMD)$(NAME)

valgrind: re $(NAME)
	$(HIDE)echo
	$(HIDE)echo "--- Valgrind ---"
	$(HIDE)echo
	$(HIDE)chmod u+x $(NAME)
	$(HIDE)$(VALGRIND) ./$(NAME) $(TEST)

greatings:
	@echo "####################"
	@echo "##### MAKEFILE #####"
	@echo "####################"
