parameters {
    real<lower=0, upper=1> x;
    real<lower=0> y;
}
model {
    x ~ beta(0.5, 0.5);
    y ~ exponential(1.0);
}
    