using PyPlot

n_rs = 5000
n_rep = 400
threshold = Int(0.5 * n_rep)

rs = range(1, 4, n_rs)
x0 = 0.5

function logistic_map(x, r)
    return r * x * (1 - x)
end

rs_plot = Float64[]
xs_plot = Float64[]

for r in rs
    x = x0
    for rep in 1:n_rep
        x = logistic_map.(x, r)
        if rep > threshold
            push!(rs_plot, r)
            push!(xs_plot, x)
        end
    end
end

ioff()
close()
figure(figsize=(15, 10))
scatter(rs_plot, xs_plot, s=1, c="k")
savefig("./bifurcation.png", dpi=200)
