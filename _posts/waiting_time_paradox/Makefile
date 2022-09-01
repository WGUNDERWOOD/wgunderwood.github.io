all: python diagram convert copy clean

.PHONY: python diagram convert copy clean

python:
	python waiting_script.py

diagram:
	latexmk -pdf -quiet time_diagram.tex

convert:
	pdf2svg time_diagram.pdf time_diagram_large.svg
	svgcleaner time_diagram_large.svg time_diagram.svg
	rm time_diagram_large.svg

copy:
	ROOT=$$(git rev-parse --show-toplevel);\
	DEST="$$ROOT/assets/posts/waiting_time_paradox";\
	cp time_diagram.svg "$$DEST"

clean:
	texclean
