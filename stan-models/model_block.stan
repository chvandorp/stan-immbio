data {
    int N; // number of observations
    real X[N]; // observations
}
parameters {
    real m;
    real<lower=0> s; // positive parameter s
}
model {
    // likelihood as a sampling statement
    for ( i in 1:N ) {
        X[i] ~ normal(m, s);
    }
    
    // specify prior with a sampling statement
    m ~ cauchy(0,1);
    
    // or add values to the "target" directly
    target += -s; // equivalent to s ~ exponential(1)
}
    