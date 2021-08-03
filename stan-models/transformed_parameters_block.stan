data {
    int N; // number of experiments
    int SndInfections[N]; // secondary infections
}
parameters {
    real<lower=0> beta; // transmission rate
    real<lower=0> gamma; // death rate
}
transformed parameters {
    real R0 = beta / gamma; // basic reproduction number
}
model {
    // prior
    beta ~ exponential(1);
    gamma ~ exponential(1);
    
    // likelihood
    SndInfections ~ poisson(R0);
}
