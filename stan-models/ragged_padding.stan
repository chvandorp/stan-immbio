data {
    int<lower=0> N; // number of rows
    int<lower=0> M[N]; // number of elements per row
    real X[N, max(M)]; // padded array
}
parameters {
    real mu[N]; // group means
    real<lower=0> sigma[N]; // group standard deviation
}
model {
    // access data
    for ( i in 1:N ) {
        X[i, 1:M[i]] ~ normal(mu[i], sigma[i]);
    }        
}
    