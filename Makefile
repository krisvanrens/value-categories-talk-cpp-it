OUTPUT_NAME := talk

REVEALJS_VERSION := 3.9.2

.PHONY: all
all: html

reveal.js:
	wget https://github.com/hakimel/reveal.js/archive/$(REVEALJS_VERSION).tar.gz
	tar -xzf $(REVEALJS_VERSION).tar.gz
	rm $(REVEALJS_VERSION).tar.gz
	mv reveal.js-$(REVEALJS_VERSION) reveal.js
	patch -R -p0 < revealjs.patch

html: reveal.js
	pandoc -t revealjs -s $(OUTPUT_NAME).md -o $(OUTPUT_NAME).html -V revealjs-url=reveal.js -V theme=solarized -V transition=fade -V slideNumber=true --slide-level=2 -f 'markdown+emoji' --highlight-style=pygments --incremental

pdf: html
	npm i decktape
	$(shell npm bin)/decktape -s 1920x1080 automatic file://$(shell pwd)/$(OUTPUT_NAME).html $(OUTPUT_NAME).pdf

clean:
	rm -rf reveal.js/ $(OUTPUT_NAME).html $(OUTPUT_NAME).pdf
