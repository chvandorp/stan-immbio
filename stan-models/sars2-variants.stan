data {
    int<lower=0> N;
    int<lower=0> K;
    int<lower=0> Counts[N, K];
    vector[N] Time;
}
parameters {
    vector[K-1] alpha_raw;
    vector[K-1] beta_raw;
}
transformed parameters {
    vector[K] alpha = append_row(alpha_raw, 0.0);
    vector[K] beta = append_row(beta_raw, 0.0);
}
model {
    for ( i in 1:N ) {
    vector[N] logit_p = alpha * Time[i] + beta;
        Counts[i,:] ~ multinomial_logit(logit_p);
    }
}
generated quantities {
    vector[K] p_hat[N];
    for ( i in 1:N ) {
        p_hat[i,:] = softmax(alpha * Time[i] + beta);
    }
}
