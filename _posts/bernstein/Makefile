PREAMBLE="\usepackage[sfdefault,light]{inter}\DeclareMathSizes{10}{11}{9}{9}"

all: julia svg copy clean

.PHONY: julia svg copy clean

julia:
	julia bernstein.jl

svg:
	pgf2svg -p $(PREAMBLE) bernstein.pgf
	svgo bernstein.svg

copy:
	ROOT=$$(git rev-parse --show-toplevel);\
	DEST="$$ROOT/assets/posts/bernstein/";\
	cp bernstein.svg $$DEST

clean:
	rm -fv *.pgf
	rm -fv *.svg
