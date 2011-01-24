.PHONY: all build-pdf clean fonts

latex_exe  = xelatex
builddir   = build
includedir = ./include
TEXINPUTS  = .:$(includedir):

export TEXINPUTS

all: resume.pdf resume.current.pdf

resume.pdf: resume.tex
	mkdir -p $(builddir)
	$(latex_exe) --output-directory=$(builddir) resume.tex
	cp $(builddir)/resume.pdf resume.pdf

resume.current.pdf: resume.current.tex
	mkdir -p $(builddir)
	$(latex_exe) --output-directory=$(builddir) resume.current.tex
	cp $(builddir)/resume.current.pdf resume.current.pdf

fonts:
	test -d "$(HOME)/.fonts" || mkdir -p "$(HOME)/.fonts"
	test ! -d "fonts" || cp -v fonts/*/* "$(HOME)/.fonts/"
	fc-cache -fv

clean:
	rm -rf build/

# Note => Look into http://xpt.sourceforge.net/tools/latexmake/
