PREAMBLE="\usepackage[sfdefault,light]{inter}\usepackage{amsfonts}\DeclareMathSizes{10}{11}{9}{9}"

all: julia svg copy clean

.PHONY: julia svg copy clean

julia:
	julia gaussian_chaining.jl

svg:
	pgf2svg -p $(PREAMBLE) trajectory_RBF_1.pgf
	pgf2svg -p $(PREAMBLE) trajectory_RBF_2.pgf
	pgf2svg -p $(PREAMBLE) trajectory_OU_1.pgf
	pgf2svg -p $(PREAMBLE) trajectory_OU_2.pgf
	pgf2svg -p $(PREAMBLE) bounds_RBF.pgf
	pgf2svg -p $(PREAMBLE) bounds_OU.pgf
	svgo trajectory_RBF_1.svg
	svgo trajectory_RBF_2.svg
	svgo trajectory_OU_1.svg
	svgo trajectory_OU_2.svg
	svgo bounds_RBF.svg
	svgo bounds_OU.svg

copy:
	ROOT=$$(git rev-parse --show-toplevel);\
	DEST="$$ROOT/assets/posts/gaussian_chaining/";\
	cp trajectory_RBF_1.svg $$DEST;\
	cp trajectory_RBF_2.svg $$DEST;\
	cp trajectory_OU_1.svg $$DEST;\
	cp trajectory_OU_2.svg $$DEST;\
	cp bounds_RBF.svg $$DEST;\
	cp bounds_OU.svg $$DEST

clean:
	rm -fv *.pgf
	rm -fv *.svg
