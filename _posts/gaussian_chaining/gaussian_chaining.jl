using Distributions
using LinearAlgebra

struct Interval
    lo::Float64
    hi::Float64
end

function sample_gaussian_max(Sigma::Matrix{Float64})
    return maximum(rand(MvNormal(Sigma)))
end

function get_Sigma(T::Interval, scale::Float64, res::Float64)

    xs = T.lo : res : T.hi
    n_xs = length(xs)
    Sigma = zeros(n_xs, n_xs)

    for i in 1:n_xs, j in 1:n_xs
        Sigma[i, j] = exp(-(xs[i] - xs[j])^2 / (2 * scale^2))
    end

    min_eig = minimum(eigvals(Sigma))

    if min_eig < 0
        Sigma -= min_eig * I
    end

    return Sigma
end

T = Interval(0, 1)
scale = 0.3
res = 0.01
Sigma = get_Sigma(T, scale, res)
mean_Z = 0.0
nreps = 100

for rep in 1:nreps
    Z = sample_gaussian_max(Sigma)
    global mean_Z += Z / nreps
end

println(scale)
println(mean_Z)
