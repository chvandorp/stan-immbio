data {
    int<lower=1> N; // number of observations
    vector[N] X; // independent variable
    vector[N] Y; // dependent variable
    /* auxiliary items for generating output */
    int<lower=0> Nsim;
    vector[Nsim] Xsim;
}
parameters {
    real a; // slope 
    real b; // intercept
    real<lower=0> sigma; // error
}
model {
    Y ~ normal(a*X + b, sigma);
}
generated quantities {
    vector[Nsim] Yhat;
    vector[Nsim] Ysim;
    for ( n in 1:Nsim ) {
        Yhat[n] = a*Xsim[n] + b;
        Ysim[n] = normal_rng(a*Xsim[n] + b, sigma);
    }
}