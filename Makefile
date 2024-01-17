.PHONY: all clean exStatic exShared copy mk

CUR_DIR := .
INC_DIR := $(CUR_DIR)/inc
BIN_DIR := $(CUR_DIR)/bin
OBJS_DIR := $(CUR_DIR)/objs
SRC_DIR := $(CUR_DIR)/src
LIBS_DIR := $(CUR_DIR)/libs
STATIC_LIB := $(LIBS_DIR)/static
SHARED_LIB := $(LIBS_DIR)/shared

INC_FLAG := -I $(INC_DIR)

exStatic:
	gcc -c $(CUR_DIR)/main.c -o $(OBJS_DIR)/main.o $(INC_FLAG)
	gcc -c $(SRC_DIR)/hello.c -o $(OBJS_DIR)/hello.o $(INC_FLAG)
	gcc -c $(SRC_DIR)/my_math.c -o $(OBJS_DIR)/my_math.o $(INC_FLAG)

	ar rcs $(STATIC_LIB)/libStatic.a $(OBJS_DIR)/hello.o $(OBJS_DIR)/my_math.o

	gcc   $(OBJS_DIR)/main.o  -L$(STATIC_LIB) -lStatic -o $(BIN_DIR)/staticExecute

exShared:
	gcc -c $(CUR_DIR)/main.c -o $(OBJS_DIR)/main.o $(INC_FLAG)
	gcc -c -fPIC $(SRC_DIR)/hello.c -o $(OBJS_DIR)/hello.o $(INC_FLAG)
	gcc -c -fPIC $(SRC_DIR)/my_math.c -o $(OBJS_DIR)/my_math.o $(INC_FLAG)

	gcc -shared $(OBJS_DIR)/hello.o $(OBJS_DIR)/my_math.o -o $(SHARED_LIB)/libShared.so
copy:
	cp -f $(SHARED_LIB)/libShared.so /usr/lib
mk:
	gcc  $(OBJS_DIR)/main.o -L$(SHARED_LIB) -lShared -o $(BIN_DIR)/sharedExecute



all:

clean:
	rm -rf $(OBJS_DIR)/*
	rm -rf $(BIN_DIR)/*
	rm -rf $(STATIC_LIB)/*
	rm -rf $(SHARED_LIB)/*
