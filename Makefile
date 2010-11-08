.PHONY: all build-pdf clean

latex_exe  = xelatex
builddir   = build
includedir = ./include
TEXINPUTS  = .:$(includedir):

export TEXINPUTS

all: build-pdf

build-pdf:
	mkdir -p $(builddir)
	$(latex_exe) --output-directory=$(builddir) resume.tex
	cp $(builddir)/resume.pdf resume.pdf

clean:
	rm -rf build/

# Note => Look into http://xpt.sourceforge.net/tools/latexmake/
