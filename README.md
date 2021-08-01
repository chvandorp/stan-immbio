# Stan for Immunobiology and Infection

This repository contains an introduction to programming with Stan for immunobiology / viral dynamics / epidemiology modelers.

## Installing Jupyter

Instructions on how to install the Jupyter notebook can be found [here](https://jupyter.org/install).
You can choose between the simpler "classic" jupyter notebook or jupyter-lab, which has a fancier interface.
These instructions assume that you already have Python 3 installed on your system. If that is not the
case, the easiest way is to [install anaconda](https://www.anaconda.com/products/individual). On Windows,
the Anaconda installer (using all default options) automatically installs the Jupyter notebook and creates a link in the start menu. 
The notebook can also be "launched" from the Anaconda navigator.

## Installing Stan

Detailed instructions on how to install Stan can be found on the [Stan website](www.mc-stan.org). Stan comes as a stand-alone application (cmdstan), but there are a number of interfaces that allows easy Stan access from your favourite scientific programming environment (R, Python, Julia, Matlab, etc.). In this workshop, we will mainly use Python (through the Jupyter notebook, see below) and the `cmdstanpy` package to interface with Stan. A similar package (cmdstanr) exists for R. Instructions on how to install cmdstanpy can be found [here](https://cmdstanpy.readthedocs.io/en/latest/getting_started.html).

Intallation steps are also given in the notebook `InstallTest.ipynb` in the `notebooks` directory.

The cmdstanpy has a convenient function called `install_cmdstan()` which will download and install the `cmdstan` application for you automatically.
```py
## python shell / jupyter notebook
import cmdstanpy
cmdstanpy.install_cmdstan() ## takes some time...
```
You only have to do this once.

When you initiate a Stan model, the Stan script as translated into C++ source code by the `stanc` compiler. The C++ code is then compiled into an executable. This means that Stan needs a C++ compiler. On linux this is installed by default, but on Mac or Windows this may require some extra steps.
For Windows users, `cmdstanpy` provises the script `install_cxx_toolchain` which should do the work for you. This can be a bit tricky, so you might want to use the `InstallTest.ipynb` notebook

Mac users can install `xcode` which provides a C++ compiler. To install `xcode`, open a terminal and type
```bash
xcode-select --install
```

## Other Python modules

In addition to the `cmdstanpy` module, the notebooks import a number of other modules that you might have to install as well:

* numpy
* scipy
* matplotlib
* datetime
* pygments

Using `pip`, you can install these using the shell command
```bash
pip install numpy scipy matplotlib datetime pygments
```
The other Python interface to stan is called `pystan`, which you may find more convenient. It's definately worth a try and can be installed with `pip install pystan`.

## Instructions for R users

The R-equivalent for `cmdstanpy` is `cmdstanr`. Instructions on how to install this R package can be found [here](https://mc-stan.org/cmdstanr/).
It might also be useful to install the `rstan` interface. See the instructions [here](https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started).

## Using git

The contents of this repository can be downloaded using the green "code" button in the upper right corner (select "download zip"). Make sure that you get the latest version, because there will be regular updates. Another way is to use `git`. From the terminal, type
```bash
git clone https://github.com/chvandorp/stan-immbio.git
```
This will create a directory `stan-immbio` containing the content of the repository. To get the latest updates, enter the following commands (**WARNING the first line will delete any changes that you made**)
```bash
git reset --hard
git pull origin main
```
