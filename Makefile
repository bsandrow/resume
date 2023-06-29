.PHONY: all build-txts build-pdfs clean fonts

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

ubuntu-deps:
	@echo "Note: Only tested on Ubuntu 12.10..."
	sudo apt-get install python-jinja2
	sudo apt-get install texlive-xetex

test-vars:
	@echo "\$$PDFS => $(PDFS)"
	@echo "\$$TXTS => $(TXTS)"

%.pdf: %.tex
	mkdir -p $(BUILDDIR)
	$(LATEX) --output-directory=$(BUILDDIR) "$<"
	cp $(BUILDDIR)/"$@" "$@"

%.tex: templates/%.tex
	./tools/build_tex "$(notdir $<)"

%.txt: %.pdf
	pdftotext "$<"
	@echo "**WARNING** The resultant file will likely need some"
	@echo "            tweaking before it's presentable."

fonts:
	./tools/install-fonts.sh

clean:
	rm -rf build/

# Note => Look into http://xpt.sourceforge.net/tools/latexmake/
