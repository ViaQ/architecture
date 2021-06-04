# Generate data model adoc parts from YAML definitions.
# The master Makefile will generate HTML for the website.

GOMPLATE=gomplate

YAMLS=$(wildcard model/*.yaml)
PUBLIC=$(patsubst model/%.yaml,public/%.part.adoc,$(YAMLS))
PRIVATE=$(patsubst model/%.yaml,private/%.part.adoc,$(YAMLS))

all: $(PUBLIC) $(PRIVATE)

clean: force
	rm -f */*.part.adoc

public/%.part.adoc: model/%.yaml $(MAKEFILE) public/*.gotmpl
	@mkdir -p $(dir $@)
	$(GOMPLATE) -c.=$< -f public/data_model.adoc.gotmpl > $@
	@touch public/data_model.adoc

private/%.part.adoc: model/%.yaml $(MAKEFILE) private/*.gotmpl
	@mkdir -p $(dir $@)
	$(GOMPLATE) -c.=$< -f private/data_model.adoc.gotmpl > $@
	@touch private/data_model.adoc

.PHONY: force
