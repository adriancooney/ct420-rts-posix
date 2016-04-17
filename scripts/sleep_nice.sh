#!/bin/bash

PARAMS="2 1000"
RUNS=500
NICE_LOG="logs/nice-runs.csv"

mkdir -p logs

echo "Running timer with $RUNS open process with parameters: $PARAMS"
echo "actual_time, expected_time, pid, niceness, delay, iterations" > $NICE_LOG
for (( u=-20; u<=20; u++ ))
do
    for (( c=1; c<=$RUNS; c++ ))
    do
        if (( "$c" == 1 ))
        then
            nice -n $u ./out/timer_usleep $PARAMS yes >> $NICE_LOG &
        fi

        ./out/timer_usleep $PARAMS &
    done

    wait
done