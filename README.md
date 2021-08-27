# Stan for Immunobiology and Infection

This repository contains an introduction to programming with Stan for immunobiology / viral dynamics / epidemiology modelers.
The contents of this repository can be downloaded using the green "code" button in the upper right corner (select "download zip"). Make sure that you get the latest version, because there will be regular updates. Alternatively, you can use git to "clone" the repository (see instructions [below](#using-git)).

The material for the webinar can be found in the `notebooks` directory of the repository in the form of Jupyter notebooks (with file extension `.ipynb`). To use these notebooks you will have to install Jupyter. The Stan models can be found in the `stan-models` directory, and to use these, we will have to install Stan. 

## Installing Jupyter

Instructions on how to install the Jupyter notebook can be found [here](https://jupyter.org/install).
You can choose between the simpler "classic" jupyter notebook or jupyter-lab, which has a fancier interface.
These instructions assume that you already have Python 3 installed on your system. If that is not the
case, the easiest way is to [install anaconda](https://www.anaconda.com/products/individual). 
The Anaconda installer (using all default options) automatically installs the Jupyter notebook and creates a link in the Windows start menu.
The notebook can also be "launched" from the Anaconda navigator.

## Installing Stan

Stan comes as a stand-alone application (cmdstan), but a number of interfaces exist that allow easy Stan access from your favorite scientific programming environment (R, Python, Julia, Matlab, etc.). In this workshop, we will mainly use Python (through the Jupyter notebook) and the `cmdstanpy` package to interface with Stan. A similar package (cmdstanr) exists for R.

To install Stan, you can use the notebook `InstallTest.ipynb` in the `notebooks` directory of this repository. This notebook walks you through the process depending on your OS. This notebook may not work in some cases, depending on the details of your system.

Detailed instructions on how to install Stan can be found on the [Stan website](www.mc-stan.org). Instructions on how to install cmdstanpy can be found [here](https://cmdstanpy.readthedocs.io/en/latest/getting_started.html). The main steps are as follows:

1. First, install the python package `cmdstanpy`. Either with `pip` or `conda`. For instance with Anaconda on Windows, open the Anaconda Prompt (from the Windows start menu) or the powershell (from Anaconda Navigator) and enter the command
```bash
conda install -c conda-forge cmdstanpy
```
2. When you initiate a Stan model, the Stan script as translated into C++ source code by the `stanc` compiler. The C++ code is then compiled into an executable. This means that Stan needs a C++ compiler. On linux this is installed by default, but on Mac or Windows this may require some extra steps.
For Windows users, `cmdstanpy` provides the script `install_cxx_toolchain` which should do the work for you.
In the terminal (i.e Anaconda Prompt, powershell, etc) enter the command
```
python -m cmdstanpy.install_cxx_toolchain
```
3. The cmdstanpy package has a convenient function called `install_cmdstan()` which will download and install the `cmdstan` application for you automatically.
In the terminal, type
```bash
python
```
Which will start the Python interpreter. Then, enter the following commands
```py
import cmdstanpy
cmdstanpy.utils.cxx_toolchain_path()
cmdstanpy.install_cmdstan()
```
This may take some time, but you only have to do this once.

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
The other Python interface to Stan is called `pystan`, which you may find more convenient and can be installed with `pip install pystan`.

If you use Anaconda, chances are that these packages are already installed. In case you see an error like `ModuleNotFoundError: No module named pygments`, enter the following command in the terminal:
```bash
conda install numpy scipy matplotlib datetime pygments
```
Now you're all set for the webinar.

## Slides

The notebooks can be converted into [reveal.js](https://revealjs.com/) slides. In the Jupyter notebook, choose "file -> download as -> reveal.js". Make sure to first run all cells.

## Instructions for R users

The R-equivalent for `cmdstanpy` is `cmdstanr`. Instructions on how to install this R package can be found [here](https://mc-stan.org/cmdstanr/).
It is also useful to install the `rstan` interface. See the instructions [here](https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started).

## Using git

Another way is to use `git`. From the terminal, type
```bash
git clone https://github.com/chvandorp/stan-immbio.git
```
This will create a directory `stan-immbio` containing the content of the repository. To get the latest updates, enter the following commands (**WARNING the first line will delete any changes that you made**)
```bash
git reset --hard
git pull origin main
```

----------------------------------------------------------------------------------------------

FCI Open Source Copyright Assertion: C21064

(c) 2021. Triad National Security, LLC. All rights reserved. This program was produced under U.S. Government contract 89233218CNA000001 for Los Alamos National Laboratory (LANL), which is operated by Triad National Security, LLC for the U.S. Department of Energy/National Nuclear Security Administration. All rights in the program are reserved by Triad National Security, LLC, and the U.S. Department of Energy/National Nuclear Security Administration. The Government is granted for itself and others acting on its behalf a nonexclusive, paid-up, irrevocable worldwide license in this material to reproduce, prepare derivative works, distribute copies to the public, perform publicly and display publicly, and to permit others to do so.
