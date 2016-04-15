#!/bin/bash

NOW=$(date +%Y%m%d%H%M%s.%N)
NICENESS=10
PARAMS="10 100"
NICE_LOG="nice.log"
RUNS=500

mkdir -p logs/run-${RUNS}

echo "Running timer with $RUNS open process with parameters: $PARAMS"
for (( c=1; c<=$RUNS; c++ ))
do
    ARGS=$PARAMS
    if (( "$c" == 1 ))
    then
        ARGS+=" 1"
    fi

    ./out/timer_usleep $ARGS > logs/run-${RUNS}/runs-${c}.csv &
done

wait
cat logs/run-${RUNS}/*.csv > logs/run-${RUNS}.csv
rm -r logs/run-${RUNS}