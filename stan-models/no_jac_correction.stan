parameters {
    real<lower=0> theta1;
    real<lower=0> theta2;
}
model {
    theta1 ~ lognormal(0, 1); 
    log(theta2) ~ normal(0, 1); // theta1 ~ theta2 ???
}