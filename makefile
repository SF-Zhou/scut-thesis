DOC=scutthesis
DEPS=$(wildcard $(DOC).*) cover figure
LATEX=xelatex
BIBTEX=bibtex
BIBAUX=$(DOC).aux
BIBS=$(BIBAUX:.aux=.bbl)
BUILD=build
SOFT_LINKS=$(DEPS:%=$(BUILD)/%)
ROOT_DIR=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))


all: $(BUILD)/$(DOC).pdf

$(BUILD)/$(DOC).pdf: $(DEPS) soft-link
	cd $(BUILD) && $(LATEX) $(DOC).tex
	cd $(BUILD) && $(BIBTEX) $(DOC)
	cd $(BUILD) && $(LATEX) $(DOC).tex
	cd $(BUILD) && $(LATEX) $(DOC).tex

soft-link: $(BUILD) $(SOFT_LINKS)

$(BUILD):
	mkdir -p $(BUILD)

$(BUILD)/%:
	cd $(BUILD) && ln -s $(ROOT_DIR)$* .

clean:
	- rm -rf build/*
