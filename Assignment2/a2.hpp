/*  YOUR_FIRST_NAME
 *  YOUR_LAST_NAME
 *  YOUR_UBIT_NAME
 */

#ifndef A2_HPP
#define A2_HPP

#include <vector>
#include <mpi.h>

const int RANGE = 65536; // Number of values in short int
const int OFFSET = 32768; // half the values would be negative

void isort(std::vector<short int>& Xi, MPI_Comm comm) {
     // Using std::copy and std::ostream_iterator
    int size, rank;

    MPI_Comm_size(comm, &size);
    MPI_Comm_rank(comm, &rank);

    std::vector<int> local_count(RANGE, 0);

    // Count the occurrences of each value and save in local_count
    for (const auto &x : Xi) {
        local_count[x + OFFSET]++;
    }

    std::vector<int> global_count(RANGE, 0);

    // Gather counts from all processes
    MPI_Reduce(local_count.data(), global_count.data(), RANGE, MPI_INT, MPI_SUM, 0, comm);

    // Send global count to all processors
    MPI_Bcast(global_count.data(), RANGE, MPI_INT, 0, comm);

    /*
         Divide global count vector equally to each processor
	 Let each processor convert the counts back to the values and build Xi locally
    */
    int start = rank * (RANGE / size);
    int end = (rank + 1) * (RANGE / size);
    int loc_n = std::accumulate(global_count.begin() + start, global_count.begin() + end, 0);
    
    Xi.resize(loc_n);

    // Enter values in to Xi
    int index = 0;
    for (int i = start; i < end; i++ ) {
        while (global_count[i]-- > 0) {
            Xi[index++] = i - OFFSET;
        }
    }
} // isort

#endif // A2_HPP
