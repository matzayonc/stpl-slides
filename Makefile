PRES_DIR   = presentations
BUILD_DIR  = build
DIST_DIR   = dist
SLIDES_DIR = $(DIST_DIR)/slides

SOURCES := $(wildcard $(PRES_DIR)/*.tex)
PDFS    := $(patsubst $(PRES_DIR)/%.tex,$(DIST_DIR)/%.pdf,$(SOURCES))

# Default presentation for single-target commands (override with PRES=name)
PRES ?= $(basename $(notdir $(firstword $(SOURCES))))

.PHONY: all open clean slides convert pptx

all: $(PDFS)

$(DIST_DIR)/%.pdf: $(PRES_DIR)/%.tex preamble.tex
	mkdir -p $(BUILD_DIR) $(DIST_DIR)
	latexmk $<

open: $(DIST_DIR)/$(PRES).pdf
	xdg-open $<

# Convert each slide to a PNG for Google Slides import
slides: $(DIST_DIR)/$(PRES).pdf
	mkdir -p $(SLIDES_DIR)/$(PRES)
	pdftocairo -png -r 150 $< $(SLIDES_DIR)/$(PRES)/slide

# Convert to PPTX via LibreOffice (best Google Slides compatibility)
pptx: $(DIST_DIR)/$(PRES).pdf
	libreoffice --headless --infilter="impress_pdf_import" --convert-to pptx --outdir $(DIST_DIR) $<

# Flatten fonts/transparency for Google Slides PDF import
convert: $(DIST_DIR)/$(PRES).pdf
	gs -dBATCH -dNOPAUSE -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 \
		-sOutputFile=$(DIST_DIR)/$(PRES)-compat.pdf $<

clean:
	latexmk -C $(SOURCES)
	rm -rf $(BUILD_DIR) $(DIST_DIR)
