# Generate data model adoc parts from YAML definitions.
# The master Makefile will generate HTML for the website.

GOMPLATE=gomplate

YAMLS=$(wildcard model/*.yaml)
PUBLIC=$(patsubst model/%.yaml,public/%.part.adoc,$(YAMLS))
PRIVATE=$(patsubst model/%.yaml,private/%.part.adoc,$(YAMLS))

all: $(PUBLIC) $(PRIVATE)

clean: force
	rm -f */*.part.adoc

public/%.part.adoc: model/%.yaml $(MAKEFILE) adoc/*.gotmpl
	@mkdir -p $(dir $@)
	$(GOMPLATE) -c.=$< -t adoc/fields.gotmpl -f adoc/public.gotmpl > $@
	@touch public/data_model.adoc

private/%.part.adoc: model/%.yaml $(MAKEFILE) adoc/*.gotmpl
	@mkdir -p $(dir $@)
	$(GOMPLATE) -c.=$< -t adoc/fields.gotmpl -f adoc/private.gotmpl > $@
	@touch private/data_model.adoc

.PHONY: force
