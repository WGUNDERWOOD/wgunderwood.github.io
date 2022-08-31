all: plots compress copy

.PHONY: plots compress copy

plots:
	python local_polynomial_regression_1.py

#compress:
	#mogrify -path . -resize 500x500 *.png

#copy:
	#ROOT=$$(git rev-parse --show-toplevel);\
	#DEST="$$ROOT/assets/posts/dirichlet_problem_local_martingales";\
	#cp *.png $$DEST




#cd ../../plots && gifsicle -i "global_warming.gif" -O3 --colors 16 -o "global_warming_small.gif"
