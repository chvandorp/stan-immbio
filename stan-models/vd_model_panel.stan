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
    
    vector calc_logVLhat(vector pop_par_vec, vector unit_par_vec, array[] real data_real, array[] int data_int) {
        int N = data_int[1];
        // unpack parameters
        real T0 = pop_par_vec[1];
        real beta = unit_par_vec[1];
        real d_T = unit_par_vec[2];
        real d_I = unit_par_vec[3];
        real I0 = unit_par_vec[4];
        // define unitial state
        vector[2] y0 = [T0, I0]';
        // solve ODE system
        array[N] vector[2] y = ode_rk45(vd_model, y0, 0.0, data_real[1:N], T0, d_T, beta, d_I);      
        // extract values from solution of ODE
        return log(to_vector(y[:, 2]));
    }
}

data {
    int<lower=0> R; // number of replicates
    array[R] int<lower=0> N; // number of observations
    array[R, max(N)] real<lower=0> ObsTime; // observation times
    array[R, max(N)] real<lower=0> VL; // viral load observations
    real<lower=0> T0; // initial target cell concentration
}

transformed data {
    array[R, max(N)] real data_reals = ObsTime;
    array[R, 1] int data_ints;
    data_ints[:,1] = N;
}

parameters {
    // unit-specific parameters
    array[R] real<lower=0> beta; // infection rate
    array[R] real<lower=0> d_T; // death rate target cells
    array[R] real<lower=0> d_I; // death rate infected cells
    array[R] real<lower=0> I0; // initial number of infected cells
    
    // pop-level parameters
    real m_beta; real<lower=0> s_beta;
    real m_d_I; real<lower=0> s_d_I;
    real m_d_T; real<lower=0> s_d_T;
    real m_I0; real<lower=0> s_I0;
    
    real<lower=0> sigma; // measurement of VL
}

transformed parameters {
    vector[1] pop_par_vec = rep_vector(T0, 1);
    array[R] vector[4] unit_par_vecs;
    unit_par_vecs[:,1] = beta;
    unit_par_vecs[:,2] = d_T;
    unit_par_vecs[:,3] = d_I;
    unit_par_vecs[:,4] = I0;
}

model {
    // compute predicted VL with multiple CPU cores
    vector[sum(N)] logVLhat_concat = map_rect(calc_logVLhat, pop_par_vec, unit_par_vecs, data_reals, data_ints);
    // compute likelihood of the data
    for ( r in 1:R ) {
        int idx = sum(N[:r-1]); // index for unpacking
        for ( n in 1:N[r] ) {
            VL[r, n] ~ lognormal(logVLhat_concat[idx+n], sigma);
        }
    }
    // priors
    beta ~ lognormal(m_beta, s_beta);
    d_T ~ lognormal(m_d_T, s_d_T);
    d_I ~ lognormal(m_d_I, s_d_I);
    I0 ~ lognormal(m_I0, s_I0);
    sigma ~ lognormal(0.0, 2.0);    
}

generated quantities {
    // posterior predictive distributions
    real ppd_beta = lognormal_rng(m_beta, s_beta);
    real ppd_d_T = lognormal_rng(m_d_T, s_d_T);
    real ppd_d_I = lognormal_rng(m_d_I, s_d_I);
    real ppd_I0 = lognormal_rng(m_I0, s_I0);
    // viral load predictions
    array[R, max(N)] real VLhat;
    for ( r in 1:R ) {
        vector[2] y0 = [T0, I0[r]]';
        array[N[r]] vector[2] yhat = ode_rk45(vd_model, y0, 0.0, ObsTime[r, 1:N[r]], T0, d_T[r], beta[r], d_I[r]);
        VLhat[r,1:N[r]] = yhat[:, 2];
    }
}