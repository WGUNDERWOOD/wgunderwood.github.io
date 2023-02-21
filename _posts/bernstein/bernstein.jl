using Distributions
using PyPlot
using Random

Random.seed!(314159)
plt.ioff()

function get_normals_and_maxima(d::Int)

    xs = Float64[]
    maxs = Float64[]

    while length(unique(maxs)) < 13
        xs = abs.(rand(Normal(0, 1), d))
        maxs = accumulate(max, xs)
    end

    return (xs, maxs)
end

function get_expected_max_dist(d::Int, nrep::Int, dist)

    expected_max_rv = 0.0

    for rep in 1:nrep
        rvs = abs.(rand(dist, d))
        max_rv = maximum(rvs)
        expected_max_rv += max_rv / nrep
    end

    return expected_max_rv
end

function make_max_plot(xs::Vector{<:Real}, maxs::Vector{<:Real}, filepath::String)

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
    ax.plot(1:d, maxs, color="#bd93f9",
            label="\$\\max_{1 \\leq j \\leq d} |X_d|\\ \\, \$")

    ax.set_yticks(0:1:2)
    legend = plt.legend(edgecolor="white", labelcolor="white")
    legend.get_frame().set_facecolor((0, 0, 0, 0))
    legend.get_frame().set_alpha(nothing)
    legend.get_frame().set_edgecolor((1, 1, 1, 0.7))

    plt.xlabel("Number of variables, \$d\$", color = "#FFFFFF", size=10)
    plt.ylabel("Value of variables", color = "#FFFFFF", size=10, labelpad=12)
    PyPlot.savefig(filepath, bbox_inches="tight")
    close("all")
end

function make_bounds_plot(ds::Vector{Int}, xs::Vector{Float64},
                          lowers::Vector{Float64},
                          uppers::Vector{Float64}, filepath::String)

    fig, ax = plt.subplots(figsize=(6,4))
    fig.patch.set_alpha(0)
    ax.patch.set_alpha(0)
    ax.tick_params(colors="white")

    for loc in ["bottom", "top", "left", "right"]
        ax.spines[loc].set_color("white")
    end

    ax.plot(ds, lowers, color="#ff5555", label="Lower bound")
    ax.plot(ds, uppers, color="#50fa7b", label="Upper bound")
    ax.plot(ds, xs, color="#bd93f9", label="Simulated")

    ax.set_yticks(0:1:7)
    legend = plt.legend(edgecolor="white", labelcolor="white")
    legend.get_frame().set_facecolor((0, 0, 0, 0))
    legend.get_frame().set_alpha(nothing)
    legend.get_frame().set_edgecolor((1, 1, 1, 0.7))

    #plt.xlabel("Number of variables, \$d\$", color = "#FFFFFF", size=10)
    #plt.ylabel("Value of variables", color = "#FFFFFF", size=10, labelpad=12)
    PyPlot.savefig(filepath, bbox_inches="tight")
    close("all")
end

function main()

    # maximum plot
    d = 100
    (xs, maxs) = get_normals_and_maxima(d)
    make_max_plot(xs, maxs, "bernstein.pgf")


    # normal plot
    nrep = 100
    ds = collect(1:100)
    expected_max_normals = [get_expected_max_dist(d, nrep, Normal(0, 1)) for d in ds]
    lowers_normals = sqrt.(0.5 * log.(ds))
    uppers_normals = sqrt.(2 * log.(2 .* ds)) + log.(2 .* ds) / 3
    make_bounds_plot(ds, expected_max_normals, lowers_normals,
                     uppers_normals, "normal.png")

    # poisson plot
    ds = collect(20:200)
    expected_max_poissons = [get_expected_max_dist(d, nrep, Poisson(1)) for d in ds]
    lowers_poissons = log.(ds) ./ (6 * log.(log.(ds)))
    uppers_poissons = log.(2*ds) / 3 + sqrt.(2 .* log.(2 .* ds))
    make_bounds_plot(ds, expected_max_poissons, lowers_poissons,
                     uppers_poissons, "poisson.png")

end

main()
