data {
    int N;
    real X[N]; // raw data
}
transformed data {
    real sigma = 1.0; // hard-coded constant
    real logX[N];
    
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