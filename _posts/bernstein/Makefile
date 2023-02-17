PREAMBLE="\usepackage[sfdefault,light]{inter}\DeclareMathSizes{10}{11}{9}{9}"

all: julia svg clean copy

.PHONY: julia svg clean copy

julia:
	julia bernstein.jl

svg:
	pgf2svg -p $(PREAMBLE) bernstein.pgf
	svgo bernstein.svg

clean:
	latexmk -C
	rm -fv *.pgf
	rm -fv *.svg

copy:
	ROOT=$$(git rev-parse --show-toplevel);\
	DEST="$$ROOT/assets/posts/bernstein/";\
	cp bernstein.svg $$DEST
