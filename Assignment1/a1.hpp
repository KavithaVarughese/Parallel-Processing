/*  Kavitha
 *  Varughese
 *  kavithae
 */

#ifndef A1_HPP
#define A1_HPP

#include <vector>

void col_partial_sum(long long int n, long long int m, std::vector<float>& A) {
    #pragma omp parallel for default(none) shared(A,n,m) schedule(static)
    for (long long int j = 0; j < m; j++) {
        float t = A[j];
        for (long long int i = 1; i < n-1; i++) {
            float current = A[i*m+j];
            A[i*m+j] = t + current + A[(i+1)*m+j];
            t = current;
        }
    }
}

void row_sum(long long int n, long long int m, const std::vector<float>& K, std::vector<float>& A) {
    
    // Calculate K1, K2, K3
    std::vector<float> K_rows_sum(3);
    for (long long int i = 0; i < 3; i++) {
        float sum = 0.0;
        for (long long int j = 0; j < 3; j++) {
            sum += K[i * 3 + j];
        }
        K_rows_sum[i] = sum;
    }

    #pragma omp parallel for default(none) shared(A,K_rows_sum,n,m) schedule(static)
    for (long long int i = 1; i < n - 1; i++) {
        float t = A[i*m];
        for (long long int j = 1; j < m - 1; j++) {
            float current = A[i*m + j];
            A[i*m + j] = t*K_rows_sum[0] + current*K_rows_sum[1] + A[i*m + (j+1)]*K_rows_sum[2];
            t = current;
        }
    }
}

void filter2d(long long int n, long long int m, const std::vector<float>& K, std::vector<float>& A) {

    // Create copy of 1st and last columns
    std::vector<float> A_first_col(n);
    std::vector<float> A_last_col(n);

    #pragma omp parallel for default(none) shared(A_first_col, A_last_col, A,n,m) schedule(static)
    for (long long int i = 0; i < n; i++) {
        A_first_col[i] = A[i * m];
        A_last_col[i] = A[i * m + m - 1];
    }

    col_partial_sum(n, m, A);
    row_sum(n, m, K, A);

    #pragma omp parallel for default(none) shared(A_first_col, A_last_col, A,n,m) schedule(static)
    for (long long int i = 0; i < n; i++) {
        A[i*m] = A_first_col[i];
        A[i * m + m - 1] =  A_last_col[i];
    }


} // filter2d


#endif // A1_HPP
