.PHONY: all build-txts build-pdfs clean setup

LATEX      = xelatex
BUILDDIR   = build
INCLUDEDIR = ./include

# Make sure that our 3rd-party resources are included
TEXINPUTS = .:$(INCLUDEDIR):
export TEXINPUTS

PDFS = $(patsubst templates/%.tex,%.pdf,$(wildcard templates/*.tex))
TXTS = $(patsubst templates/%.tex,%.txt,$(wildcard templates/*.tex))

build-pdfs: $(PDFS)
build-txts: $(TXTS)

all: build-pdfs build-txts

test-vars:
	@echo "\$$PDFS => $(PDFS)"
	@echo "\$$TXTS => $(TXTS)"

%.pdf: %.tex
	mkdir -p $(BUILDDIR)
	$(LATEX) --output-directory=$(BUILDDIR) "$<"
	cp $(BUILDDIR)/"$@" "$@"

%.tex: %.tex.j2
	./tools/build_tex "$(notdir $<)"

%.txt: %.pdf
	pdftotext "$<"
	@echo "**WARNING** The resultant file will likely need some"
	@echo "            tweaking before it's presentable."

setup:
	@echo
	@echo "-!- Installing LaTeX Dependencies -!-"
	@echo
	@./tools/install-deps.sh

	@echo
	@echo "-!- Installing Required Fonts -!-"
	@echo
	@./tools/install-fonts.sh

	@echo
	@echo "-!- Setting up Jinja2 -!-"
	@echo
	@./tools/setup-jinja.sh

clean:
	rm -rf build/

# Note => Look into http://xpt.sourceforge.net/tools/latexmake/
