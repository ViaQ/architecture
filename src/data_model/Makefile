# Generate data model adoc parts from YAML definitions.
# The master Makefile will generate HTML for the website.

GOMPLATE=gomplate

YAMLS=$(wildcard model/*.yaml)
PUBLIC=$(patsubst model/%.yaml,public/gen/%.part.adoc,$(YAMLS))
PRIVATE=$(patsubst model/%.yaml,private/gen/%.part.adoc,$(YAMLS))

all: public/data_model.adoc private/data_model.adoc

clean: force
	rm -rf */gen

public/data_model.adoc: $(PUBLIC) public/gen/includes.part.adoc

public/gen/includes.part.adoc: $(PUBLIC)
	@mkdir -p $(dir $@); rm -f $@
	for f in $^; do echo -e "include::$$(basename $$f)[]\n" >> $@; done

public/gen/%.part.adoc: model/%.yaml adoc/*.gotmpl
	@mkdir -p $(dir $@)
	$(GOMPLATE) -c.=$< -f adoc/namespace.gotmpl -t adoc/public.gotmpl > $@


private/data_model.adoc: $(PRIVATE) private/gen/includes.part.adoc

private/gen/includes.part.adoc: $(PRIVATE)
	@mkdir -p $(dir $@); rm -f $@
	for f in $^; do echo -e "include::$$(basename $$f)[]\n" >> $@; done

private/gen/%.part.adoc: model/%.yaml adoc/*.gotmpl
	@mkdir -p $(dir $@)
	$(GOMPLATE) -c.=$< -f adoc/namespace.gotmpl -t adoc/private.gotmpl > $@

.PHONY: force
