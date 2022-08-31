import sys
import numpy as np
from matplotlib import pyplot as plt
sys.path.append("../source")
import data_generation as dg
import estimation
import plots

plt.rcParams.update({"text.color": "white"})
plt.rcParams.update({"axes.labelcolor": "white"})
plt.rcParams.update({"xtick.color": "white"})
plt.rcParams.update({"ytick.color": "white"})

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
ax.plot(local_regression.bandwidths, local_regression.mses, "k")
plots.format_bandwidths_plot(ax)
plots.save_plot("../../plots/min_mse_bandwidths.png")



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
plots.save_plot("../../plots/min_mse_data.png")



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
ax.plot(local_regression.bandwidths, local_regression.loo_cv_mses, "k")
plots.format_bandwidths_plot(ax)
plots.save_plot("../../plots/min_loo_cv_bandwidths.png")



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
plots.save_plot("../../plots/min_loo_cv_data.png")



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
ax.plot(data.x_test, data.mu_test, color="k", label="True regression function $\mu$")
plots.format_plot(ax)
plots.save_plot("../../plots/topologist_sine_curve.png")
