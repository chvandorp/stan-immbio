functions {   
    real hypoexp_lpdf(real t, vector a) {
        int n = num_elements(a);
        // construct matrix Q
        matrix[n,n] Q = -diag_matrix(a);
        for ( i in 1:n-1 ) {
            Q[i, i+1] = a[i];
        }
        // compute density
        vector[n] y = matrix_exp(t*Q) * Q * rep_vector(1.0, n);
        return log(-y[1]);
    }
}
data {
    int<lower=1> n;
    vector<lower=0>[n] a;
}
parameters {
    real<lower=0> t;
}
model {
    t ~ hypoexp(a);
}
generated quantities {
    real x = sum(exponential_rng(a));
}