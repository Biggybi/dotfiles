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
SSUBDIR = $(shell find $(SDIR) -type d -not -empty)$(SEP)

CC = clang
CFLAGS = -Wall -Wextra -g

# LIB = -L.$(SEP)libft$(SEP) -lft
# LIBINC = -I libft$(SEP)includes$(SEP)

TEST = test
TESTF = test$(SEP)
TESTFF = $(addprefix $(TESTF), $(TEST))
VALGRIND = valgrind --leak-check=full --show-leak-kinds=all -s

all: greatings $(NAME)

$(NAME): $(ODIR) $(OBJ)
	$(HIDE)$(CC) $(CFLAGS) $(OBJ) $(LIB) -o $(NAME)
	$(HIDE)echo "make   ->  $(NAME) created"

$(ODIR)%.o: $(SSUBDIR)%.c
	$(HIDE)$(CC) -c $(CFLAGS) -I $(INC) $(LIBINC) $^ -o $@

$(ODIR):
	$(HIDE)$(MKDIR) $(ODIR)

clean: greatings
	$(HIDE)$(RMDIR) *.o obj
	$(HIDE)echo "clean  ->  *.o deleted"

fclean: clean
	$(HIDE)$(RMDIR) $(NAME)
	$(HIDE)echo "fclean ->  $(NAME) deleted"

re : fclean all
	$(HIDE)echo "re     ->  $(NAME) reloaded"

test: re $(NAME)
	$(HIDE)echo
	$(HIDE)echo "--- Bin exec ---"
	$(HIDE)echo
	$(HIDE)chmod u+x $(NAME)
	$(HIDE)./$(NAME) $(TESTFF)

valgrind: re $(NAME)
	$(HIDE)echo
	$(HIDE)echo "--- Valgrind ---"
	$(HIDE)echo
	$(HIDE)chmod u+x $(NAME)
	$(HIDE)$(VALGRIND) ./$(NAME) $(TESTFF)

greatings:
	@echo "####################"
	@echo "##### MAKEFILE #####"
	@echo "####################"
