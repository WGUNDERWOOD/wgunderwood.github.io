using Distributions
using PyPlot
using Random

Random.seed!(314159)
plt.ioff()

function get_expected_max_dist(d::Int, nrep::Int, dist)

    expected_max_normal = 0.0

    for rep in 1:n_rep
        normals = abs.(rand(dist, d))
        max_normal = maximum(normals)
        expected_max_normal += max_normal / n_rep
    end

    return expected_max_normal
end

function make_plot(xs::Vector{Float64}, lowers::Vector{Float64},
                   uppers::Vector{Float64}, filepath::String)

    nds = length(xs)

    fig, ax = plt.subplots(figsize=(6,4))
    fig.patch.set_alpha(0)
    ax.patch.set_alpha(0)
    ax.tick_params(colors="white")

    for loc in ["bottom", "top", "left", "right"]
        ax.spines[loc].set_color("white")
    end

    ax.plot(1:nds, lowers, color="#ff5555", label="lowers")
    ax.plot(1:nds, uppers, color="#50fa7b", label="uppers")
    ax.plot(1:nds, xs, color="#bd93f9", label="")

    #ax.set_yticks(0:1:2)
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

    ds = 1:50000:100000
    nrep = 1000

    expected_max_normals = [get_expected_max_dist(d, nrep, Normal(0, 1)) for d in ds]
    lowers_normals = sqrt.(0.5 * log.(ds))
    uppers_normals = sqrt.(2 * log.(2 .* ds)) + log.(2 .* ds) / 3
    make_plot(expected_max_normals, lowers_normals, uppers_normals, "normal.png")

    expected_max_poissons = [get_expected_max_dist(d, nrep, Poisson(1)) for d in ds]
    lowers_poissons = log.(ds) ./ (16 * log.(log.(ds)))
    lowers_poissons = reverse(accumulate(min, reverse(lowers_poissons)))
    lowers_poissons = max.(0, lowers_poissons)
    println(lowers_poissons)
    uppers_poissons = log.(2*ds) / 3 + sqrt.(2 .* log.(2 .* ds))
    make_plot(expected_max_poissons, lowers_poissons, uppers_poissons, "poisson.png")


    #p = lineplot(ds, mean_max_normals, ylim = (0, 5))
    #lineplot!(p, ds, sqrt.(2 * log.(2 .* ds)))

end

main()
