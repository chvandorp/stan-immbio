data {
    int<lower=1> N; // number of observations
    vector[N] X; // independent variable
    vector[N] Y; // dependent variable
    /* option for removing slope parameter */
    int<lower=0, upper=1> NullModel;
}
parameters {
    real a[NullModel ? 0 : 1]; // optional slope parameter
    real b; // intercept
    real<lower=0> sigma; // error
}
model {
    if ( NullModel ) {
        Y ~ normal(b, sigma);
    } else {
        Y ~ normal(a[1]*X + b, sigma);
    }
}
generated quantities {
    // keep track of likelihoods of each observation
    vector[N] log_lik;
    for ( i in 1:N ) {
        if ( NullModel ) {
            log_lik[i] = normal_lpdf(Y[i] | b, sigma);
        } else {
            log_lik[i] = normal_lpdf(Y[i] | a[1]*X[i] + b, sigma);
        }
    }
}