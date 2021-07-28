# Stan for Immunobiology and Infection

This repository contains an introduction to programming with Stan for immunobiology / viral dynamics / epidemiology modelers.

## Installing Jupyter

Instructions on how to install the Jupyter notebook can be found [here](https://jupyter.org/install).
These instructions assume that you already have Python 3 installed on your system. If that is not the
case, the easiest way is to [install anaconda](https://www.anaconda.com/products/individual).

## Installing Stan

Detailed instructions on how to install Stan can be found on the [Stan website](www.mc-stan.org). Stan comes as a stand-alone application (cmdstan), but there are a number of interfaces that allows easy Stan access from your favourite scientific programming environment (R, Python, Julia, Matlab, etc.). In this workshop, we will mainly use Python (through the Jupyter notebook, see below) and the cmdstanpy package to interface with Stan. A similar package (cmdstanr) exists for R. Instructions on how to install cmdstanpy can be found [here](https://cmdstanpy.readthedocs.io/en/latest/getting_started.html).

The cmdstanpy has a convenient function called `install_cmdstan()` which will download and install the `cmdstan` application for you automatically.
```py
## python shell / jupyter notebook
import cmdstanpy
cmdstanpy.install_cmdstan() ## takes some time...
```
You only have to do this once.

When you initiate a Stan model, the Stan script as translated into C++ source code by the `stanc` compiler. The C++ code is then compiled into an executable. This means that Stan needs a C++ compiler. On linux this is installed by default, but on Mac or Windows this may require some extra steps.
For Windows users, `cmdstanpy` provises the function `install_cxx_toolchain()` which should do the work for you.

Mac users should be able to install xcode by opening a terminal and typing
```bash
xcode-select --install
```


## Instructions for R users

The R-equivalent for `cmdstanpy` is `cmdstanr`. Instructions on how to install this R package can be found [here](https://mc-stan.org/cmdstanr/).
It might also be useful to install the `rstan` interface. See the instructions [here](https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started).
