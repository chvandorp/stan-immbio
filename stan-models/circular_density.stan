data {
    vector[2] mu;
    cov_matrix[2] sigma;
}
parameters {
    vector[2] x;
}
model {
    real r = sqrt(dot_self(x));
    real theta = atan2(x[2], x[1]);
    
    vector[2] u = [r, theta]';
        
    u ~ multi_normal(mu, sigma);
    
    target += -log(r);
}