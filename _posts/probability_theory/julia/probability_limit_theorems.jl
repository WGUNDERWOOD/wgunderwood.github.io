using PyPlot
using Random
using Colors

#Random.seed!(314159)

# TODO decide content of posts
# 1: lln, slow, 5 samples converge to horizontal line
# 2: clt, fast, 5 samples converge to gaussian pdf shown vertical at end
# 3: lil, fast, 5 samples eventually stay in [-1,1], horizontal lines

# TODO tidy code into functions
# TODO parallelize loops?

# plot params
rcParams = PyPlot.PyDict(PyPlot.matplotlib."rcParams")
rcParams["font.family"]  = "sans-serif"
rcParams["font.sans-serif"]  = "Inter"
plt.rcParams["axes.labelweight"] = "light"
plt.rcParams["font.weight"] = "light"
plt.ioff()


function random_walk(n::Int, p::Float64)
    return cumsum([rand() <= p for i in 1:n])
end


function make_lln(n, p)
    return random_walk(n, p) ./ (1:n)
end


function make_clt(lln, n, p)
    return (lln .- p) ./ sqrt.(p * (1-p) ./ (1:n))
end


function make_lil(clt, n, p)
    return clt ./ sqrt(2 * log(log(n)))
end


function initialize_plot(ylim)

    fig, ax = plt.subplots(figsize=(6,4))
    fig.patch.set_alpha(0)
    ax.patch.set_alpha(0)
    ax.tick_params(colors="white")
    plt.ylim(ylim)

    for loc in ["bottom", "top", "left", "right"]
        ax.spines[loc].set_color("white")
    end

    return (fig, ax)

end


function make_plot(s::Vector{<:Real}, p::Float64, filepath::String,
                   ylim::Vector{Float64})

        (fig, ax) = initialize_plot(ylim)

        ax.plot([0, max(20, length(s)-1)], [p, p],
                color = "#888888", linewidth=1)

        colors = reverse(hex.([HSV(0,0,0.3*exp(-0.002*i)+0.7) for i in 0:length(s)-1]))

        for i in 1:(length(s)-1)
            ax.plot([i-1, i], s[i:i+1], linewidth=1, color="#" * colors[i])
        end

        ax.scatter(length(s)-1, last(s), color = "white", s=5)

        # set ticks
        min_tick = round(Int, ceil(minimum(diff(ax.get_xticks()))))
        min_tick = max(min_tick, 5)
        xlim = ax.get_xlim()

        if length(s) <= 20
            ax.set_xticks(range(0, 20, step=5))
            plt.xlim([-1, 21])
        else
            ax.set_xticks(range(0, length(s), step=min_tick))
            plt.xlim(xlim)
        end

        PyPlot.savefig(filepath, dpi=200)
        close("all")
end


function make_gif(s::Vector{<:Real}, breaks::Vector{Int}, p::Float64,
                  temp_dir::String, filepath::String, ylim::Vector{Float64})

    println("Making plots...")

    for b in 1:length(breaks)
        println("$b / $(length(breaks))")
        b_format = string(b, pad=6)
        make_plot(s[1:breaks[b]], p, temp_dir * "/$b_format" * ".png", ylim)
    end

    # TODO bounding box?
    println("Making gif...")
    last_frame = string(length(breaks), pad=6)
    run(`convert -dispose Previous -delay 15 $temp_dir/\*.png -delay 100 $temp_dir/$last_frame.png $filepath`)
    run(`gifsicle -i $filepath -O3 --colors 16 -o $filepath`)
    run(`ls -lh $filepath`)
    foreach(rm, readdir(temp_dir, join=true))

end


function make_breaks(n, n_frames, q)

    breaks = round.(Int, range(0, stop=(n-20)^(1/q), length=n_frames).^q)
    breaks .+= 20
    breaks = [1:20; breaks]
    breaks = unique(breaks)

    return breaks
end







n = 1000
p = 0.6
q = 2
n_frames = 50
breaks = make_breaks(n, n_frames, q)
temp_dir = "../plots/temp/"

lln = make_lln(n, p)
clt = make_clt(lln, n, p)
lil = make_lil(clt, n, p)

ylim = [-0.1, 1.1]
make_gif(lln, breaks, p, temp_dir, "../plots/lln.gif", ylim)
ylim = [-3.1, 3.1]
make_gif(clt, breaks, p, temp_dir, "../plots/clt.gif", ylim)
ylim = [-2.1, 2.1]
make_gif(lil, breaks, p, temp_dir, "../plots/lil.gif", ylim)
