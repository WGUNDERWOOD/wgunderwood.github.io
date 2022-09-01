all: plots compress copy

.PHONY: plots compress copy

plots:
	python local_polynomial_regression_1.py
	latexmk -pdf -quiet pgf.tex
	pdf2svg pgf.pdf pgf_large.svg
	svgcleaner pgf_large.svg pgf.svg
	rm pgf_large.svg

#compress:
	#mogrify -path . -resize 500x500 *.png

#copy:
	#ROOT=$$(git rev-parse --show-toplevel);\
	#DEST="$$ROOT/assets/posts/dirichlet_problem_local_martingales";\
	#cp *.png $$DEST




#cd ../../plots && gifsicle -i "global_warming.gif" -O3 --colors 16 -o "global_warming_small.gif"
