using PyPlot
using Random
using Distributions
plt.ioff()


struct Cell
    a::Vector{Float64}
    b::Vector{Float64}
    t::Float64
end


function Cell(d::Int)
    a = fill(0.0, d)
    b = fill(1.0, d)
    t = 0.0
    return Cell(a, b, t)
end


function sample_mondrian(c::Cell, tau::Float64, lambda::Float64)

    d = length(c.a)
    dim_c = sum(c.b .- c.a)
    E = randexp() / dim_c
    t = tau + E

    if t <= lambda
        j = rand(DiscreteNonParametric(1:d, (c.b .- c.a)/dim_c))
        sj = rand(Uniform(c.a[j], c.b[j]))
        b0 = copy(c.b)
        b0[j] = sj
        c0 = Cell(c.a, b0, t)
        a1 = copy(c.a)
        a1[j] = sj
        c1 = Cell(a1, c.b, t)
        m0 = sample_mondrian(c0, tau+E, lambda)
        m1 = sample_mondrian(c1, tau+E, lambda)
        return [c; m0; m1]
    else
        return [c]
    end
end


function sample_mondrian(c::Cell, lambda::Float64)
    tau = 0.0
    return sample_mondrian(c, tau, lambda)
end


function display(c::Cell)
    println("Cell: ",
            round.(c.a, digits=3),
            " -- ",
            round.(c.b, digits=3),
            " at time ",
            round.(c.t, digits=3))
end


function display(m::Vector{Cell})
    m_sorted = sort(m, by = x -> x.t)
    display.(m_sorted)
end


function is_in(x::Vector{Float64}, c::Cell)
    return all(c.a .<= x .<= c.b)
end


function is_subcell(c1::Cell, c2::Cell)
    return all(c2.a .<= c1.a) && all(c1.b .<= c2.b)
end


function is_leaf(c::Cell, m::Vector{Cell})
    return all([!is_subcell(c1, c) for c1 in m if c1 !== c])
end


function get_leaves(m::Vector{Cell})
    return [c for c in m if is_leaf(c, m)]
end


function plot_mondrian(m::Vector{Cell}, t::Float64, filename::String)

    @assert length(m[1].a) == 2
    fig, ax = plt.subplots(figsize=(4,4))
    m_sorted = sort(m, by=(c -> minimum(c.b .- c.a)))
    leaves = get_leaves([c for c in m if c.t <= t])

    for c in leaves
        min_length = minimum(c.b .- c.a)
        dim_c = sum(c.b .- c.a)
        xs = [c.a[1], c.b[1], c.b[1], c.a[1], c.a[1]]
        ys = [c.a[2], c.a[2], c.b[2], c.b[2], c.a[2]]
        x = [0.5 for j in 1:d]
        ax.fill(xs, ys, facecolor="gray")
        ax.plot(xs, ys, color="black")
    end

    ax.set_xlim([0,1])
    ax.set_ylim([0,1])
    plt.axis("off")
    plt.tight_layout(pad=0)
    savefig(filename, dpi=200)
    close("all")
    return nothing
end


function animate_mondrian(m::Vector{Cell})

    ts = sort(unique([c.t for c in m]))

    for i in 1:length(ts)
        filename = "temp_" * lpad(i, 3, "0")
        plot_mondrian(m, ts[i], filename * ".svg")
        run(`convert $filename.svg $filename.gif`)
    end

    run(`bash -c "gifsicle -l -d 50 temp_*.gif > mondrian_tree.gif"`)
    run(`svgasm -o mondrian_tree.svg mondrian_tree.gif`)

    return nothing
end


d = 2
lambda = 3.0
c = Cell(d)
m = sample_mondrian(c, lambda)

animate_mondrian(m)
#run(`svgasm *.svg`)

#file = open("temp.sh", "w")
#write(file, "")
#close(file)


#file = open("temp.sh", "a")
#write(file, "convert " * filename * ".svg " * filename * ".gif\n")
#close(file)


# make gif

#file = open("temp.sh", "a")
#write(file, "gifsicle -l -d 50 temp*.gif > mondrian.gif\n")
#write(file, "rm temp*.gif temp*.png\n")
#close(file)

#run(`bash temp.sh`)
#run(`rm temp.sh`)


# https://stackoverflow.com/questions/48893587/simple-animate-multiple-svgs-in-sequence-like-a-looping-gif

println()

# TODO make sequence of svg files, then animate with CSS
# TODO output a single SVG sprite to assets/graphics
# TODO output a CSS file to _posts/mondrian_trees
# TODO output an HTML file for the image to _posts/mondrian_trees
# TODO load all the above from the post .markdown file
