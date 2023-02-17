using Distributions

using PyPlot
using Random

Random.seed!(314159)
rcParams = PyPlot.PyDict(PyPlot.matplotlib."rcParams")
rcParams["font.family"]  = "sans-serif"
rcParams["font.sans-serif"]  = "Inter"
plt.rcParams["axes.labelweight"] = "light"
plt.rcParams["font.weight"] = "light"
plt.ioff()

function make_plot(xs::Vector{<:Real}, maxs::Vector{<:Real}, filepath::String)

    n = length(xs)

    fig, ax = plt.subplots(figsize=(6,4))
    fig.patch.set_alpha(0)
    ax.patch.set_alpha(0)
    ax.tick_params(colors="white")

    for loc in ["bottom", "top", "left", "right"]
        ax.spines[loc].set_color("white")
    end

    plt.bar(1:n, xs, color="#777777",
            label="\$X_j\$")
    ax.plot(1:n, maxs, color="#FFB86C",
            label="\$\\max_{1 \\leq r \\leq j} X_r\$")

    ax.set_yticks(0:5:20)
    ax.legend(framealpha = 0, labelcolor = "#FFFFFF")
    plt.xlabel("Number of variables", color = "#FFFFFF", size=12)
    plt.ylabel("Maximum of variables", color = "#FFFFFF", size=12)
    PyPlot.savefig(filepath, dpi=200, bbox_inches="tight")
    close("all")
end

function main()

    mu = 12.0
    sigma = 4.0
    d = 100
    xs = Float64[]
    maxs = Float64[]

    while length(unique(maxs)) < 15
        xs = rand(Normal(mu, sigma), d)
        maxs = accumulate(max, xs)
    end

    make_plot(xs[1:d], maxs[1:d], "../../assets/posts/bernstein/plot.png")
end

main()
