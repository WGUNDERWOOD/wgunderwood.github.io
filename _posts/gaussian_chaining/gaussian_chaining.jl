using Distributions
using Random
using PyPlot

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

function get_Sigma(xs::Vector{Float64}, kernel::Kernel)
    Sigma = broadcast((x, y) -> evaluate(x, y, kernel), xs, xs')
    min_eig = eigmin(Sigma)
    if min_eig < 0
        return Sigma - min_eig * I
    else
        return Sigma
    end
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

    ls = Dict(RBFKernel => [0.05, 0.3], OUKernel => [0.2, 5])
    nrep = 10
    ngrid = 150
    xs = collect(range(0, 1, length = ngrid))

    for k in keys(ls)
        for (i, l) in enumerate(ls[k])

            kernel = k(l)
            Sigma = get_Sigma(xs, kernel)
            gp = MvNormal(Sigma)
            Zs = [rand(gp) for _ in 1:nrep]

            for (j, Z) in enumerate(Zs)
                fig, ax = plt.subplots(figsize=(6,4))
                ax.plot(xs, Z, color = "#bd93f9")

                plt.xlabel("Index, \$x\$", color = "#FFFFFF", size=10)
                plt.ylabel("Gaussian process, \$Z_x\$", color = "#FFFFFF",
                           size=10, labelpad=12)
                plt.ylim((-3.5, 3.5))
                ax.set_yticks(-3:3)
                fig, ax = format_plot(fig, ax)
                savefig("traj_$(shortname(kernel))_l$(i)_rep$(j).pgf",
                        bbox_inches="tight")
                close("all")
            end
        end
    end
end

function plot_bounds()

    ls = Dict(RBFKernel => collect(0.05:0.05:5),
              OUKernel => collect(0.05:0.05:5))
    nrep = 500
    ngrid = 500
    xs = collect(range(0, 1, length = ngrid))

    for k in keys(ls)

        expected_max_Zs = zeros(length(ls[k]))

        for (i, l) in enumerate(ls[k])

            kernel = k(l)
            Sigma = get_Sigma(xs, kernel)
            gp = MvNormal(Sigma)

            for rep in 1:nrep
                Z = rand(gp)
                max_Z = maximum(Z)
                expected_max_Zs[i] += max_Z / nrep
            end
        end

        fig, ax = plt.subplots(figsize=(6,4))
        ax.plot(ls[k], expected_max_Zs, color = "#8be9fd")

        if k == RBFKernel
            ax.plot(ls[k], 12 ./ ls[k], color = "#ff79c6")
        elseif k == OUKernel
            ax.plot(ls[k], 12 ./ sqrt.(ls[k]), color = "#ff79c6")
        end
        plt.xlabel("Scale, \$l\$", color = "#FFFFFF", size=10)
        plt.ylabel("Expected supremum", color = "#FFFFFF", size=10, labelpad=12)
        ax.set_yticks(0:0.5:2.5)
        plt.ylim((0, 2.5))
        fig, ax = format_plot(fig, ax)
        savefig("bounds_$(shortname(k(1))).pgf",
                bbox_inches="tight")
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
