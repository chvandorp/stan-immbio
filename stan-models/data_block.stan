data {
    int N; // number of observations
    real X[N]; // array with observations
    real sigma; // known standard deviation
}
parameters {
    real mu;
}
model {
    X ~ normal(mu, sigma);
}