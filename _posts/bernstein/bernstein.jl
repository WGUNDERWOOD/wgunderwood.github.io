using PyPlot

function bernstein_bound(n, sigma, M, d)
    term1 = sqrt(24 * n * sigma^2 * log(2*d))
    term2 = 4 * M * log(2 * d)
    return term1 + term2
end

ns = (1:100) .* ones(100)'
ds = ones(100) .* (1:100)'
sigma = 1
M = 10

bs = bernstein_bound.(ns, sigma, M, ds)
fig = plt.figure()
ax = fig.add_subplot(111, projection="3d")
ax.plot_surface(ns, ds, bs)
#lineplot(b)

#=
function sample_two_value(v1, p1, v2, p2)
    @assert p1 + p2 == 1
    r = rand()
    if r <= p1
        return v1
    else
        return v2
    end
end

get_M(v1, p1, v2, p2) = max(abs(v1), abs(v2))

function get_sigma(v1, p1, v2, p2)
    mean = v1 * p1 + v2 * p2
    mean_of_square = v1^2 * p1 + v2^2 * p2
    return sqrt(mean_of_square - mean^2)
end

v1 = 1
v2 = -1
p1 = 0.5
p2 = 0.5

n = 100
d = 100
n_reps = 100

M = get_M(v1, p1, v2, p2)
sigma = get_sigma(v1, p1, v2, p2)
norm_sample_sums = Float64[]

for rep in 1:n_reps
    xs = [[sample_two_value(v1, p1, v2, p2) for _ in 1:d] for _ in 1:n]
    sample_sum = sum(xs)
    norm_sample_sum = maximum(abs.(sample_sum))
    push!(norm_sample_sums, norm_sample_sum)
end

println(sum(norm_sample_sums) / n_reps)
println(bernstein_bound(n, sigma, M, d))
=#
