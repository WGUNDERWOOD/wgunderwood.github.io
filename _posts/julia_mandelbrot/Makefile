all: plot compress copy

.PHONY: plot compress copy

plot:
	julia -t 12 julia_julia.jl

compress:
	convert julia_set.png -resize 500x288 julia_set_small.png

copy:
	ROOT=$$(git rev-parse --show-toplevel);\
	DEST="$$ROOT/assets/posts/julia_mandelbrot";\
	cp julia_set_small.png "$$DEST/julia.png"
