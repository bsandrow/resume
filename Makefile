.PHONY: all build-pdf clean fonts

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

build-pdf-copy:
	mkdir -p $(builddir)
	$(latex_exe) --output-directory=$(builddir) resume.copy.tex
	cp $(builddir)/resume.copy.pdf resume.copy.pdf

fonts:
	test -d "$(HOME)/.fonts" || mkdir -p "$(HOME)/.fonts"
	test ! -d "fonts" || cp -v fonts/*/* "$(HOME)/.fonts/"
	fc-cache -fv

clean:
	rm -rf build/

# Note => Look into http://xpt.sourceforge.net/tools/latexmake/
