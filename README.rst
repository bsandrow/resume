======
resume
======

Generating Resume
-----------------

Just run: ::

    make build-pdfs

All of the intermediate build files will be contained in build/ and the
resume.pdf file will be copies into the source root dir.

Makefile Targets
----------------

The following are valid Makefile targets: ::

    all             Runs build-pdfs and build-txts
    build-pdfs      Builds all .pdf files for .tex files in templates/
    build-txts      Builds all .txt files for .tex files in templates/
    fonts           Install necessary fonts (in fonts/) to ~/.fonts/
    clean           Cleans up intermediate build files.

Structure
---------

A brief description of the repo structure: ::

    include/    This path is added to the set of paths that LaTeX will use to
                include imported TeX resources.

    libraries/  Storage for 3rd-party libraries that I'm using. This is
                basically a mirror, because (IIRC) some of these are only
                available through blog posts (e.g. include/resume.cls is from a
                blog post) which may or may not exist in the future.

    build/      Temporary directory for output + intermediate files from
                building PDFs. Is removed with `make clean`.

    fonts/      Non-standard fonts that are used in building resumes. They can
                be installed to ~/.fonts with `make fonts`.

    templates/  Templates in Jinja2 for building .tex files. Components that
                are not meant to be used directly get a .j2 extention, while
                components that *are* meant to be use directly end in .tex.
                This makes it easy for make to auto-build it's dependency graph
                without needing an explicit whitelist.

    tools/      A place to drop helper scripts. The intention is to use helper
                scripts to bolster Makefile targets, so calling these directly
                shouldn't be necessary.

