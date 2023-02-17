using Distributions
using UnicodePlots

ds = 10:100
n_rep = 10

for d in ds
    for rep in 1:n_rep
    xs = rand(Normal(mu, sigma), d)
