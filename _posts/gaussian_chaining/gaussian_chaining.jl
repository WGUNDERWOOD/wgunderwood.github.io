using Distributions
using LinearAlgebra
using Random
using UnicodePlots

struct Interval
    lo::Float64
    hi::Float64
end

abstract type Kernel end

struct RBFKernel <: Kernel
    scale::Float64
end

struct OUKernel <: Kernel
    scale::Float64
end

evaluate(x::Float64, y::Float64, kernel::OUKernel) = exp(-abs(x-y) / kernel.scale)
evaluate(x::Float64, y::Float64, kernel::RBFKernel) = exp(-(x-y)^2 / (2*kernel.scale^2))

function sample_gaussian(Sigma_svd::SVD)
    Z = rand(Normal(0, 1), length(Sigma_svd.S))
    return Sigma_svd.U * Diagonal(sqrt.(Sigma_svd.S)) * Sigma_svd.Vt * Z
end

function get_Sigma(xs::Vector{Float64}, kernel::Kernel)
    return broadcast((x, y) -> evaluate(x, y, kernel), xs, xs')
end

scale = 0.3
#kernel = OUKernel(scale)
kernel = RBFKernel(scale)
ngrid = 1000
xs = collect(range(0, 1, length = ngrid))
Sigma = get_Sigma(xs, kernel)
Sigma_svd = svd(Sigma)
Z = sample_gaussian(Sigma_svd)

lineplot(Z)

#mean_Z = 0.0
#nreps = 100
#display(size(Sigma))

#for rep in 1:nreps
    #Z = sample_gaussian_max(Sigma)
    #global mean_Z += Z / nreps
#end

#println(scale)
#println(mean_Z)
