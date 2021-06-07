BASE_NAME_TALK := talk

REVEALJS_VERSION := 4.1.0

.PHONY: all
all: html

reveal.js:
	wget https://github.com/hakimel/reveal.js/archive/$(REVEALJS_VERSION).tar.gz
	tar -xzf $(REVEALJS_VERSION).tar.gz
	rm $(REVEALJS_VERSION).tar.gz
	mv reveal.js-$(REVEALJS_VERSION) reveal.js
	patch -R -p0 < reveal.js-addons/revealjs.patch
	cp css/highlightjs-atom-one-light.css reveal.js/plugin/highlight/kvr.css

html: reveal.js
	pandoc -t revealjs -s $(BASE_NAME_TALK).md -o $(BASE_NAME_TALK).html -L reveal.js-addons/revealjs-codeblock.lua -V highlightjs -V highlightjs-theme:kvr -V revealjs-url=reveal.js -V theme=solarized -V transition=fade -V slideNumber=true --template reveal.js-addons/template.html --slide-level=2 -f 'markdown+emoji+subscript+superscript' --highlight-style=pygments --incremental --css css/pandoc-overrides.css

pdf: html
	yarn add puppeteer decktape
	$(shell yarn bin)/decktape -s 1920x1080 automatic file://$(shell pwd)/$(BASE_NAME_TALK).html $(BASE_NAME_TALK).pdf

remove-speaker-notes:
	tools/RemoveSpeakerNotes $(BASE_NAME_TALK).html

clean:
	rm -rf package.json yarn.lock reveal.js/ node_modules/ $(BASE_NAME_TALK).html $(BASE_NAME_TALK).pdf
