# Compliler and flags compilation
CC = gcc
FLAGS = -g -Wall

# Constants for build, source, headers and bin directories
HDR_DIR = include
SRC_DIR = src
OBJ_DIR = build
EXE_DIR = bin

# Prossesing and Sorting directories constants
PRS_DIR = Processing
SRT_DIR = Sorting

# Compilation command
all: build bin $(EXE_DIR)/mysort $(EXE_DIR)/MergeSort

# MAIN APPLICATION

$(EXE_DIR)/mysort: $(OBJ_DIR)/main.o $(OBJ_DIR)/coordinatorSpliterMergerReporter.o $(OBJ_DIR)/workSpliterResultMerger.o $(OBJ_DIR)/sorter.o
	$(CC) $(FLAGS) -o $(EXE_DIR)/mysort $(OBJ_DIR)/main.o $(OBJ_DIR)/coordinatorSpliterMergerReporter.o $(OBJ_DIR)/workSpliterResultMerger.o $(OBJ_DIR)/sorter.o

$(OBJ_DIR)/main.o: $(SRC_DIR)/main.c $(HDR_DIR)/coordinatorSpliterMergerReporter.h
	$(CC) $(FLAGS) -o $(OBJ_DIR)/main.o -c $(SRC_DIR)/main.c

$(OBJ_DIR)/coordinatorSpliterMergerReporter.o: $(SRC_DIR)/$(PRS_DIR)/coordinatorSpliterMergerReporter.c $(HDR_DIR)/coordinatorSpliterMergerReporter.h $(HDR_DIR)/record.h
	$(CC) $(FLAGS) -o $(OBJ_DIR)/coordinatorSpliterMergerReporter.o -c $(SRC_DIR)/$(PRS_DIR)/coordinatorSpliterMergerReporter.c

$(OBJ_DIR)/workSpliterResultMerger.o: $(SRC_DIR)/$(PRS_DIR)/workSpliterResultMerger.c $(HDR_DIR)/workSpliterResultMerger.h
	$(CC) $(FLAGS) -o $(OBJ_DIR)/workSpliterResultMerger.o -c $(SRC_DIR)/$(PRS_DIR)/workSpliterResultMerger.c

$(OBJ_DIR)/sorter.o: $(SRC_DIR)/$(PRS_DIR)/sorter.c $(HDR_DIR)/sorter.h
	$(CC) $(FLAGS) -o $(OBJ_DIR)/sorter.o -c $(SRC_DIR)/$(PRS_DIR)/sorter.c

# MERGE SORT

$(EXE_DIR)/MergeSort: $(OBJ_DIR)/MergeSort.o
	$(CC) $(FLAGS) -o $(EXE_DIR)/MergeSort $(OBJ_DIR)/MergeSort.o

$(OBJ_DIR)/MergeSort.o: $(SRC_DIR)/$(SRT_DIR)/MergeSort.c
	$(CC) $(FLAGS) -o $(OBJ_DIR)/MergeSort.o -c $(SRC_DIR)/$(SRT_DIR)/MergeSort.c

.PHONY: clean

# Create the build directory for the object files
build:
	mkdir build

# Create the bin directory for the executable files
bin:
	mkdir bin

# Commands that cleans the workspace
clean:
	rm $(OBJ_DIR)/main.o $(OBJ_DIR)/coordinatorSpliterMergerReporter.o $(OBJ_DIR)/workSpliterResultMerger.o $(OBJ_DIR)/sorter.o $(EXE_DIR)/mysort
	rm $(OBJ_DIR)/MergeSort.o $(EXE_DIR)/MergeSort
	rmdir build
	rmdir bin

run_test:
	./$(EXE_DIR)/mysort -i 'Data/voters50.bin' -k 1 -e1 MergeSort -e2 MergeSort

run_test_v:
	valgrind -s ./$(EXE_DIR)/mysort -i 'Data/voters50.bin' -k 2 -e1 MergeSort -e2 MergeSort
