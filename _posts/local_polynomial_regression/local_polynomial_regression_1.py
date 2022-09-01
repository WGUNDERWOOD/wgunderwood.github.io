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


plt.rcParams["text.usetex"] = True
plt.rc('text.latex', preamble=r'\usepackage[sfdefault, light]{inter}')


plt.rcParams["font.family"]  = "sans-serif"
plt.rcParams["mathtext.default"] = "regular"
#plt.rcParams["font.sans-serif"]  = "Inter"
#plt.rcParams["axes.labelweight"] = "light"
#plt.rcParams["font.weight"] = "light"
#plt.rcParams["mathtext.fontset"]  = "regular";

# data plot
# ---------------------------------------

np.random.seed(5)

n_train = 100
n_test = 1000
sigma = 0.3

data = dg.Data(n_train, n_test)
data.generate_x_uniform_random(0, 3)

coeffs = [0.5, 2, 0.15, -1.25, 0, 4/15, 0, -8/315, -0.0002, 4/3825]
data.generate_mu_polynomial(coeffs)
data.generate_y_gaussian(sigma)

fig, ax = plt.subplots(figsize=(6,4))
plots.plot_mu(ax, data)
plots.plot_data(ax, data)
plots.format_plot(ax)
plots.save_plot("data.pgf")

exit()

# linear fit linear data
# ---------------------------------------

np.random.seed(1)

n_train = 100
n_test = 1000
sigma = 0.3

data = dg.Data(n_train, n_test)
data.generate_x_uniform_random(0, 3)

coeffs = [0, 1]
data.generate_mu_polynomial(coeffs)
data.generate_y_gaussian(sigma)

degree = 1
polynomial_regression = es.PolynomialRegression(degree=degree)
polynomial_regression.fit(data)

fig, ax = plt.subplots(figsize=(6,4))
plots.plot_data(ax, data)
plots.plot_mu(ax, data)
plots.plot_muhat(ax, data, polynomial_regression)
plots.format_plot(ax)
plots.save_plot("linear_fit_linear_data.png")



# linear fit quadratic data
# ---------------------------------------

np.random.seed(1)

n_train = 100
n_test = 1000
sigma = 0.3

data = dg.Data(n_train, n_test)
data.generate_x_uniform_random(0, 3)

coeffs = [2.25, -3, 1]
data.generate_mu_polynomial(coeffs)
data.generate_y_gaussian(sigma)

degree = 1
polynomial_regression = es.PolynomialRegression(degree=degree)
polynomial_regression.fit(data)

fig, ax = plt.subplots(figsize=(6,4))
plots.plot_data(ax, data)
plots.plot_mu(ax, data)
plots.plot_muhat(ax, data, polynomial_regression)
plots.format_plot(ax)
plots.save_plot("linear_fit_quadratic_data.png")



# quadratic fit quadratic data
# ---------------------------------------

np.random.seed(1)

n_train = 100
n_test = 1000
sigma = 0.3

data = dg.Data(n_train, n_test)
data.generate_x_uniform_random(0, 3)

coeffs = [2.25, -3, 1]
data.generate_mu_polynomial(coeffs)
data.generate_y_gaussian(sigma)

degree = 2
polynomial_regression = es.PolynomialRegression(degree=degree)
polynomial_regression.fit(data)

fig, ax = plt.subplots(figsize=(6,4))
plots.plot_data(ax, data)
plots.plot_mu(ax, data)
plots.plot_muhat(ax, data, polynomial_regression)
plots.format_plot(ax)
plots.save_plot("quadratic_fit_quadratic_data.png")



# quadratic fit general data
# ---------------------------------------

np.random.seed(5)

n_train = 100
n_test = 1000
sigma = 0.3

data = dg.Data(n_train, n_test)
data.generate_x_uniform_random(0, 3)

coeffs = [0.5, 2, 0.15, -1.25, 0, 4/15, 0, -8/315, -0.0002, 4/3825]
data.generate_mu_polynomial(coeffs)
data.generate_y_gaussian(sigma)

degree = 2
polynomial_regression = es.PolynomialRegression(degree=degree)
polynomial_regression.fit(data)

fig, ax = plt.subplots(figsize=(6,4))
plots.plot_data(ax, data)
plots.plot_mu(ax, data)
plots.plot_muhat(ax, data, polynomial_regression)
plots.format_plot(ax)
plots.save_plot("quadratic_fit_general_data.png")



# polynomial fit general data
# ---------------------------------------

np.random.seed(27)

n_train = 100
n_test = 1000
sigma = 0.3

data = dg.Data(n_train, n_test)
data.generate_x_uniform_random(0, 3)

coeffs = [0.5, 2, 0.15, -1.25, 0, 4/15, 0, -8/315, -0.0002, 4/3825]
data.generate_mu_polynomial(coeffs)
data.generate_y_gaussian(sigma)

degree = 50
polynomial_regression = es.PolynomialRegression(degree=degree)
polynomial_regression.fit(data)

max_rank = max([i for i in range(n_test) if data.x_test[i] <= max(data.x_train)])
data.x_test = data.x_test[0:max_rank]
data.mu_test = data.mu_test[0:max_rank]
polynomial_regression.fitted_test = polynomial_regression.fitted_test[0:max_rank]

fig, ax = plt.subplots(figsize=(6,4))
plots.plot_data(ax, data)
plots.plot_mu(ax, data)
plots.plot_muhat(ax, data, polynomial_regression)
plots.format_plot(ax)
plots.save_plot("polynomial_fit_general_data.png")



# kernels
# ---------------------------------------

xs = np.arange(-2, 2, 0.1)
ys_uniform = 0.5 * np.array(abs(xs) <= 1)
ys_epanechnikov = np.array(abs(xs) <= 1) * (3/4) * (1-xs**2)
ys_gaussian = 1/np.sqrt(2 * np.pi) * np.exp(-xs**2/2)

title_offset = -0.3
fig, (ax1, ax2, ax3) = plt.subplots(ncols=3, figsize=(6,2))
ax1.plot(xs, ys_uniform, color="gray")
ax2.plot(xs, ys_epanechnikov, color="gray")
ax3.plot(xs, ys_gaussian, color="gray")

ax1.set_title("Uniform", y=title_offset)
ax2.set_title("Epanechnikov", y=title_offset)
ax3.set_title("Gaussian", y=title_offset)

for ax in [ax1, ax2, ax3]:
    ax.tick_params(axis="both", which="both", bottom=False,
                   left=False, labelleft=False, labelbottom=False)

plt.tight_layout()
plt.savefig("kernels.png", dpi=200, bbox_inches="tight")



# nadaraya fit general data
# ---------------------------------------

np.random.seed(5)

n_train = 100
n_test = 1000
sigma = 0.3

data = dg.Data(n_train, n_test)
data.generate_x_uniform_random(0, 3)

coeffs = [0.5, 2, 0.15, -1.25, 0, 4/15, 0, -8/315, -0.0002, 4/3825]
data.generate_mu_polynomial(coeffs)
data.generate_y_gaussian(sigma)

degree = 0
local_regression = es.LocalRegression(kernel="epanechnikov",
                                      bandwidth=0.5, degree=degree)
local_regression.fit(data)

fig, ax = plt.subplots(figsize=(6,4))
plots.plot_data(ax, data)
plots.plot_mu(ax, data)
plots.plot_muhat(ax, data, local_regression)
plots.format_plot(ax)
plots.save_plot("nadaraya_fit_general_data.png")
