main: main.cpp
	mpic++ -o main main.cpp

run: main
	mpirun -hostfile openmpi.host -np 10 ./main --mca opal_warn_on_missing_libcuda 0

.DEFAULT_GOAL := main
all : main

clean:
	rm -f main