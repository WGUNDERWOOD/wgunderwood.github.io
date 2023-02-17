PREAMBLE="\usepackage[sfdefault,light]{inter}\DeclareMathSizes{10}{11}{9}{9}"

all: julia svg clean copy

.PHONY: julia svg clean copy

python:
	julia
	python local_polynomial_regression_2.py
	python local_polynomial_regression_3.py
	python local_polynomial_regression_4.py

svg:
	pgf2svg -p $(PREAMBLE) data.pgf
	pgf2svg -p $(PREAMBLE) linear_fit_linear_data.pgf
	pgf2svg -p $(PREAMBLE) linear_fit_quadratic_data.pgf
	pgf2svg -p $(PREAMBLE) nadaraya_fit_general_data.pgf
	pgf2svg -p $(PREAMBLE) polynomial_fit_general_data.pgf
	pgf2svg -p $(PREAMBLE) quadratic_fit_general_data.pgf
	pgf2svg -p $(PREAMBLE) quadratic_fit_quadratic_data.pgf
	pgf2svg -p $(PREAMBLE) kernels.pgf

	pgf2svg -p $(PREAMBLE) min_mse_bandwidths.pgf
	pgf2svg -p $(PREAMBLE) min_mse_data.pgf
	pgf2svg -p $(PREAMBLE) min_loo_cv_bandwidths.pgf
	pgf2svg -p $(PREAMBLE) min_loo_cv_data.pgf
	pgf2svg -p $(PREAMBLE) topologist_sine_curve.pgf

	pgf2svg -p $(PREAMBLE) boundary_bias.pgf
	pgf2svg -p $(PREAMBLE) boundary_bias_fixed.pgf
	pgf2svg -p $(PREAMBLE) second_order_bias_fixed.pgf

	pgf2svg -p $(PREAMBLE) global_warming_loocv.pgf
	for f in global_warming_bandwidth???.pgf ; do \
		n=$$(basename $$f .pgf) ; \
		echo $$n ; \
		pgf2svg -p $(PREAMBLE) $$n.pgf ; \
		svgcleaner $$n.svg $${n}_small.svg ; \
		mv $${n}_small.svg $$n.svg ; \
	done
	svgasm -d 1/3 -l "Loading..." global_warming_bandwidth???.svg > global_warming.svg

clean:
	texclean
	rm -f *.pgf
	rm -f global_warming_bandwidth???.svg
	rm -rf __pycache__/

copy:
	ROOT=$$(git rev-parse --show-toplevel);\
	DEST="$$ROOT/assets/posts/local_polynomial_regression/";\
	cp *.svg $$DEST
