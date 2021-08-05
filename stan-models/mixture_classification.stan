data {
    int N;
    real X[N];
}
parameters {
    ordered[2] mu; // take care of identifiability
    vector<lower=0>[2] sigma;
    real<lower=0, upper=1> p; // probability positive
}
model {
    for ( i in 1:N ) {
        target += log_mix(p,
            normal_lpdf(X[i] | mu[2], sigma[2]),
            normal_lpdf(X[i] | mu[1], sigma[1])
        );
    }
}
generated quantities {
    vector[N] ppos;
    for ( i in 1:N ) {
        real l1 = exp(normal_lpdf(X[i] | mu[1], sigma[1]));
        real l2 = exp(normal_lpdf(X[i] | mu[2], sigma[2]));
        ppos[i] = p * l2 / ((1-p) * l1 + p * l2);
    }
}