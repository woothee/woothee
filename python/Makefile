all: test

TIMESTAMP=$(shell date +%Y%m%d-%H%M%S)

checkyaml:
	perl ../bin/dataset_checker.pl

lib/woothee/dataset.py: ../dataset.yaml
	python setup.py dataset
	sync; sync; sync

test: lib/woothee/dataset.py
	python setup.py test
