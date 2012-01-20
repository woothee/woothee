all: test

TIMESTAMP=$(shell date +%Y%m%d-%H%M%S)

checkyaml:
	perl ../bin/dataset_checker.pl

copy: checkyaml
	rm -f ./dataset*.yaml
	cp ../dataset.yaml ./dataset_$(TIMESTAMP).yaml

test: copy
	prove -Ilib
