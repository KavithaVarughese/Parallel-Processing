#!/bin/bash
echo "N\P,1,2,4,8,16,32" > results.csv

# Read through the file line by line
i=0
j=0
while read -r line; do
    # Check if the line starts with "++++ n="
    if [[ $line =~ ^\+\+\+\+\ n=([0-9]+)\ p=([0-9]+)\ k=[0-9]+ ]]; then
        # Extract n and p from the line
        n_i=${BASH_REMATCH[1]}
        p_i=${BASH_REMATCH[2]}

        read -r line;
        if [[ $p_i == 32 ]]; then
            echo "$line" >> results.csv
            i=$((i+1))
            j=0
        elif [[ $p_i == 1 ]]; then
            echo -n "$n_i," >> results.csv
            echo -n "$line," >> results.csv
        else
            echo -n "$line," >> results.csv
        fi
    fi
done < a0.out

echo "CSV File creation completed"
