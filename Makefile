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
ifeq (, $(shell which linkchecker 2> /dev/null))
	$(warning WARNING: linkchecker not found, skipping HTML link checks)
else
	linkchecker --check-extern docs/index.html
endif
ifeq (, $(shell which yamllint 2> /dev/null))
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
HTMLS=$(patsubst src/%.adoc,docs/%.html,$(ADOCS))
DOTS=$(shell find src -name '*.dot')
SVGS=$(patsubst src/%.dot,docs/%.svg,$(DOTS))

docs: $(SVGS) data_model
	$(MAKE) $(HTMLS)	# Evaluate $(HTMLS) after data_model has run

preview: docs
	xdg-open ./docs/index.html; sleep 1 # Sleep to give the browser time to start, else it is killed.

data_model: force
	$(MAKE) -C src/data_model all

docs/%/index.html: src/%/*.adoc

docs/%.html: src/%.adoc
	@mkdir -p $(dir $@)
	$(ASCIIDOCTOR) -o $@ $<

docs/%.svg: src/%.dot
	@mkdir -p $(dir $@)
	$(DOT) $< -o $@


.PHONY: force
