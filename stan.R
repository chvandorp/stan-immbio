## install cmdstanr and rstan

#install.packages("cmdstanr", repos = c("https://mc-stan.org/r-packages/", getOption("repos")))
#install.packages(c("rstan", "loo", "brms"))

library(cmdstanr)
library(rstan)
library(loo)
library(brms)

## make sure that cmdstanr can find cmdstan

set_cmdstan_path("~/.cmdstanpy/cmdstan-2.27.0")

## regression model

sm <- cmdstan_model(stan_file="stan-models/linreg.stan")

a_gt <- 0.3
b_gt <- 0.5
sigma_gt <- 0.6

N <- 100
X <- rnorm(N)
Y <- a_gt * X + b_gt + rnorm(N, sd=sigma_gt)

plot(X, Y)

Nsim <- 100
Xsim <- seq(-1, 1, length.out=Nsim)

data_list <- list(N=N, X=X, Y=Y, Nsim=Nsim, Xsim=Xsim)

sam <- sm$sample(data=data_list)

## use some of the rstan methods
fit <- read_stan_csv(sam$output_files())
traceplot(fit, pars=c("a", "b"))
pairs(fit, pars=c("a", "b"))

## Model Comparison with LOO-IC (https://arxiv.org/abs/1507.02646)

sm.loo <- cmdstan_model(stan_file="stan-models/linreg_loo.stan")

## Fit the NULL model
data_list <- list(N=N, X=X, Y=Y, Nsim=Nsim, Xsim=Xsim, NullModel=1)
sam.null <- sm.loo$sample(data=data_list)

## Fit the alternative model
data_list <- list(N=N, X=X, Y=Y, Nsim=Nsim, Xsim=Xsim, NullModel=0)
sam.alt <- sm.loo$sample(data=data_list)

## before we can use loo, we must convert cmdstanr into rstan
fit.null <- read_stan_csv(sam.null$output_files())
fit.alt <- read_stan_csv(sam.alt$output_files())

log_lik_null <- extract_log_lik(fit.null, merge_chains=FALSE)
loo.null <- loo(log_lik_null)
print(loo.null)


log_lik_alt <- extract_log_lik(fit.alt, merge_chains=FALSE)
loo.alt <- loo(log_lik_alt)
print(loo.alt)

## Method for more accurate model comparison

comp <- loo_compare(loo.null, loo.alt)
print(comp)

looic = -2 * comp[2,1]
looic_se = 2 * comp[2,2]
sprintf("LOO-IC %f (SE: %f)", looic, looic_se)


## regression models with BRMS (https://paul-buerkner.github.io/brms/)

fit.alt <- brm(formula = Y ~ X + 1, data = data_list, save_model="brms-model.stan")
fit.null <- brm(formula = Y ~ 1, data = data_list)

## BRMS supports
# - hierarchical models
# - non-linear models
# - generalized additive models (i.e. splines)
# - Gaussian process models 

summary(fit.alt)
plot(fit.alt)
comp.brms <- LOO(fit.alt, fit.null)
print(comp.brms)

