BASE_NAME_TALK := talk
SNAPSHOTS_DIR := snapshots
TALK_SUBJECT := $(shell basename $(shell pwd))

SNAPSHOT_NAME := $(shell date +'%Y-%m-%dT%H%M')

REVEALJS_VERSION := 4.6.0

.PHONY: all
all: html

reveal.js:
	curl -L https://github.com/hakimel/reveal.js/archive/$(REVEALJS_VERSION).tar.gz -o $(REVEALJS_VERSION).tar.gz
	tar -xzf $(REVEALJS_VERSION).tar.gz
	rm $(REVEALJS_VERSION).tar.gz
	mv reveal.js-$(REVEALJS_VERSION) reveal.js
	patch -R -p0 < reveal.js-addons/revealjs.patch
	cp css/highlightjs-atom-one-light.css reveal.js/plugin/highlight/kvr.css

html: reveal.js
	pandoc -t revealjs -s $(BASE_NAME_TALK).md -o $(BASE_NAME_TALK).html -L reveal.js-addons/revealjs-codeblock.lua -V highlightjs -V highlightjs-theme:kvr -V revealjs-url=reveal.js -V theme=solarized -V transition=fade -V slideNumber=true -V width=1280 -V height=720 -V pdfSeparateFragments=false --template reveal.js-addons/template.html --slide-level=2 -f 'markdown+emoji+subscript+superscript+tex_math_dollars+simple_tables' --highlight-style=pygments --incremental --css css/pandoc-overrides.css --mathjax='https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js' --embed-resources --standalone

pdf: html
	yarn add puppeteer decktape
	$(shell yarn bin)/decktape reveal --chrome-path "/usr/bin/google-chrome" --pdf-author "Kris van Rens" --pdf-title "$(TALK_SUBJECT)" --pdf-subject "$(TALK_SUBJECT)" -s 1920x1080 file://$(shell pwd)/$(BASE_NAME_TALK).html $(BASE_NAME_TALK).pdf

snapshot: html pdf
	mkdir -p $(SNAPSHOTS_DIR)/$(SNAPSHOT_NAME)
	cp -r $(BASE_NAME_TALK).html $(BASE_NAME_TALK).pdf $(SNAPSHOTS_DIR)/$(SNAPSHOT_NAME)/

remove-speaker-notes:
	tools/RemoveSpeakerNotes $(BASE_NAME_TALK).html

clean:
	rm -rf package.json yarn.lock reveal.js/ node_modules/ $(BASE_NAME_TALK).html $(BASE_NAME_TALK).pdf
