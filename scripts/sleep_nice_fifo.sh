#!/bin/bash

PARAMS="2 1000"
RUNS=500
NICE_LOG="logs/nice-runs-fifo.csv"

mkdir -p logs

echo "Running timer with $RUNS open process with parameters: $PARAMS"
echo "actual_time, expected_time, pid, niceness, delay, iterations" > $NICE_LOG

for (( c=1; c<=$RUNS; c++ ))
do
    if (( "$c" == 1 ))
    then
        ./out/fifo $PARAMS yes >> $NICE_LOG &
    fi

    ./out/timer_usleep $PARAMS &
done

wait