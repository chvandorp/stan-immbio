data {
    int N;
    real TimesL[N]; // lower bounds
    real TimesU[N]; // upper bounds
}
parameters {
    real<lower=0> alpha;
    real<lower=0> beta;
}
model {
    for ( i in 1:N ) {
        real lpL = gamma_lcdf(TimesL[i] | alpha, beta);
        real lpU = gamma_lcdf(TimesU[i] | alpha, beta);
        
        // target += log(exp(lpU) - exp(lpL));
        
        target += log_diff_exp(lpU, lpL);
    }
    // priors?
}
generated quantities {
    real Tsim = gamma_rng(alpha, beta);
}