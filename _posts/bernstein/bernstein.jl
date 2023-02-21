using Distributions
using PyPlot
using Random

Random.seed!(314159)

rcParams = PyPlot.PyDict(PyPlot.matplotlib."rcParams")
rcParams["pgf.preamble"]  = "\\usepackage{amsfonts}"
plt.ioff()

function get_expected_max_abs_sum_two_value(n::Int, d::Int, nrep::Int,
                                            xs::Vector{Float64}, ps::Vector{Float64})

    expected_max_rv = 0.0
    dist = DiscreteNonParametric(xs, ps)

    for rep in 1:nrep
        max_rv = 0.0
        for j in 1:d
            rv = abs.(sum(rand(dist, n)))
            max_rv = max(max_rv, rv)
        end
        expected_max_rv += max_rv / nrep
    end

    return expected_max_rv
end

function get_normals_and_maxima(d::Int)

    xs = Float64[]
    maxs = Float64[]

    while length(unique(maxs)) < 13
        xs = abs.(rand(Normal(0, 1), d))
        maxs = accumulate(max, xs)
    end

    return (xs, maxs)
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
                          uppers::Vector{Float64}, x_label::String,
                          upper_label::String, yticks,
                          filepath::String)

    fig, ax = plt.subplots(figsize=(6,4))
    fig.patch.set_alpha(0)
    ax.patch.set_alpha(0)
    ax.tick_params(colors="white")

    for loc in ["bottom", "top", "left", "right"]
        ax.spines[loc].set_color("white")
    end

    ax.plot(ds, uppers, color="#50fa7b", label=upper_label)
    ax.plot(ds, xs, color="#bd93f9", label=x_label)

    ax.set_yticks(yticks)
    legend = plt.legend(edgecolor="white", labelcolor="white", loc="upper left")
    legend.get_frame().set_facecolor((0, 0, 0, 0))
    legend.get_frame().set_alpha(nothing)
    legend.get_frame().set_edgecolor((1, 1, 1, 0.7))

    plt.xlabel("Number of variables, \$d\$", color = "#FFFFFF", size=10)
    plt.ylabel("Value of variables", color = "#FFFFFF", size=10, labelpad=12)
    PyPlot.savefig(filepath, bbox_inches="tight")
    close("all")
end

function main()

    # maximum plot
    d = 100
    (xs, maxs) = get_normals_and_maxima(d)
    make_max_plot(xs, maxs, "maximum.pgf")

    # normal plot
    nrep = 1000
    n = 50
    ds = collect(1:100)
    xs = [-1.0, 1.0]
    ps = [0.5, 0.5]

    expected_max = [get_expected_max_abs_sum_two_value(n, d, nrep, xs, ps) for d in ds]
    uppers = sqrt.(2 * n * log.(2 .* ds)) + log.(2 .* ds) / 3
    make_bounds_plot(
        ds, expected_max, uppers,
        "Simulated",
        "Bernstein's upper bound",
        0:5:30,
        "normal.pgf")

    # poisson plot
    nrep = 1000
    n = 50
    ds = collect(1:100)
    xs = [1 - 1/n, -1/n]
    ps = [1/n, 1 - 1/n]

    expected_max = [get_expected_max_abs_sum_two_value(n, d, nrep, xs, ps) for d in ds]
    uppers = sqrt.(2 * log.(2 .* ds)) + log.(2 .* ds) / 3
    make_bounds_plot(
        ds, expected_max, uppers,
        "Simulated",
        "Bernstein's upper bound",
        0:1:6,
        "poisson.pgf")

end

main()
