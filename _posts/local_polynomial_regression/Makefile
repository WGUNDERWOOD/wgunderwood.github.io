all: python svg clean copy

.PHONY: python svg clean copy

python:
	#python local_polynomial_regression_1.py
	#python local_polynomial_regression_2.py
	#python local_polynomial_regression_3.py
	python local_polynomial_regression_4.py

svg:
	#./pgf2svg data.pgf
	#./pgf2svg linear_fit_linear_data.pgf
	#./pgf2svg linear_fit_quadratic_data.pgf
	#./pgf2svg nadaraya_fit_general_data.pgf
	#./pgf2svg polynomial_fit_general_data.pgf
	#./pgf2svg quadratic_fit_general_data.pgf
	#./pgf2svg quadratic_fit_quadratic_data.pgf
	#./pgf2svg kernels.pgf

	#./pgf2svg min_mse_bandwidths.pgf
	#./pgf2svg min_mse_data.pgf
	#./pgf2svg min_loo_cv_bandwidths.pgf
	#./pgf2svg min_loo_cv_data.pgf
	#./pgf2svg topologist_sine_curve.pgf

	#./pgf2svg boundary_bias.pgf
	#./pgf2svg boundary_bias_fixed.pgf
	#./pgf2svg second_order_bias_fixed.pgf

	#./pgf2svg global_warming_loocv.pgf
	#gifsicle -i "global_warming_large.gif" -O3 --colors 16 -o "global_warming.gif"
	cp global_warming_large.gif global_warming.gif

clean:
	texclean
	rm -f *.pgf
	rm -f global_warming_large.svg
	rm -rf __pycache__/

copy:
	ROOT=$$(git rev-parse --show-toplevel);\
	DEST="$$ROOT/assets/posts/local_polynomial_regression/";\
	cp *.svg $$DEST ;\
	cp global_warming.gif $$DEST
