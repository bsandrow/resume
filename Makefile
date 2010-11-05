.PHONY: all build-pdf clean

builddir   = build
includedir = ./include
TEXINPUTS  = .:$(includedir):

export TEXINPUTS

all: build-pdf

build-pdf:
	mkdir -p $(builddir)
	pdflatex --output-directory=$(builddir) resume.tex
	cp $(builddir)/resume.pdf resume.pdf

clean:
	rm -rf build/

# Note => Look into http://xpt.sourceforge.net/tools/latexmake/
