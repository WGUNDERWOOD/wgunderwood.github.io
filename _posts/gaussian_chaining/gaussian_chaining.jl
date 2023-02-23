using Distributions
using LinearAlgebra
using Random
using PyPlot


struct Interval
    lo::Float64
    hi::Float64
end

abstract type Kernel end

struct RBFKernel <: Kernel
    l::Float64
end

struct OUKernel <: Kernel
    l::Float64
end

evaluate(x::Float64, y::Float64, kernel::OUKernel) = exp(-abs(x-y) / kernel.l)
evaluate(x::Float64, y::Float64, kernel::RBFKernel) = exp(-(x-y)^2 / (2*kernel.l^2))
name(kernel::OUKernel) = "Ornstein--Uhlenbeck"
name(kernel::RBFKernel) = "Radial basis function"
shortname(kernel::OUKernel) = "OU"
shortname(kernel::RBFKernel) = "RBF"

function sample_gaussian(Sigma_svd::SVD)
    Z = rand(Normal(0, 1), length(Sigma_svd.S))
    return Sigma_svd.U * Diagonal(sqrt.(Sigma_svd.S)) * Sigma_svd.Vt * Z
end

function get_Sigma(xs::Vector{Float64}, kernel::Kernel)
    return broadcast((x, y) -> evaluate(x, y, kernel), xs, xs')
end

function format_plot(fig, ax)

    rcParams = PyPlot.PyDict(PyPlot.matplotlib."rcParams")
    rcParams["pgf.preamble"]  = "\\usepackage{amsfonts}"

    fig.patch.set_alpha(0)
    ax.patch.set_alpha(0)
    ax.tick_params(colors="white")

    for loc in ["bottom", "top", "left", "right"]
        ax.spines[loc].set_color("white")
    end

    return (fig, ax)
end

function plot_trajectories()

    ls = Dict(RBFKernel => [0.05, 0.3], OUKernel => [0.4, 1])
    nrep = 3
    ngrid = 200
    xs = collect(range(0, 1, length = ngrid))

    for k in keys(ls)
        for (i, l) in enumerate(ls[k])

            kernel = k(l)
            Sigma = get_Sigma(xs, kernel)
            Sigma_svd = svd(Sigma)
            Zs = [sample_gaussian(Sigma_svd) for _ in 1:nrep]
            fig, ax = plt.subplots(figsize=(6,4))
            colors = ["#bd93f9", "#50fa7b", "#ffb86c", "#8be9fd", "#ff79c6"]

            for (j, Z) in enumerate(Zs)
                ax.plot(xs, Z, color = colors[j])
            end

            plt.xlabel("Index, \$x\$", color = "#FFFFFF", size=10)
            plt.ylabel("Gaussian process, \$Z_x\$", color = "#FFFFFF",
                       size=10, labelpad=12)
            ax.set_yticks(-3:3)
            fig, ax = format_plot(fig, ax)
            savefig("trajectory_$(shortname(kernel))_$i.pgf")
            close("all")
        end
    end
end

function plot_bounds()

    ls = Dict(RBFKernel => collect(0.1:0.1:1),
              OUKernel => collect(0.1:0.1:1))
    nrep = 200
    ngrid = 100
    xs = collect(range(0, 1, length = ngrid))

    for k in keys(ls)

        expected_max_Zs = zeros(length(ls[k]))

        for (i, l) in enumerate(ls[k])

            kernel = k(l)
            Sigma = get_Sigma(xs, kernel)
            Sigma_svd = svd(Sigma)

            for rep in 1:nrep
                Z = sample_gaussian(Sigma_svd)
                max_Z = maximum(Z)
                expected_max_Zs[i] += max_Z / nrep
            end
        end

        fig, ax = plt.subplots(figsize=(6,4))
        colors = ["#bd93f9", "#50fa7b", "#ffb86c", "#8be9fd", "#ff79c6"]

        ax.plot(ls[k], expected_max_Zs, color = "#8be9fd")
        ax.plot(ls[k], 1 ./ ls[k], color = "#ff79c6")
        ax.plot(ls[k], 1 ./ sqrt.(ls[k]), color = "#ff79c6")
        plt.xlabel("Scale, \$l\$", color = "#FFFFFF", size=10)
        plt.ylabel("Expected supremum", color = "#FFFFFF", size=10, labelpad=12)
        ax.set_yticks(0:0.5:2)
        fig, ax = format_plot(fig, ax)
        savefig("bounds_$(shortname(k(1))).pgf")
        close("all")
    end
end

function main()
    Random.seed!(314159)
    plt.ioff()
    plot_trajectories()
    plot_bounds()
end

main()
