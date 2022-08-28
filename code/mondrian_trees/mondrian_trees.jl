using PyPlot
using Random
using Distributions


#rcParams = PyPlot.PyDict(PyPlot.matplotlib."rcParams")
#rcParams["text.usetex"] = true
#rcParams["mathtext.fontset"]  = "cm";
#rcParams["font.family"]  = "serif";
#rcParams["font.serif"]  = "cm";
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


function plot_mondrian(m::Vector{Cell}, t::Float64, filename::String)

    @assert length(m[1].a) == 2
    fig, ax = plt.subplots(figsize=(4,4))
    m_sorted = sort(m, by=(c -> minimum(c.b .- c.a)))
    #color_gradient = cgrad([:white, :lightblue])

    for c in m_sorted
        if c.t <= t
            min_length = minimum(c.b .- c.a)
            dim_c = sum(c.b .- c.a)
            xs = [c.a[1], c.b[1], c.b[1], c.a[1], c.a[1]]
            ys = [c.a[2], c.a[2], c.b[2], c.b[2], c.a[2]]
            x = [0.5 for j in 1:d]
            ax.fill(xs, ys, facecolor="gray")
            ax.plot(xs, ys, color="black")

        #plot!(xs, ys, linecolor="black", lw=min_length*0)
        end
    end

    PyPlot.savefig(filename)
    close("all")
    return nothing
end


d = 2
lambda = 5.0
c = Cell(d)
m = sample_mondrian(c, lambda)
display(m)

file = open("temp.sh", "w")
write(file, "")
close(file)

for i in 1:length(unique([c.t for c in m]))
    if i <= 10
        t = sort(unique([c.t for c in m]))[i]
        filename = "temp_" * lpad(i, 2, "0")
        p = plot_mondrian(m, t, filename * ".png")
        file = open("temp.sh", "a")
        write(file, "convert " * filename * ".png " * filename * ".gif\n")
        close(file)
    end
end



# make gif

file = open("temp.sh", "a")
write(file, "gifsicle -l -d 50 temp*.gif > mondrian.gif\n")
write(file, "rm temp*.gif temp*.png\n")
close(file)

run(`bash temp.sh`)

println()
