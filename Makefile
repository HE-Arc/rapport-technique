.phony: all
all: rapport.pdf rapport-gyre.pdf rapport-cros.pdf

%.pdf: %.md
	pandoc $^ \
		--standalone \
		--from markdown+smart \
		--to latex \
		--pdf-engine xelatex \
		--lua-filter english.lua \
		--filter pandoc-crossref \
		--filter pandoc-citeproc \
		--variable documentclass=scrreprt \
		--variable mainfont="Linux Libertine O" \
		--variable sansfont="Linux Biolinum O" \
		--variable monofont="Inconsolata" \
		--output $@

%-gyre.pdf: %.md
	pandoc $^ \
		--standalone \
		--from markdown+smart \
		--to latex \
		--pdf-engine xelatex \
		--lua-filter english.lua \
		--filter pandoc-crossref \
		--filter pandoc-citeproc \
		--variable documentclass=report \
		--variable mainfont="TeX Gyre Pagella" \
		--variable monofont="TeX Gyre Cursor" \
		--output $@

%-cros.pdf: %.md
	pandoc $^ \
		--standalone \
		--from markdown+smart \
		--to latex \
		--pdf-engine xelatex \
		--lua-filter english.lua \
		--filter pandoc-crossref \
		--filter pandoc-citeproc \
		--variable documentclass=scrreprt \
		--variable mainfont="Carlito" \
		--variable sansfont="Tinos" \
		--variable monofont="Cousine" \
		--output $@
