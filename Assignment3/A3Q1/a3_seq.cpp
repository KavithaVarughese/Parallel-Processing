#include <vector>
#include <cmath>
#include "a3.hpp"

void gaussian_kde_seq(int n, float h, const std::vector<float>& x, std::vector<float>& y) {
    for (int i = 0; i < n; i++) {
        float sum = 0.0;
        for (int j = 0; j < n; j++) {
            float diff = (x[i] - x[j]) / h;
            sum += (expf(-0.5 * diff * diff) / (sqrtf(2.0 * M_PI)));
        }
        y[i] = sum / (n * h);
    }
}