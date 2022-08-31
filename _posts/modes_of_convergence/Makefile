all: diagram convert copy clean

.PHONY: diagram convert copy clean

diagram:
	latexmk -pdf -quiet diagram

convert:
	pdf2svg diagram.pdf diagram_large.svg
	svgcleaner diagram_large.svg diagram.svg
	rm diagram_large.svg

copy:
	ROOT=$$(git rev-parse --show-toplevel);\
	DEST="$$ROOT/assets/posts/modes_of_convergence";\
	cp diagram.svg "$$DEST"

clean:
	texclean
