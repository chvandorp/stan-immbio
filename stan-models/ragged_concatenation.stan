data {
    int<lower=0> N; // number of rows
    array[N] int<lower=0> M; // number of elements per row
    array[sum(M)] real X; // concatenated array
}
parameters {
    array[N] real mu; // group means
    array[N] real<lower=0> sigma; // group standard deviation
}
model {
    // access data
    for ( i in 1:N ) {
        int a = sum(M[:i-1]) + 1;
        int b = sum(M[:i]);
        X[a:b] ~ normal(mu[i], sigma[i]);
    }        
}
    