from matplotlib import pyplot as plt

def format_plot(ax):


    ax.spines["bottom"].set_color("white")
    ax.spines["top"].set_color("white")
    ax.spines["left"].set_color("white")
    ax.spines["right"].set_color("white")
    ax.set_xticks(range(4))
    ax.set_yticks(range(4))
    ax.set_xlabel("$x$", color="white", size=14)
    ax.set_ylabel("$y$", color="white", size=14)

    ticks, labels = plt.xticks()
    plt.xticks(ticks, labels = [str(l) for l in ticks], size=10)
    ticks, labels = plt.yticks()
    plt.yticks(ticks, labels = [str(l) for l in ticks], size=10)

    legend = plt.legend(edgecolor="white")
    legend.get_frame().set_facecolor((0, 0, 0, 0))
    legend.get_frame().set_alpha(None)
    legend.get_frame().set_edgecolor((1, 1, 1, 0.7))


def format_bandwidths_plot(ax):

    ax.spines["bottom"].set_color("white")
    ax.spines["top"].set_color("white")
    ax.spines["left"].set_color("white")
    ax.spines["right"].set_color("white")

    plt.xticks(size=10)
    plt.yticks(size=10)

    ax.set_xlabel("Bandwidth $h$", color="white", size=14)


def plot_data(ax, data):

    ax.scatter(
        data.x_train,
        data.y_train,
        10,
        "#cda3ff",
        zorder=100,
        label="Data $(x_i, y_i)$")


def plot_mu(ax, data):

    ax.plot(
        data.x_test,
        data.mu_test,
        color="#50ea7b",
        zorder=70,
        label="True regression function $\mu$")


def plot_muhat(ax, data, estimator):

    ax.plot(
        data.x_test,
        estimator.fitted_test,
        color="#ff5555",
        zorder=110,
        label="Estimated regression function $\widehat \mu$")


def save_plot(filename):

    plt.tight_layout()
    plt.savefig(filename, transparent=True, format="pgf",
                bbox_inches="tight")
