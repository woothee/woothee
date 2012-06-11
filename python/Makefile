all: test

TIMESTAMP=$(shell date +%Y%m%d-%H%M%S)

checkyaml:
	perl ../bin/dataset_checker.pl

lib/woothee/dataset.py: ../dataset.yaml
	PYTHONPATH=$PYTHONPATH:PyYAML-3.10-py2.7-macosx-10.7-intel.egg python ../bin/dataset_yaml2py.py
	sync; sync; sync

test: lib/woothee/dataset.py
	python setup.py test
