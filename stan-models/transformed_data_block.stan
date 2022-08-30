data {
    int N;
    array[N] real X; // raw data
}
transformed data {
    real sigma = 1.0; // hard-coded constant
    array[N] real logX;
    
    for ( i in 1:N ) {
        logX[i] = log(X[i]); // transform the data
    }
}
parameters {
    real mu;
}
model {
    // log(X) ~ normal(mu, sigma);
    logX ~ normal(mu, sigma); // more efficient
}