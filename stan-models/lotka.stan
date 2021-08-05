functions {
    vector lv_sys(real t, vector u, real a, real b, real c, real d) {
        real x = u[1];
        real y = u[2];
        real dx = a*x - b*x*y;
        real dy = c*b*x*y - d*y;
        return [dx, dy]';
    }
}
data {
    int<lower=0> N; // number of observations
    int<lower=0> Prey[N];
    int<lower=0> Predator[N];
    real t0;
    real<lower=t0> ObsTime[N];
    int<lower=0> K; // sampling volume
    int<lower=0> Nsim;
    real<lower=t0> SimTime[Nsim];
}
parameters {
    real<lower=0> a;
    real<lower=0> b;
    real<lower=0, upper=1> c;
    real<lower=0> d;
    vector<lower=0>[2] u0; // initial state
}
model {
    vector[2] u[N] = ode_rk45(lv_sys, u0, t0, ObsTime, a, b, c, d);
    for ( i in 1:N ) {
        Prey[i] ~ poisson(u[i,1] * K);
        Predator[i] ~ poisson(u[i,2] * K);
    }
}
generated quantities {
    vector[2] uhat[Nsim] = ode_rk45(lv_sys, u0, t0, SimTime, a, b, c, d);
    int PreySim[Nsim];
    int PredatorSim[Nsim];
    for ( i in 1:Nsim ) {
        PreySim[i] = poisson_rng(K * uhat[i,1]);
        PredatorSim[i] = poisson_rng(K * uhat[i,2]);
    }
}