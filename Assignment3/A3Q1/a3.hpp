/*  KAVITHA
 *  VARUGHESE
 *  kavithae
 */

#ifndef A3_HPP
#define A3_HPP

// cuda code of gaussian_kde in a3.cu
void gaussian_kde(int n, float h, const std::vector<float>& x, std::vector<float>& y); 

void gaussian_kde_seq(int n, float h, const std::vector<float>& x, std::vector<float>& y);

#endif // A3_HPP
