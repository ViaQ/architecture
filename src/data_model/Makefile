# Generate data model adoc parts from YAML definitions.
# The master Makefile will generate HTML for the website.

GOMPLATE=gomplate
YAMLS=$(wildcard model/*.yaml)
ADOCS=$(patsubst model/%.yaml,$(1)/%.part.adoc,$(YAMLS))

all: public/data_model.adoc private/data_model.adoc

clean: force
	rm -rf public private

%/data_model.adoc: data_model.adoc $(YAMLS)
	@mkdir -p $(dir $@)
	@cp data_model.adoc $@
	@for YAML in $(YAMLS); do \
	  ADOC=$$(basename -s .yaml $$YAML).part.adoc; \
	  echo $$YAML to $(dir $@)$$ADOC ; \
	  $(GOMPLATE) -c.=$$YAML -f adoc/namespace.gotmpl -t adoc/public.gotmpl -o $(dir $@)$$ADOC; \
	  echo -e "\ninclude::$$ADOC[]\n" >> $@ ; \
	done

.PHONY: force
