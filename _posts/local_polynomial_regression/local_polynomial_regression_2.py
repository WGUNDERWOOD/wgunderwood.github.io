import sys
import numpy as np
from matplotlib import pyplot as plt
import data_generation as dg
import estimation
import plots

plt.rcParams["text.color"] = "white"
plt.rcParams["axes.labelcolor"] = "white"
plt.rcParams["xtick.color"] = "white"
plt.rcParams["ytick.color"] = "white"

# min mse bandwidths
# ---------------------------------------

np.random.seed(4)
n_train = 100
n_test = 1000
sigma = 0.3
data = dg.Data(n_train, n_test)
data.generate_x_uniform_random(0, 3)
coeffs = [0.5, 2, 0.15, -1.25, 0, 4/15, 0, -8/315, -0.0002, 4/3825]
data.generate_mu_polynomial(coeffs)
data.generate_y_gaussian(sigma)

local_regression = estimation.LocalRegression(
    kernel="epanechnikov", bandwidth=0.1, degree=0, verbose=True)
local_regression.fit_mse(data,
    num_bandwidths=100, search_orders=3)

fig, ax = plt.subplots(figsize=(6,4))
ax.plot(local_regression.bandwidths, local_regression.mses, "#8be9fd")
plots.format_bandwidths_plot(ax)
ax.set_ylabel("Empirical IMSE", color="white", size=14)
ax.yaxis.labelpad = 10
plots.save_plot("min_mse_bandwidths.pgf")



# min mse data
# ---------------------------------------

np.random.seed(4)
n_train = 100
n_test = 30000
sigma = 0.3
data = dg.Data(n_train, n_test)
data.generate_x_uniform_random(0, 3)
coeffs = [0.5, 2, 0.15, -1.25, 0, 4/15, 0, -8/315, -0.0002, 4/3825]
data.generate_mu_polynomial(coeffs)
data.generate_y_gaussian(sigma)

bandwidth = min(abs(np.diff(data.x_train)))
local_regression = estimation.LocalRegression(
    kernel="epanechnikov", bandwidth=bandwidth, degree=0, verbose=True)
local_regression.fit(data)

fig, ax = plt.subplots(figsize=(6,4))
plots.plot_data(ax, data)
plots.plot_mu(ax, data)
plots.plot_muhat(ax, data, local_regression)
plots.format_plot(ax)
ax.set_ylim((0,3.2))
plots.save_plot("min_mse_data.pgf")



# min loo cv bandwidths
# ---------------------------------------

np.random.seed(4)
n_train = 100
n_test = 1000
sigma = 0.3
data = dg.Data(n_train, n_test)
data.generate_x_uniform_random(0, 3)
coeffs = [0.5, 2, 0.15, -1.25, 0, 4/15, 0, -8/315, -0.0002, 4/3825]
data.generate_mu_polynomial(coeffs)
data.generate_y_gaussian(sigma)

local_regression = estimation.LocalRegression(
    kernel="epanechnikov", bandwidth=1.0, degree=0, verbose=True)
local_regression.fit_loo_cv(data,
    num_bandwidths=100, search_orders=1.5)

fig, ax = plt.subplots(figsize=(6,4))
ax.plot(local_regression.bandwidths, local_regression.loo_cv_mses, "#8be9fd")
ax.set_ylabel("LOO-CV", color="white", size=14)
plots.format_bandwidths_plot(ax)
ax.yaxis.labelpad = 10
plots.save_plot("min_loo_cv_bandwidths.pgf")



# min loo cv data
# ---------------------------------------

np.random.seed(4)
n_train = 100
n_test = 30000
sigma = 0.3
data = dg.Data(n_train, n_test)
data.generate_x_uniform_random(0, 3)
coeffs = [0.5, 2, 0.15, -1.25, 0, 4/15, 0, -8/315, -0.0002, 4/3825]
data.generate_mu_polynomial(coeffs)
data.generate_y_gaussian(sigma)

local_regression = estimation.LocalRegression(
    kernel="epanechnikov", bandwidth=0.3, degree=0, verbose=True)
local_regression.fit_loo_cv(data, num_bandwidths=30, search_orders=0.5)
print("Best bandwidth:", local_regression.bandwidth)

fig, ax = plt.subplots(figsize=(6,4))
plots.plot_data(ax, data)
plots.plot_mu(ax, data)
plots.plot_muhat(ax, data, local_regression)
plots.format_plot(ax)
ax.set_ylim((0,3.2))
plots.save_plot("min_loo_cv_data.pgf")



# topologist sine curve
# ---------------------------------------

np.random.seed(5)

n_train = 300
n_test = 1000
sigma = 0.1

data = dg.Data(n_train, n_test)
data.generate_x_uniform_random(0, 3)

data.generate_mu_topologist_sine_curve()
data.generate_y_gaussian(sigma)

fig, ax = plt.subplots(figsize=(6,4))
ax.scatter(data.x_train, data.y_train, 10, color="mediumpurple", label="Data $(x_i, y_i)$")
ax.plot(data.x_test, data.mu_test, color="#50ea7b",
        label="True regression function $\mu$")
ax.spines["bottom"].set_color("white")
ax.spines["top"].set_color("white")
ax.spines["left"].set_color("white")
ax.spines["right"].set_color("white")
ax.set_xlabel("$x$", color="white", size=14)
ax.set_ylabel("$y$", color="white", size=14)
plt.xticks([0, 1, 2, 3], size=10)
plt.yticks([0, 1, 2], size=10)
legend = plt.legend(edgecolor="white")
legend.get_frame().set_facecolor((0, 0, 0, 0))
legend.get_frame().set_alpha(None)
legend.get_frame().set_edgecolor((1, 1, 1, 0.7))
plots.save_plot("topologist_sine_curve.pgf")
