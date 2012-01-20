all: test

TIMESTAMP=$(shell date +%Y%m%d-%H%M%S)

checkyaml:
	perl ../bin/dataset_checker.pl

lib/Woothee/DataSet.pm: ../dataset.yaml
	perl ../bin/dataset_yaml2pm.pl
	sync; sync; sync;

test: lib/Woothee/DataSet.pm
	prove -Ilib
