#!/bin/bash
echo "P\N,1000000, 16000000, 32000000, 6400000, 128000000" > results.csv

p=(1 16 32 64 128)

# Read through the file line by line
i=0
j=0

# iternate through p
for p_i in "${p[@]}"; do
    while read -r line; do
        # Check if the line starts with "++++ n="
        if [[ $line =~ ^\+\+\+\+\ n=([0-9]+) ]]; then
            # Extract n and p from the line
            n_i=${BASH_REMATCH[1]}

            read -r line;
            if [[ $n_i == 1280000000 ]]; then
                echo "$line" >> results.csv
            elif [[ $n_i == 10000000 ]]; then
                echo -n "$p_i," >> results.csv
                echo -n "$line," >> results.csv
            else
                echo -n "$line," >> results.csv
            fi
        fi
    done < output_11/a2_${p_i}.out
done

echo "CSV File creation completed"
