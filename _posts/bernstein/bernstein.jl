using Distributions
using PyPlot
using Random

Random.seed!(314159)
plt.ioff()

function make_plot(xs::Vector{<:Real}, maxs::Vector{<:Real}, filepath::String)

    d = length(xs)

    fig, ax = plt.subplots(figsize=(6,4))
    fig.patch.set_alpha(0)
    ax.patch.set_alpha(0)
    ax.tick_params(colors="white")

    for loc in ["bottom", "top", "left", "right"]
        ax.spines[loc].set_color("white")
    end

    plt.bar(1:d, xs, color="#54576a",
            label="\$|X_j|\$")
    ax.plot(1:d, maxs, color="#ff5555",
            label="\$\\max_{1 \\leq j \\leq d} |X_d|\$")

    ax.set_yticks(0:1:2)
    ax.legend(framealpha = 0, labelcolor = "#FFFFFF")
    plt.xlabel("Number of variables \$d\$", color = "#FFFFFF", size=12)
    plt.ylabel("Value of variables", color = "#FFFFFF", size=12, labelpad=12)
    PyPlot.savefig(filepath, bbox_inches="tight")
    close("all")
end

function main()

    mu = 0.0
    sigma = 1.0
    d = 100
    xs = Float64[]
    maxs = Float64[]

    while length(unique(maxs)) < 15
        xs = abs.(rand(Normal(mu, sigma), d))
        maxs = accumulate(max, xs)
    end

    make_plot(xs, maxs, "bernstein.pgf")
end

main()
