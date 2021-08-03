data {
    int N;
    real X[N];
}
parameters {
    ordered[2] mu; // take care of identifiability
    vector<lower=0>[2] sigma;
    real<lower=0, upper=1> p;
}
model {
    // log_mix(q, a, b) = log(q * exp(a) + (1-q) * exp(b))
    for ( i in 1:N ) {
        target += log_mix(1-p,
            normal_lpdf(X[i] | mu[1], sigma[1]),
            normal_lpdf(X[i] | mu[2], sigma[2])
        );
    }
}