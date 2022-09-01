import numpy as np
import pandas as pd
from matplotlib import pyplot as plt
import sys
import data_generation as dg
import estimation as es
import plots
import imageio
import os

plt.rcParams["text.color"] = "white"
plt.rcParams["axes.labelcolor"] = "white"
plt.rcParams["xtick.color"] = "white"
plt.rcParams["ytick.color"] = "white"


# get data
# ---------------------------------------

global_warming = pd.read_csv("nasa.csv")
year = global_warming["year"]
temp = global_warming["temp"]
n_train = len(global_warming)
print(f"{n_train} samples")

data = dg.Data(n_train, n_test=0)
data.x_train = np.array(year)
data.y_train = np.array(temp)

data.x_test = np.arange(year[0], year[n_train-1], step=0.2)
data.y_test = data.x_test

data.mu_train = data.y_train
data.eps_train = data.y_train


# estimator, range of bandwidths
# ---------------------------------------
# TODO num=30
bandwidths = np.logspace(np.log10(1), np.log10(50), num=3)

for b in range(len(bandwidths)):
    print(f"{b} / {len(bandwidths) - 1}")
    bandwidth = bandwidths[b]
    lr = es.LocalRegression(kernel="epanechnikov", bandwidth=bandwidth,
                            degree=1, verbose=True)
    lr.fit(data)

    fig, ax = plt.subplots(figsize=(6,4))
    ax.scatter(data.x_train, data.y_train, 5,
               color="mediumpurple", label="Data $(x_i, y_i)$")
    ax.plot(data.x_test, lr.fitted_test, color="orangered",
            label="Estimated regression function $\widehat \mu$")
    ax.set_xlabel("Year")
    ax.set_ylabel("Temperature Anomaly / °C")
    formatted_bandwidth = "{0:.2f}".format(bandwidth)
    ax.annotate(f"Bandwidth = {formatted_bandwidth}", (1977, -0.45))
    legend = plt.legend(edgecolor="white")
    legend.get_frame().set_facecolor((0, 0, 0, 0))
    legend.get_frame().set_alpha(None)
    legend.get_frame().set_edgecolor((1, 1, 1, 0.7))
    ax.spines["bottom"].set_color("white")
    ax.spines["top"].set_color("white")
    ax.spines["left"].set_color("white")
    ax.spines["right"].set_color("white")
    plt.tight_layout()
    plt.savefig(f"global_warming_bandwidth{b}.png", dpi=600,
                transparent=True, bbox_inches="tight")
    plt.close()


# build gif
# ---------------------------------------
fps = 3
with imageio.get_writer(f"global_warming_large.gif", mode="I", fps=fps) as writer:
    for b in range(len(bandwidths)):
        filename = f"global_warming_bandwidth{b}.png"
        print(filename)
        image = imageio.v3.imread(filename)
        writer.append_data(image)
        os.remove(filename)



# estimator, loo-cv
# ---------------------------------------
bandwidth = 3
# TODO num = 20
num_bandwidths = 2
search_orders = 1

lr = es.LocalRegression(kernel="epanechnikov", bandwidth=bandwidth,
                        degree=1, verbose=True)
lr.fit_loo_cv(data, num_bandwidths, search_orders)

fig, ax = plt.subplots(figsize=(6,4))
ax.scatter(data.x_train, data.y_train, 5,
           color="mediumpurple", label="Data $(x_i, y_i)$")
ax.plot(data.x_test, lr.fitted_test, color="orangered",
        label="Estimated regression function $\widehat \mu$")
ax.set_xlabel("Year")
ax.set_ylabel("Temperature Anomaly / °C")
formatted_bandwidth = "{0:.2f}".format(lr.bandwidth)
ax.annotate(f"LOO-CV bandwidth = {formatted_bandwidth}", (1960, -0.45))
legend = plt.legend(edgecolor="white")
legend.get_frame().set_facecolor((0, 0, 0, 0))
legend.get_frame().set_alpha(None)
legend.get_frame().set_edgecolor((1, 1, 1, 0.7))
ax.spines["bottom"].set_color("white")
ax.spines["top"].set_color("white")
ax.spines["left"].set_color("white")
ax.spines["right"].set_color("white")
plots.save_plot(f"global_warming_loocv.pgf")
plt.close()
