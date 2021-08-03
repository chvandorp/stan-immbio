data {
    int<lower=1> N; // number of observations
    vector[N] X; // independent variable
    vector[N] Y; // dependent variable
}
parameters {
    real a; // slope 
    real b; // intercept
    real<lower=0> sigma; // error
}
model {
    Y ~ normal(a*X + b, sigma);
}