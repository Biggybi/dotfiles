NAME = PROGRAMNAME

SDIR = src
ODIR = obj
# LIB = -L./libft/ -lft

TEST = test
TESTF = test/
TESTFF = $(addprefix $(TESTF), $(TEST))

INC = inc/
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

SRC = $(shell find $(SDIR) -name "*.c")
OBJ = $(patsubst $(SDIR)%, $(ODIR)%, $(SRC:.c=.o))
SSUBDIR = $(shell find $(SDIR) -type d -not -empty)

CC = clang
CFLAGS = -Wall -Wextra -g

all: $(NAME)

$(NAME): $(ODIR) $(OBJ)
	$(HIDE)$(CC) $(CFLAGS) $(OBJ) $(LIB) -o $(NAME)
	$(HIDE)echo "make   ->  $(NAME) created"

$(ODIR)$(SEP)%.o: $(SSUBDIR)$(SEP)%.c
	$(HIDE)$(CC) -c $(CFLAGS) -I $(INC)$(SEP) $^ -o $@

$(ODIR):
	$(HIDE)$(MKDIR) $(ODIR)

clean: start
	$(HIDE)$(RMDIR) *.o obj
	$(HIDE)echo "clean  ->  *.o deleted"

fclean: clean
	$(HIDE)$(RMDIR) $(NAME)
	$(HIDE)echo "fclean ->  $(NAME) deleted"

re : fclean all
	$(HIDE)echo "re     ->  $(NAME) reloaded"

ex: re $(NAME)
	$(HIDE)echo
	$(HIDE)echo "--- Bin exec ---"
	$(HIDE)echo
	$(HIDE)chmod u+x $(NAME)
	$(HIDE)./$(NAME) $(TESTFF)

start:
	@echo "####################"
	@echo "##### MAKEFILE #####"
	@echo "####################"
