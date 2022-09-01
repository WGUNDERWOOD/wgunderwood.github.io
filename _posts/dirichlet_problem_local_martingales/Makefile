all: plots trim compress copy

.PHONY: plots trim compress copy

plots:
	python script.py

trim:
	magick boundary.png -shave 60x60 boundary.png
	magick paths.png -shave 60x60 paths.png
	magick surf_M1_f10.png -shave 60x60 surf_M1_f10.png
	magick surf_M1_f20.png -shave 60x60 surf_M1_f20.png
	magick surf_M30_f10.png -shave 60x60 surf_M30_f10.png
	magick surf_M30_f20.png -shave 60x60 surf_M30_f20.png

compress:
	mogrify -path . -resize 500x500 *.png

copy:
	ROOT=$$(git rev-parse --show-toplevel);\
	DEST="$$ROOT/assets/posts/dirichlet_problem_local_martingales";\
	cp *.png $$DEST
