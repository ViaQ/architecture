## Generate the website in docs/

# Parameters
BROWSE ?= index.html

# Commands
	ASCIIDOCTOR=asciidoctor --failure-level=WARN \
		-a icons=font -a nofooter \
		-a stylesheet=$(PWD)/css/asciidoctor.css
DOT=dot -Tsvg


rebuild: clean all
	@echo "Clean rebuild, you can commit the updated site."

all: check

check: docs
ifeq (, $(shell which linkchecker))
	$(warning WARNING: linkchecker not found, skipping HTML link checks)
else
	linkchecker --check-extern docs/index.html
endif
ifeq (, $(shell which yamllint))
	$(warning WARNING: yamllint not found, skipping YAML cleanliness checks)
else
	yamllint -f parsable -d "{spaces:2}" $(shell find -name '*.yaml')
endif


browse: docs
	nohup xdg-open docs/$(BROWSE) &> /dev/null ; sleep 1

clean:
	rm -rf docs
	$(MAKE) -C src/data_model clean

# Sources
ADOCS=$(shell find src -name '*.adoc' | fgrep -v .part.adoc)
DOTS=$(shell find src -name '*.dot')

# Generated output
HTMLS=$(patsubst src/%.adoc,docs/%.html,$(ADOCS))
SVGS=$(patsubst src/%.dot,docs/%.svg,$(DOTS))

docs: $(HTMLS) $(SVGS) $(PNG_DOCS) data_model

docs/%/index.html: src/%/*.adoc

docs/%.html: src/%.adoc $(MAKEFILE)
	@mkdir -p $(dir $@)
	$(ASCIIDOCTOR) -o $@ $<

docs/%.svg: src/%.dot
	@mkdir -p $(dir $@)
	$(DOT) $< -o $@

docs/%.png: src/%.png
	@mkdir -p $(dir $@)
	cp $< $@

data_model: force
	$(MAKE) -C src/data_model all

.PHONY: force
