#!/bin/bash

PARAMS="2 1000"
RUNS=500
NICE_LOG="logs/nice-runs-fifo.csv"

mkdir -p logs/fifo

echo "Running timer with $RUNS open process with parameters: $PARAMS"
echo "actual_time, expected_time, pid, niceness, delay, iterations, scheduler" > $NICE_LOG

for (( c=1; c<=$RUNS; c++ ))
do
    if (( "$c" == 1 ))
    then
        ./out/fifo $PARAMS yes > logs/fifo/log-${c}.csv &
    fi

    ./out/timer_usleep $PARAMS yes > logs/fifo/log-${c}.csv &
done

cat logs/fifo/*.csv >> $NICE_LOG
rm -r logs/fifo

wait