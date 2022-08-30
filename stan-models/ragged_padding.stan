data {
    int<lower=0> N; // number of rows
    array[N] int<lower=0> M; // number of elements per row
    array[N, max(M)] real X; // padded array
}
parameters {
    array[N] real mu; // group means
    array[N] real<lower=0> sigma; // group standard deviation
}
model {
    // access data
    for ( i in 1:N ) {
        X[i, 1:M[i]] ~ normal(mu[i], sigma[i]);
    }        
}
    