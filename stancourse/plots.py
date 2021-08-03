import numpy as np
import matplotlib.pyplot as plt
from matplotlib import patches
from scipy.stats import gaussian_kde

## colors (rgb)
bl1 = (0, 0, 1)
bl2 = (0.5, 0.5, 1)
bl3 = (0.8, 0.8, 1)

def plot_cov_ellipse(ax, cov, pos, nstd=2, **kwargs):
    def eigsorted(cov):
        vals, vecs = np.linalg.eigh(cov)
        order = vals.argsort()[::-1]
        return vals[order], vecs[:,order]

    vals, vecs = eigsorted(cov)
    theta = np.degrees(np.arctan2(*vecs[:,0][::-1]))

    # Width and height are "full" widths, not radius
    width, height = 2 * nstd * np.sqrt(vals)
    ellip = patches.Ellipse(xy=pos, width=width, height=height, angle=theta, **kwargs)

    ax.add_artist(ellip)
    return ellip


def density(ax, xs, **kwargs):
    ys = np.linspace(np.min(xs), np.max(xs), 1000)
    us = gaussian_kde(xs)(ys)
    ax.fill_between(ys, us, **kwargs)