functions {
    vector vd_model(real t, vector y, real T0, real d_T, real beta, real d_I) {
        // unpack y
        real T = y[1];
        real I = y[2];
        // compute compound parameters
        real lambda = T0 * d_T;
        // compute derivatives
        vector[2] dy;
        dy[1] = lambda - d_T * T - beta * T * I / T0; // dT/dt
        dy[2] = beta * T * I / T0 - d_I * I; // dI/dt
        return dy;
    }
}

data {
    int<lower=0> N; // number of observations
    real<lower=0> ObsTime[N]; // observation times
    real<lower=0> VL[N]; // viral load observations
    real<lower=0> T0; // initial target cell concentration
}

parameters {
    real<lower=0> beta; // infection rate
    real<lower=0> d_T; // death rate target cells
    real<lower=0> d_I; // death rate infected cells
    real<lower=0> I0; // initial number of infected cells
    real<lower=0> sigma; // measurement of VL
}

model {
    // initial condition
    vector[2] y0 = [T0, I0]';
    // solve ODE system
    vector[2] y[N] = ode_rk45(vd_model, y0, 0.0, ObsTime, T0, d_T, beta, d_I);
    // compute likelihood of the data
    for ( n in 1:N ) {
        VL[n] ~ lognormal(log(y[n, 2]), sigma);
    }
    // priors
    beta ~ lognormal(0.0, 2.0);
    d_T ~ lognormal(0.0, 2.0);
    d_I ~ lognormal(0.0, 2.0);
    I0 ~ lognormal(0.0, 2.0);
    sigma ~ lognormal(0.0, 2.0);
}

generated quantities {
    vector[2] y0 = [T0, I0]';
    vector[2] yhat[N] = ode_rk45(vd_model, y0, 0.0, ObsTime, T0, d_T, beta, d_I);
}