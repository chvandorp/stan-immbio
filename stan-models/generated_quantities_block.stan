parameters {
    real<lower=0> mu;
}
model {
    mu ~ exponential(1);
}
generated quantities {
    int k = poisson_rng(mu);
}