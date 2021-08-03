functions {
    // constants are functions with no arguments
    real apery() { // zeta(3)
        return 1.202056903159594285399738161511449990764986292;
    }
    // probability distribution/mass functions (log scale)
    real skellam_lpmf(int n, real mu1, real mu2) {
        real In = modified_bessel_first_kind(n, 2*sqrt(mu1*mu2));
        return -(mu1 + mu2) + 0.5*n*log(mu1/mu2) + log(In);
    }
}
// other blocks...