data {
    int<lower=0> N; // number of rows
    int<lower=0> M[N]; // number of elements per row
    real X[sum(M)]; // concatenated array
}
parameters {
    real mu[N]; // group means
    real<lower=0> sigma[N]; // group standard deviation
}
model {
    // access data
    for ( i in 1:N ) {
        int a = sum(M[:i-1]) + 1;
        int b = sum(M[:i]);
        X[a:b] ~ normal(mu[i], sigma[i]);
    }        
}
    