WEBDIR = "/home/will/Documents/github/wgunderwood.github.io/assets/graphics/posts/images_probability_limit_theorems/"

all: plots copy

.PHONY: plots copy

plots:
	@cd julia && julia probability_limit_theorems.jl

copy:
	@cp plots/lln.gif $(WEBDIR)
	@cp plots/clt.gif $(WEBDIR)
	@cp plots/lil.gif $(WEBDIR)
