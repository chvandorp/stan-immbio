parameters {
    real x; // x is unbounded!
    real y;
}
model {
    x ~ beta(0.5, 0.5); // ERROR! x must be in [0,1]
    y ~ exponential(1.0); // ERROR! y must be in non-negative
}
    