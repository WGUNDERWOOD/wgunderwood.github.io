PREAMBLE="\usepackage[sfdefault,light]{inter}\usepackage{amsfonts}\DeclareMathSizes{10}{11}{9}{9}"

all: julia svg copy clean

.PHONY: julia svg copy clean

julia:
	julia bernstein.jl

svg:
	pgf2svg -p $(PREAMBLE) maximum.pgf
	pgf2svg -p $(PREAMBLE) normal.pgf
	pgf2svg -p $(PREAMBLE) poisson.pgf
	svgo maximum.svg
	svgo normal.svg
	svgo poisson.svg

copy:
	ROOT=$$(git rev-parse --show-toplevel);\
	DEST="$$ROOT/assets/posts/bernstein/";\
	cp maximum.svg $$DEST;\
	cp normal.svg $$DEST;\
	cp poisson.svg $$DEST

clean:
	rm -fv *.pgf
	rm -fv *.svg
