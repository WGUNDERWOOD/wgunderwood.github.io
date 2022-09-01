import numpy as np
from matplotlib import pyplot as plt
import sys
import data_generation as dg
import estimation as es
import plots

plt.rcParams["text.color"] = "white"
plt.rcParams["axes.labelcolor"] = "white"
plt.rcParams["xtick.color"] = "white"
plt.rcParams["ytick.color"] = "white"

# boundary bias
# ---------------------------------------

np.random.seed(5)

n_train = 200
n_test = 1000
sigma = 0.2

data = dg.Data(n_train, n_test)
data.generate_x_uniform_random(0, 3)

coeffs = [3, -2, 0.5]
data.generate_mu_polynomial(coeffs)
data.generate_y_gaussian(sigma)

degree = 0
local_regression = es.LocalRegression(kernel="epanechnikov",
                                      bandwidth=0.8, degree=degree)
local_regression.fit(data)

fig, ax = plt.subplots(figsize=(6,4))
plots.plot_data(ax, data)
plots.plot_mu(ax, data)
plots.plot_muhat(ax, data, local_regression)
plots.format_plot(ax)
plots.save_plot("boundary_bias.pgf")



# boundary bias fixed
# ---------------------------------------

np.random.seed(5)

n_train = 200
n_test = 1000
sigma = 0.2

data = dg.Data(n_train, n_test)
data.generate_x_uniform_random(0, 3)

coeffs = [3, -2, 0.5]
data.generate_mu_polynomial(coeffs)
data.generate_y_gaussian(sigma)

degree = 1
local_regression = es.LocalRegression(kernel="epanechnikov",
                                      bandwidth=0.8, degree=degree)
local_regression.fit(data)


fig, ax = plt.subplots(figsize=(6,4))
plots.plot_data(ax, data)
plots.plot_mu(ax, data)
plots.plot_muhat(ax, data, local_regression)
plots.format_plot(ax)
plots.save_plot("boundary_bias_fixed.pgf")



# second order bias fixed
# ---------------------------------------

np.random.seed(5)

n_train = 200
n_test = 1000
sigma = 0.2

data = dg.Data(n_train, n_test)
data.generate_x_uniform_random(0, 3)

coeffs = [3, -2, 0.5]
data.generate_mu_polynomial(coeffs)
data.generate_y_gaussian(sigma)

degree = 2
local_regression = es.LocalRegression(kernel="epanechnikov",
                                      bandwidth=0.8, degree=degree)
local_regression.fit(data)

fig, ax = plt.subplots(figsize=(6,4))
plots.plot_data(ax, data)
plots.plot_mu(ax, data)
plots.plot_muhat(ax, data, local_regression)
plots.format_plot(ax)
plots.save_plot("second_order_bias_fixed.pgf")
