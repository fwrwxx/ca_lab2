# Makefile для lab2_make
CC = gcc
CFLAGS = -Iinclude -Wall -Wextra -O2 -fPIC
AR = ar
RANLIB = ranlib

SRC_DIR = src
OBJ_DIR = build_objs

SRCS = $(wildcard $(SRC_DIR)/*.c)
OBJS = $(patsubst $(SRC_DIR)/%.c,$(OBJ_DIR)/%.o,$(SRCS))

STATIC_LIB = libcalc.a
SHARED_LIB = libcalc.so
APP = app

.PHONY: all static shared app clean distclean dirs

all: dirs static app

# створити директорію для .o
dirs:
	@mkdir -p $(OBJ_DIR)

# збірка об'єктів
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@

# статична бібліотека
static: $(OBJS)
	$(AR) rcs $(STATIC_LIB) $(filter $(OBJ_DIR)/math.o,$^)
	$(RANLIB) $(STATIC_LIB)
	@echo "Created $(STATIC_LIB)"

# динамічна (shared) бібліотека
shared: $(OBJS)
	$(CC) -shared -o $(SHARED_LIB) $(filter $(OBJ_DIR)/math.o,$^) 
	@echo "Created $(SHARED_LIB)"

# збірка виконуваного файлу з лінком на статичну бібліотеку
app: static $(OBJ_DIR)/main.o
	$(CC) -o $(APP) $(OBJ_DIR)/main.o $(STATIC_LIB)

# чистка артефактів
clean:
	rm -rf $(OBJ_DIR)/*.o || true
	rm -f $(APP) $(STATIC_LIB) $(SHARED_LIB)

# видалити все (включно з директоріями)
distclean: clean
	rm -rf $(OBJ_DIR)
