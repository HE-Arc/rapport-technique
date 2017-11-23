.phony: all
all: rapport.pdf

%.pdf: %.md
	pandoc $^ \
		--standalone \
		--from markdown+smart \
		--to latex \
		--pdf-engine xelatex \
		--lua-filter english.lua \
		--filter pandoc-crossref \
		--filter pandoc-citeproc \
		--output $@
