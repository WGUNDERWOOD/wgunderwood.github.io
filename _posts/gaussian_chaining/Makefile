PREAMBLE="\usepackage[sfdefault,light]{inter}\usepackage{amsfonts}\DeclareMathSizes{10}{11}{9}{9}"

all: julia svg copy clean

.PHONY: julia svg copy clean

julia:
	julia gaussian_chaining.jl

svg:
	for f in *.pgf; do pgf2svg -p $(PREAMBLE) "$$f"; done

anim:
	svgasm traj_OU_l1_rep*.svg -d 1 > traj_OU_l1.svg

copy:
	#ROOT=$$(git rev-parse --show-toplevel);\
	#DEST="$$ROOT/assets/posts/gaussian_chaining/";\
	#cp trajectory_RBF_1.svg $$DEST;\
	#cp trajectory_RBF_2.svg $$DEST;\
	#cp trajectory_OU_1.svg $$DEST;\
	#cp trajectory_OU_2.svg $$DEST;\
	#cp bounds_RBF.svg $$DEST;\
	#cp bounds_OU.svg $$DEST

clean:
	rm -fv *.pgf
	rm -fv *.svg
