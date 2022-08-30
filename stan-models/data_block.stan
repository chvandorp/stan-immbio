data {
    int N; // number of observations
    array[N] real X; // array with observations
    real sigma; // known standard deviation
}
parameters {
    real mu;
}
model {
    X ~ normal(mu, sigma);
}