PREAMBLE="\usepackage[sfdefault,light]{inter}\usepackage{amsfonts}\DeclareMathSizes{10}{11}{9}{9}"

all: julia svg anim copy clean

.PHONY: julia svg anim copy clean

julia:
	julia gaussian_chaining.jl

svg:
	for f in *.pgf; do pgf2svg -p $(PREAMBLE) "$$f"; done

anim:
	svgasm traj_OU_l1_rep*.svg -d 1 > traj_OU_l1.svg
	svgasm traj_OU_l2_rep*.svg -d 1 > traj_OU_l2.svg
	svgasm traj_RBF_l1_rep*.svg -d 1 > traj_RBF_l1.svg
	svgasm traj_RBF_l2_rep*.svg -d 1 > traj_RBF_l2.svg

copy:
	ROOT=$$(git rev-parse --show-toplevel);\
	DEST="$$ROOT/assets/posts/gaussian_chaining/";\
	cp traj_OU_l1.svg $$DEST;\
	cp traj_OU_l2.svg $$DEST;\
	cp traj_RBF_l1.svg $$DEST;\
	cp traj_RBF_l2.svg $$DEST;\
	cp bounds_RBF.svg $$DEST;\
	cp bounds_OU.svg $$DEST

clean:
	rm -fv *.pgf
	rm -fv *.svg
