PDF = build/presentation.pdf

.PHONY: all open clean

all: $(PDF)
	xdg-open $(PDF)

$(PDF): presentation.tex
	mkdir -p build
	latexmk

clean:
	latexmk -C
